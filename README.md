# A prediction model for uncontrolled type 2 diabetes mellitus incorporating area-level social determinants of health

Sanjay Basu1,2*, Rajiv Narayanaswamy3


1 Research and Analytics, Collective Health
2 School of Public Health, Imperial College London
3 KPMG LLP

*Email: s.basu@imperial.ac.uk


Background
Social determinants of health at the area level are understood to influence the likelihood of having poor glycemic control for patients with type 2 diabetes mellitus.

Objectives
We sought to develop a model for predicting whether a person with type 2 diabetes mellitus has uncontrolled diabetes (defined as a hemoglobin A1c >9%), incorporating both individual characteristics and area-level social determinants of health.
 
Research Design
We developed and validated machine learning models for prediction, training generalized linear models, random forests, gradient boosting machines, deep learning neural networks, and ensembles of models on a random 75% sample of participants in the available data, with testing on the remaining 25%.

Subjects
N = 1,015,808 privately-insured persons in claims data with type 2 diabetes mellitus and at least one hemoglobin A1c measurement across all 50 states, Washington D.C., and Puerto Rico, linked to census tract-level U.S. Census and Centers for Disease Control data on social determinants of health.

Measures
Covariates eligible for inclusion included—at the individual level—age, sex, diagnostic and procedure codes, duration of insurance enrollment and duration of diabetes diagnosis, and—at the census-tract level—healthy food availability, food insecurity, recreational park access and 33 other covariates theoretically related to glycemic control of diabetes per prior literature. Outcome metrics for assessing quality of the risk prediction models included the C-statistic, sensitivity, specificity, positive predictive value, negative predictive value, and accuracy of each model.

Results
A standard logistic regression model selecting among the available individual-level covariates and area-level SDH covariates performed poorly, with a C-statistic of 0.685 (cross-validated 95% CI: 0.683, 0.687), sensitivity of 25.6% (95% CI: 24.4, 26.8), specificity of 90.1% (95% CI: 90.0, 90.2), positive predictive value (precision) of 56.9% (95% CI: 56.8, 57.0), negative predictive value of 70.4% (95% CI: 70.3, 70.5), and accuracy of 68.4% (95% CI: 68.3, 68.5) on the hold-out validation test data. By contrast, machine learning models improved upon risk prediction, with the highest performance from a random forest with a C-statistic of 0.928 (95% CI: 0.927, 0.929), sensitivity of 68.5% (95% CI: 66.4, 70.6), specificity of 94.6% (95% CI: 93.9, 95.3), positive predictive value of 69.8% (95% CI: 67.8, 71.8), negative predictive value of 94.3% (95% CI: 92.3, 96.3), and accuracy of 90.6% (95% CI: 90.2, 91.0). The random forest model included individual-level variables of age, sex, and diagnostic codes, and SDH variables including area segregation, drug overdose mortality rate, and income inequality. The random forest model was able to explain 41.0% of the variation in the outcome (R2) across tracts in the validation test dataset; the SDH variables alone explained 16.9% of the total observed variation (41.2% of the explained variation). The model estimated wide variations in predicted probability of uncontrolled T2DM due to area-level SDH variations alone; for example, a 50-year-old female with T2DM without a prior history of microvascular complications had a 17.8% predicted probability on average nationwide, but an interquartile range varied from 10.8% to 23.4% across census tracts.

Conclusions
A generalizable predictive model developed through a machine learning approach may assist healthcare organizations to identify which area-level SDH data to monitor for prediction of diabetes control, for potential use in risk-adjustment of healthcare payments and targeting of community-based interventions. 
