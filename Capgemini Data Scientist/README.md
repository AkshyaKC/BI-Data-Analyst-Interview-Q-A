Capgemini Data Scientist Interview Questions & Strategic Approach (1-3 Years Experience)
CTC: 18 LPA

These 3 questions were part of my friend’s Capgemini Data Science interview.

1️⃣ How do you handle missing data in a dataset?

This should be your Approach:👇

1/ Identify missing values – Use df.isnull().sum() to inspect missing data per column.
2/ Assess impact – Check whether missingness is MCAR (completely at random), MAR (at random), or MNAR (not at random).
3/ Apply appropriate strategies:
-Drop missing rows/columns if the proportion is minimal and won't affect results.
-Use statistical imputation (mean/median/mode) for numerical or categorical features.
-Implement advanced techniques like KNN imputation, MICE, or model-based methods for crucial features.
-For time series data, use forward/backward fill or interpolation.

2️⃣ How do you build and optimize a predictive model?

This should be your Approach:👇

1/ Preprocess data – Handle nulls, encode categorical variables, scale numerical features.
2/ Select model – Based on problem type: regression, classification, clustering, etc.
3/ Train and validate – Use cross-validation to avoid overfitting.
4/ Evaluate performance – Choose metrics like RMSE, F1-score, AUC-ROC based on the use case.
5/ Tune hyperparameters – Use Grid Search, Random Search, or Bayesian Optimization.
6/ Deploy & monitor – Package the model, monitor predictions, and track performance drift.

3️⃣ How do you measure the impact of a new ML model or feature in production?

This should be your Approach:👇

1/ Define success metrics – Accuracy, latency, business KPIs, user engagement, etc.
2/ Deploy via A/B testing or shadow mode – Compare new model against baseline.
3/ Monitor real-world performance – Track performance metrics and drift.
4/ Conduct statistical tests – Use hypothesis testing to ensure changes are significant.
5/ Gather user/business feedback – Incorporate qualitative insights alongside quantitative metrics.

One wrong approach or poorly framed answer can cost you a great opportunity. Answering these questions effectively requires a solid understanding of core Data Science concepts.

Before your next interview, make sure to clear all your doubts and strengthen your fundamentals—this can significantly boost your chances of landing the role.
