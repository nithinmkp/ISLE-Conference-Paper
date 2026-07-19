/*-------------------------------------
File: 00_master.do
Purpose: Set project roots
Author: Nithin M
----------------------------------------*/

version 13

// Prelims
set more off
set varabbrev off
clear all
macro drop _all
set maxvar 12000

// Set directory
here, set

// Folder paths
global raw       "data/raw"
global clean     "data/clean"
global inter     "data/inter"
global resources "resources"
global dofiles   "codes/stata/do_files"
global logs      "codes/stata/logs"
global programs  "codes/stata/programs"
global output    "output"
global figs      "output/figures"
global tables    "output/tables"

// Create project folders if they do not exist
capture mkdir "data"
capture mkdir "$raw"
capture mkdir "$clean"
capture mkdir "$inter"

capture mkdir "codes"
capture mkdir "codes/stata"
capture mkdir "$dofiles"
capture mkdir "$logs"

capture mkdir "$resources"

capture mkdir "$output"
capture mkdir "$figs"
capture mkdir "$tables"

// Create local PLUS directory if missing
capture mkdir "plus"

// Set ado paths
adopath ++ "$programs"

// Redirect PLUS directory
local oldplus : sysdir PLUS
sysdir set PLUS "${here}/plus"

// Restore if desired
// sysdir set PLUS "`oldplus'"