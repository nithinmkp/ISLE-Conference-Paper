/*-------------------------------------
File: 01_hh-cleaning.do
Purpose: clean household files
Author: Krishna
pre-requiste: 00-master.do
date: put date here (latest date)
----------------------------------------*/

version 13 // important for backward compatibility

// Data
use "$raw/Conference Data Kerala HH.dta", clear

// Describe
describe hhid

// Total HH Income incorporates income from all sources.
summarize Total_HH_income, detail
count if missing(Total_HH_income)
list hhid Total_HH_income if missing(Total_HH_income)

// Summarise and tabulate


summarize ad802, detail //ad802 is value of financial assets
// adoo7 is the asking if HH owns any financial asset
tab ad007 // Tabulate own financial assets
tab ad007 if missing(ad802)


gen fin_assets = ad802 // Create dummy variable
replace fin_assets = 0 if ad007 == 2
count if missing(fin_assets)
summarize fin_assets, detail

//ad706 is the value of non financial ssets
summarize ad706, detail
//lookfor non-financial
tab ad705x, missing
tab ad705x if missing(ad706), missing
gen nonfin_assets = ad706
replace nonfin_assets = 0 if ad705x == 1
count if missing(nonfin_assets)

keep hhid Total_HH_income fin_assets nonfin_assets

//created a new HH file with only hhid and the remaining 3 varaibles

save "$clean/Conference Data Kerala HH_Clean.dta", replace
