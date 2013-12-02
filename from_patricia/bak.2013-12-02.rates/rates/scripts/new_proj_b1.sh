#!/bin/sh

# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#
# new_proj_b1.sh
#
# This shell script (put together by Patricia Solvignon) plots 
# b1 based on the outputs of ../ptrates.
#	Right now, it's plotting the following:
#		A bunch of theory curves
#		HERMES b1 data points
#		Projected HMS b1 points
#		Projected SHMS b1 points
#
# Future work needs to include better b1 systematic uncertainties,
# as they are currently all set to 1 (100%).
#
#
# Elena Long
# ellie@jlab.org
# 4/2/2013
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

file0="../../models/SCRIPTS/table2.dat"
awk '$1!="#" {print $1,$6,$7}' $file0 > xb1_stat
awk '$1!="#" {print $1,$6,sqrt($7*$7+$8*$8)}' $file0 > xb1_tot

file1="../../models/output/b1model_kumano.dat"
awk '$1==1 && $2!=0.0{print $2,$6/$2}' $file1 > model_nosea_cteq
awk '$1==1 && $2!=0.0 {print $2,$10/$2}' $file1 > model_sea_cteq
awk '$1==2 && $2!=0.0 {print $2,$6/$2}' $file1 > model_nosea_mrst
awk '$1==2 && $2!=0.0 {print $2,$10/$2}' $file1 > model_sea_mrst
awk '$1==3 && $2!=0.0 {print $2,$6/$2}' $file1 > model_nosea_mstw
awk '$1==3 && $2!=0.0 {print $2,$10/$2}' $file1 > model_sea_mstw

file2="../../models/Miller_newtable/miller_nov11_2010.dat"
awk '$1!=0.9 {print $2,$3}' $file2 > model_miller

file3="../../models/output/b1model_sargsian.dat"
awk '$1==1 && $2>=0.15 {print $2,$4/$2}' $file3 > model_sargsian_vn
awk '$1==1 && $2>=0.15 {print $2,$6/$2}' $file3 > model_sargsian_lc

file5="../../models/output/b1model_bacchetta.dat"
awk '$1==1 && $2!=0.0{print $2,$4/$2}' $file5 > model_bacchetta_low
awk '$1==1 && $2!=0.0{print $2,$5/$2}' $file5 > model_bacchetta_up


file4="../output/prop_table.out"
awk '$1==1 {print $2,$10,$11}' $file4 > hms_stat
awk '$1==2 {print $2,$10,$11}' $file4 > shms_stat
awk '$1==1 {print $2,$10,sqrt($11*S11)}' $file4 > hms_tot
awk '$1==2 {print $2,$10,sqrt($11*S11)}' $file4 > shms_tot
# The two lines below are temporarily commented out until we have
# a better handle on the systematic uncertainties ($14)
#awk '$1==1 {print $2,$10,sqrt($11*S11+$14*$14)}' $file4 > hms_tot
#awk '$1==2 {print $2,$10,sqrt($11*S11+$14*$14)}' $file4 > shms_tot

# This fills files that will be used to make bar graphs of the 
# rates vs x_Bjorken
awk '$1==1 {print $2,$7}' $file4 > hms_rates
awk '$1==2 {print $2,$7}' $file4 > shms_rates

# This fills files that will be used to make bar graphs of the 
# time needed vs x_Bjorken
awk '$1==1 {print $2,$12}' $file4 > hms_time
awk '$1==2 {print $2,$12}' $file4 > shms_time


#file3="../output/rates.out"
#awk '$1==2 {print $3,$16}' $file3 > syst
awk '{print $2,$14}' $file4 > syst

#xmgrace -free -settype xy   -block model_miller         -graph 0 -bxy 1:2 \
#              -settype xy   -block model_nosea_mstw     -graph 0 -bxy 1:2 \
#              -settype xy   -block model_sea_mstw       -graph 0 -bxy 1:2 \
#              -settype xy   -block model_sargsian_vn    -graph 0 -bxy 1:2 \
#              -settype xy   -block model_sargsian_lc    -graph 0 -bxy 1:2 \
#              -settype xy   -block model_bacchetta_low  -graph 0 -bxy 1:2 \
#              -settype xy   -block model_bacchetta_up   -graph 0 -bxy 1:2 \
#              -settype xydy -block xb1_tot              -graph 0 -bxy 1:2:3 \
#              -settype xydy -block xb1_stat             -graph 0 -bxy 1:2:3 \
#              -settype xydy -block hms_tot              -graph 0 -bxy 1:2:3 \
#              -settype xydy -block hms_stat             -graph 0 -bxy 1:2:3 \
#              -settype xydy -block shms_tot             -graph 0 -bxy 1:2:3 \
#              -settype xydy -block shms_stat            -graph 0 -bxy 1:2:3 \
#			  -settype bar	-block hms_rates			-graph 1 -bxy 1:2 \
#			  -settype bar	-block shms_rates			-graph 1 -bxy 1:2 \
#			  -settype bar	-block hms_time		-log y	-graph 2 -bxy 1:2 \
#			  -settype bar	-block shms_time 	-log y	-graph 2 -bxy 1:2 \
#              -p b1_proj_new.par -noask

#gracebat -hdevice EPS -printfile b1_proj_new.eps \
#gracebat -hdevice PNG -printfile b1_hms_smhs_rates.png \
xmgrace \
              -settype xy   -block model_miller         -graph 0 -bxy 1:2 \
              -settype xy   -block model_nosea_mstw     -graph 0 -bxy 1:2 \
              -settype xy   -block model_sea_mstw       -graph 0 -bxy 1:2 \
              -settype xy   -block model_sargsian_vn    -graph 0 -bxy 1:2 \
              -settype xy   -block model_sargsian_lc    -graph 0 -bxy 1:2 \
              -settype xy   -block model_bacchetta_low  -graph 0 -bxy 1:2 \
              -settype xy   -block model_bacchetta_up   -graph 0 -bxy 1:2 \
              -settype xydy -block xb1_tot              -graph 0 -bxy 1:2:3 \
              -settype xydy -block xb1_stat             -graph 0 -bxy 1:2:3 \
              -settype xydy -block hms_tot              -graph 0 -bxy 1:2:3 \
              -settype xydy -block hms_stat             -graph 0 -bxy 1:2:3 \
              -settype xydy -block shms_tot             -graph 0 -bxy 1:2:3 \
              -settype xydy -block shms_stat            -graph 0 -bxy 1:2:3 \
			  -settype bar	-block hms_rates			-graph 1 -bxy 1:2 \
			  -settype bar	-block shms_rates			-graph 1 -bxy 1:2 \
			  -settype bar	-block hms_time		-log y	-graph 2 -bxy 1:2 \
			  -settype bar	-block shms_time 	-log y	-graph 2 -bxy 1:2 \
              -p b1_proj_new.par -noask

#xmgrace	-free -settype bar	-block hms_rates			-graph 0 -bxy 1:2 \
#			  -settype bar	-block shms_rates			-graph 0 -bxy 1:2 \
#			  -settype bar	-block hms_time		-log y	-graph 1 -bxy 1:2 \
#			  -settype bar	-block shms_time 	-log y	-graph 1 -bxy 1:2 \
#			  -p rates.par	-noask	
#gracebat -hdevice PNG -printfile b1_rates.png \
#			  -settype bar	-block hms_rates			-graph 0 -bxy 1:2 \
#			  -settype bar	-block shms_rates			-graph 0 -bxy 1:2 \
#		  -settype bar	-block hms_time		-log y	-graph 1 -bxy 1:2 \
#		  -settype bar	-block shms_time 	-log y	-graph 1 -bxy 1:2 \
#		  -p rates.par	-noask	



rm -f xb1_stat
rm -f xb1_tot
rm -f model_nosea_*
rm -f model_sea_*
rm -f model_miller
rm -f hms_stat shms_stat
rm -f syst
