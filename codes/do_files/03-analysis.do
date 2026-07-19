/*-------------------------------------
File: 03_analysis.do
Purpose: clean household files
Author: Krishna
pre-requiste: 00-master.do, 01-hh-cleaning.do, 02_ind_merge.do
date: put date here (latest date)
----------------------------------------*/

version 13 // important for backward compatibility

// Data
use "$clean/Conference Data Kerala_Merged.dta", clear


// First Variable is migration categories i did not understand
//fs210_1 indicates Place of residence_child

tab fs210_1, missing // tabulate

// 4 categories have created, no migrant kid, inter state migrant, international migrant, both internal and international (Variable name: migrant_category)
gen migration4 = . // generate blank variable
replace migration4 = 0 if internal_migrant == 0 & international_migrant == 0 //0 = No migrant child
replace migration4 = 1 if internal_migrant == 1 & international_migrant == 0 //  1 = Interstate migrant child only
replace migration4 = 2 if internal_migrant == 0 & international_migrant == 1 // International migrant child only
replace migration4 = 3 if internal_migrant == 1 & international_migrant == 1 // Both interstate and international migrant children


// label variables
label define mig4lbl 0 "No migrant child" 1 "Interstate migrant child only" 2 "International migrant child only" 3 "Both interstate and international migrant children"
label values migration4 mig4lbl

// Tabulate
tab migration4
rename migration4 migrant_category


Next variable is Marital Status (marital_status)
tab dm021, missing
gen marital3 = .
replace marital3 = 1 if dm021 == 1
replace marital3 = 2 if dm021 == 2
replace marital3 = 3 if inlist(dm021, 3, 4, 5, 6, 7)
label define marital3lbl 1 "Married" 2 "Widowed" 3 "Others"
label values marital3 marital3lbl
tab marital3
rename marital3 marital_status


Variable is Education level
gen education_level = .
replace education_level = 1 if inlist(dm008,1,2)
replace education_level = 2 if inlist(dm008,3,4)
replace education_level = 3 if inlist(dm008,5,6)
replace education_level = 4 if inlist(dm008,7,8,9)
label define edulbl 1 "Primary or Less" 2 "Middle & Secondary" 3 "Higher Secondary/Diploma" 4 "Graduate & Above"
label values education_level edulbl
label variable education_level "Educational attainment"
tab education_level, missing


Variable: Age
age is in years


Variable: Sex of the respondent
gen sex = dm003
label define sexlbl 1 "Male" 2 "Female"
label values sex sexlbl
label variable sex "Sex"


Variable: Religion
gen religion3 = .
replace religion3 = 1 if religion == 1   
replace religion3 = 2 if religion == 2   
replace religion3 = 3 if religion == 3   
label define rel3lbl 1 "Hindu" 2 "Muslim" 3 "Christian", replace
label values religion3 rel3lbl
label variable religion3 "Religion"
tab religion3, missing


Variable: Caste
gen social_group = .
replace social_group = 1 if dm013 == 1
replace social_group = 2 if dm013 == 2
replace social_group = 3 if dm013 == 3
replace social_group = 4 if dm013 == 4
label define sociallbl 1 "Scheduled Caste" 2 "Scheduled Tribe" 3 "Other Backward Class" 4 "General"
label values social_group sociallbl
label variable social_group "Social group"
tab social_group, missing


Variable: Residence
gen place_residence = .
replace place_residence = 1 if residence == 1
replace place_residence = 2 if residence == 2
label define placelbl 1 "Rural" 2 "Urban"
label values place_residence placelbl
label variable place_residence "Place of residence"
tab place_residence


Variable: Health Insurance
gen health_insurance = .
replace health_insurance = 1 if hc102 == 1
replace health_insurance = 0 if hc102 == 2
label define hinslbl 0 "No" 1 "Yes"
label values health_insurance hinslbl
label variable health_insurance "Covered by health insurance"
tab health_insurance


Variable: Self Related Health
gen self_rated_health = .
* Good = Excellent + Very Good + Good
replace self_rated_health = 1 if inlist(ht001_a, 1, 2, 3)
* Fair
replace self_rated_health = 2 if ht001_a == 4
* Poor
replace self_rated_health = 3 if ht001_a == 5
label define srhlbl 1 "Good" 2 "Fair" 3 "Poor", replace
label values self_rated_health srhlbl
label variable self_rated_health "Self-rated health"
tab self_rated_health, missing


Variable: Living arrangement
tab living_arrangements, missing


Economic Resources in the data set are these 3 (Total_HH_income fin_assets nonfin_assets)
summarize Total_HH_income fin_assets nonfin_assets, detail
Household Economic Vulnerability was measured using a composite index based on annual household income, financial assets, and non-financial assets. 
Given the highly skewed distributions of these variables, natural logarithmic transformations [ln(x + 1)] were applied. 
The transformed variables were standardized into z-scores to ensure comparability. 
An Economic Security Index was computed as the arithmetic mean of the three standardized indicators. 
The index was then multiplied by -1 to derive the Household Economic Vulnerability Index (HEVI), such that higher values indicate greater economic vulnerability. 
Principal component analysis was conducted as a robustness check, with the first principal component explaining 45.8% of the total variance and showing positive loadings for all three indicators, supporting the construction of a composite measure.


gen ln_income        = ln(Total_HH_income + 1)
gen ln_fin_assets    = ln(fin_assets + 1)
gen ln_nonfin_assets = ln(nonfin_assets + 1)

standardised these three variables
egen z_income = std(ln_income)
egen z_fin_assets = std(ln_fin_assets)
egen z_nonfin_assets = std(ln_nonfin_assets)
gen economic_security = (z_income + z_fin_assets + z_nonfin_assets)/3 if hevi_sample == 1
gen HEVI = -economic_security if hevi_sample == 1


REGRESSION ANALYSIS
* Outcome Variable: Household Economic Vulnerability Index (HEVI)

Model 1: Unadjusted Model
reg HEVI i.migrant_category, vce(robust)

Model 2: Demographic Model
reg HEVI i.migrant_category c.age i.sex, vce(robust)

Model 3: Socio-economic Model
reg HEVI i.migrant_category c.age i.sex i.education_level i.religion3 i.social_group i.place_residence, vce(robust)

Model 4: Fully Adjusted Model (Final Model)
reg HEVI i.migrant_category c.age i.sex i.education_level i.religion3 i.social_group i.place_residence i.living_arrangement i.health_insurance i.self_rated_health, vce(robust)

estat vif






