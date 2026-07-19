/*-------------------------------------
File: 02_ind_merge.do
Purpose: merge data
Author: Krishna
pre-requiste: 00-master.do, 01-hh-cleaning.do
date: put date here (latest date)
----------------------------------------*/

version 13 // important for backward compatibility

// Data
use "$raw/Conference Data Kerala Individual.dta", clear

// Merging Individual data file with the cleaned household file, where only 4 variables are there
merge m:1 hhid using "$clean/Conference Data Kerala HH_Clean.dta"
save "$clean/Conference Data Kerala_Merged.dta", replace // save data

