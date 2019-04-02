library(readxl)
setwd("~/Data/chrd")
load("chrd_sub")
setwd("~/Documents/Epi/Research/NCDs/T2DM/SDH_T2DM")
library(readr)
dm <- read_csv("~/Data/cta1c.csv") #pt-level data, deidentified
dm_sub = dm %>%
  filter(str_sub(Diag1,1L,3L)==250) %>%
  select(Diag1,Year,Gdr_Cd,Rslt_Nbr,Yrdob,GEOID)
dm_sub$Diag1=as.factor(dm_sub$Diag1)
dm_sub$Year = as.numeric(dm_sub$Year)
dm = left_join(dm_sub,chrd_sub) %>%
  mutate(Rslt_Nbr = ((Rslt_Nbr)>=(9)))


library(h2o)
h2o.init(max_mem_size="32g")
dm = as.h2o(dm)
dm.split <- h2o.splitFrame(data=dm, ratios=0.75)
train <- dm.split[[1]]
test <- dm.split[[2]]

y <- "Rslt_Nbr"
x <- setdiff(names(train), c(y,"Diag1","Yrdob","Gdr_Cd","GEOID","yr","Year","% Free or Reduced Lunch","% Limited Access"))
train[,y] <- as.factor(train[,y])
test[,y] <- as.factor(test[,y])

nfolds <- 5

genlin = h2o.glm(x = x, y = y,training_frame = train, validation_frame = test, family = c("binomial"),nfolds = 5, seed=1)
print(genlin) 
as.data.frame(genlin@model$coefficients_table)
model_path_1 <- h2o.saveModel(genlin, path=getwd(), force=TRUE)

aml <- h2o.automl(x = x, y = y,training_frame = train, validation_frame = test, max_runtime_secs = 600)
aml@leaderboard


grf = h2o.randomForest(x = x, y = y,training_frame = train, validation_frame = test,nfolds = 5, seed=1)
print(grf) 
as.data.frame(h2o.varimp(grf))
h2o.r2(grf,valid=T)
h2o.partialPlot(object =grf, data = train, cols = c("Segregation index"))



gbm = h2o.gbm(x = x, y = y,training_frame = train, validation_frame = test,nfolds = 5, seed=1)
print(gbm) 


xgb = h2o.xgboost(x = x, y = y,training_frame = train, validation_frame = test,nfolds = 5, seed=1)
print(xgb)

dnn = h2o.deeplearning(x = x, y = y,training_frame = train, validation_frame = test,nfolds = 5, seed=1)
print(dnn)


require(maps)
require(ggmap)
map("county")

data(county.GEOID)

colors = c( "#fdd49e", "#fdbb84", "#fc8d59", "#e34a33","#b30000")

dmparty = chrd_sub
dmparty$Year = 2011
dmparty$Yrdob = 2011-50
dmparty$Diag1 = 25000
dmparty$Gdr_Cd = 'F'

dmpartyh = as.h2o(dmparty)
pred <- predict(grf, dmpartyh)[,3] ## class-1 probability

dmparty$pcchange = as.vector(pred)

dmparty$colorBuckets <- as.numeric(cut(dmparty$pcchange, c(-10,.075,.15,.225,.3,10)))

colorsmatched <- dmparty$colorBuckets[match(county.GEOID$GEOID, as.numeric(dmparty$GEOID))]

map("county", col = colors[colorsmatched], fill = TRUE, resolution = 0, 
    lty = 0, projection = "polyconic")


map("state", col = "white", fill = FALSE, add = TRUE, lty = 1, lwd = 0.2, 
    projection = "polyconic")
title(expression("Predicted probability that diabetes is uncontrolled (A1c">="9%) for a 50yo woman"))

leg.txt <- c("0-7.5%", "7.5-15%", "15-22.5%", "22.5-30%",">30%")
legend("bottomright", leg.txt, horiz = F, pch="", cex=0.85, fill = colors, title = c("Predicted probability"))
