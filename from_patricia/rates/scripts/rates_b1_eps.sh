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
awk '$1!="#" {print $1,$6,$7}' $file0 > temp_xb1_stat
awk '$1!="#" {print $1,$6,sqrt($7*$7+$8*$8)}' $file0 > temp_xb1_tot
awk '$1!="#" {print $1,$3,$4}' $file0 > temp_Azz_stat
awk '$1!="#" {print $1,$3,sqrt($4*$4+$5*$5)}' $file0 > temp_Azz_tot

#awk '$1!="#" {print $1,0,$7}' $file0 > temp_xb1_stat
#awk '$1!="#" {print $1,0,sqrt($7*$7+$8*$8)}' $file0 > temp_xb1_tot
#awk '$1!="#" {print $1,0,$4}' $file0 > temp_Azz_stat
#awk '$1!="#" {print $1,0,sqrt($4*$4+$5*$5)}' $file0 > temp_Azz_tot

file1="../../models/output/b1model_kumano.dat"
awk '$1==1 && $2!=0.0 {print $2,$6/$2}' $file1 > temp_model_nosea_cteq
awk '$1==1 && $2!=0.0 {print $2,$10/$2}' $file1 > temp_model_sea_cteq
awk '$1==2 && $2!=0.0 {print $2,$6/$2}' $file1 > temp_model_nosea_mrst
awk '$1==2 && $2!=0.0 {print $2,$10/$2}' $file1 > temp_model_sea_mrst
awk '$1==3 && $2!=0.0 {print $2,$6/$2}' $file1 > temp_model_nosea_mstw
awk '$1==3 && $2!=0.0 {print $2,$10/$2}' $file1 > temp_model_sea_mstw
awk '$1==1 {print $2,$11}' $file1 > temp_model_nosea_Azz
awk '$1==1 {print $2,$12}' $file1 > temp_model_sea_Azz
awk '$1==2 {print $2,$11}' $file1 > temp_model_nosea_Azz
awk '$1==2 {print $2,$12}' $file1 > temp_model_sea_Azz
awk '$1==3 {print $2,$11}' $file1 > temp_model_nosea_Azz
awk '$1==3 {print $2,$12}' $file1 > temp_model_sea_Azz


file2="../../models/Miller_newtable/miller_nov11_2010.dat"
awk '$1!=0.9 {print $2,$3}' $file2 > temp_model_miller
awk '$1==3 && $2<=0.6 {print $2,$5}' $file2 > temp_model_miller_Azz


file3="../../models/output/b1model_sargsian.dat"
awk '$1==1 && $2>=0.15 {print $2,$4/$2}' $file3 > temp_model_sargsian_vn
awk '$1==1 && $2>=0.15 {print $2,$6/$2}' $file3 > temp_model_sargsian_lc

file5="../../models/output/b1model_bacchetta.dat"
awk '$1==1 && $2!=0.0{print $2,$4/$2}' $file5 > temp_model_bacchetta_low
awk '$1==1 && $2!=0.0{print $2,$5/$2}' $file5 > temp_model_bacchetta_up

# In file4, the columns are defined by:
# $1  = Spectrometer Type
#       1 = HMS
#       2 = SHMS
#       3 = HRS
#       4 = SOLID
#       5 = BigBite
#       6 = Super BigBite
# $2  = x_Bjorken
# $3  = Q^2
# $4  = |W|
# $5  = E'
# $6  = Theta_e'
# $7  = Total Rate
# $8  = Azz
# $9  = dAzz
# $10 = b1d
# $11 = db1d
# $12 = Time (Hours)
# $13 = Azz Systematic Uncertainty
# $14 = b1d Systematic Uncertainty
file4="../output/prop_table.out"
#awk '$1==1 && $2!="NaN" {print $2,0,0,$11}' $file4 > temp_hms_stat
#echo "1	100	1	1" > temp_hms_stat
#awk '$1==2 {print $2,0,$24,$11}' $file4 > temp_shms_stat
#awk '$1==2 && $2!="NaN" {print $2,0,0,$11}' $file4 > temp_shms_stat
awk '$1==3 {print $2,0,$11}' $file4 > temp_hrs_stat
awk '$1==4 {print $2,0,$11}' $file4 > temp_solid_stat
awk '$1==5 {print $2,0,$11}' $file4 > temp_bb_stat
awk '$1==6 {print $2,0,$11}' $file4 > temp_sbs_stat

#awk '$1==1 && $2!="NaN" {print $2,0,0,sqrt($11*S11)}' $file4 > temp_hms_tot
#echo "1	100	1	1" > temp_hms_tot
#awk '$1==2 {print $2,0,$24,sqrt($11*S11)}' $file4 > temp_shms_tot
#awk '$1==2 && $2!="NaN" {print $2,0,0,sqrt($11*S11)}' $file4 > temp_shms_tot
awk '$1==3 {print $2,0,sqrt($11*S11)}' $file4 > temp_hrs_tot
awk '$1==4 {print $2,0,sqrt($11*S11)}' $file4 > temp_solid_tot
awk '$1==5 {print $2,0,sqrt($11*S11)}' $file4 > temp_bb_tot
awk '$1==6 {print $2,0,sqrt($11*S11)}' $file4 > temp_sbs_tot

#awk '$1==1 {print $2,$10,$11}' $file4 > temp_hms_stat
#awk '$1==2 {print $2,$10,$11}' $file4 > temp_shms_stat
#awk '$1==3 {print $2,$10,$11}' $file4 > temp_hrs_stat
#awk '$1==4 {print $2,$10,$11}' $file4 > temp_solid_stat
#awk '$1==5 {print $2,$10,$11}' $file4 > temp_bb_stat
#awk '$1==6 {print $2,$10,$11}' $file4 > temp_sbs_stat
#awk '$1==1 {print $2,$10,sqrt($11*S11)}' $file4 > temp_hms_tot
#awk '$1==2 {print $2,$10,sqrt($11*S11)}' $file4 > temp_shms_tot
#awk '$1==3 {print $2,$10,sqrt($11*S11)}' $file4 > temp_hrs_tot
#awk '$1==4 {print $2,$10,sqrt($11*S11)}' $file4 > temp_solid_tot
#awk '$1==5 {print $2,$10,sqrt($11*S11)}' $file4 > temp_bb_tot
#awk '$1==6 {print $2,$10,sqrt($11*S11)}' $file4 > temp_sbs_tot
# ***************************************************************
# The two lines below are temporarily commented out until we have
# a better handle on the systematic uncertainties ($14)
#awk '$1==1 {print $2,$10,sqrt($11*S11+$14*$14)}' $file4 > temp_hms_tot
#awk '$1==2 {print $2,$10,sqrt($11*S11+$14*$14)}' $file4 > temp_shms_tot

# This fills files that will be used to make bar graphs of the 
# rates vs x_Bjorken
awk '$1==1 && $2!="NaN" {print $29,$7}' $file4 > temp_hms_rates
awk '$1==2 && $2!="NaN" {print $29,$7}' $file4 > temp_shms_rates
awk '$1==3 && $2!="NaN" {print $29,$7}' $file4 > temp_hrs_rates
awk '$1==4 && $2!="NaN" {print $29,$7}' $file4 > temp_solid_rates
awk '$1==5 && $2!="NaN" {print $29,$7}' $file4 > temp_bb_rates
awk '$1==6 && $2!="NaN" {print $29,$7}' $file4 > temp_sbs_rates
awk '$1==1 && $2!="NaN" {print $29,$25}' $file4 > temp_hms_totrates
awk '$1==2 && $2!="NaN" {print $29,$25}' $file4 > temp_shms_totrates
awk '$1==3 && $2!="NaN" {print $29,$25}' $file4 > temp_hrs_totrates
awk '$1==4 && $2!="NaN" {print $29,$25}' $file4 > temp_solid_totrates
awk '$1==5 && $2!="NaN" {print $29,$25}' $file4 > temp_bb_totrates
awk '$1==6 && $2!="NaN" {print $29,$25}' $file4 > temp_sbs_totrates


# This fills files that will be used to make bar graphs of the 
# time needed vs x_Bjorken
awk '$1==1 && $2!="NaN" {print $29,$12}' $file4 > temp_hms_time
awk '$1==2 && $2!="NaN" {print $29,$12}' $file4 > temp_shms_time
awk '$1==3 && $2!="NaN" {print $29,$12}' $file4 > temp_hrs_time
awk '$1==4 && $2!="NaN" {print $29,$12}' $file4 > temp_solid_time
awk '$1==5 && $2!="NaN" {print $29,$12}' $file4 > temp_bb_time
awk '$1==6 && $2!="NaN" {print $29,$12}' $file4 > temp_sbs_time
awk '$1==1 && $2!="NaN" {print $29,$22}' $file4 > temp_hms_pactm
awk '$1==2 && $2!="NaN" {print $29,$22}' $file4 > temp_shms_pactm
awk '$1==3 && $2!="NaN" {print $29,$22}' $file4 > temp_hrs_pactm
awk '$1==4 && $2!="NaN" {print $29,$22}' $file4 > temp_solid_pactm
awk '$1==5 && $2!="NaN" {print $29,$22}' $file4 > temp_bb_pactm
awk '$1==6 && $2!="NaN" {print $29,$22}' $file4 > temp_sbs_pactm


echo "0 24" > temp_1day
echo "10 24" >> temp_1day
echo "0 168" > temp_1week
echo "10 168" >> temp_1week
echo "0 720" > temp_1month
echo "10 720" >> temp_1month
echo "0 8760" > temp_1year
echo "10 8760" >> temp_1year
echo "0 1000" > temp_1kHz
echo "10 1000" >> temp_1kHz
echo "0 500000" > temp_50kHz
echo "10 500000" >> temp_50kHz
echo "0 1.85" > temp_wmin
echo "10 1.85" >> temp_wmin
echo "0 0.938" > temp_wqe
echo "10 0.938" >> temp_wqe
echo "0 7.3" > temp_thmin_shms
echo "10 7.3" >> temp_thmin_shms
echo "0 10.4" > temp_epmax_shms
echo "10 10.4" >> temp_epmax_shms

echo "0 7.3" > temp_epmax_hms
echo "10 7.3" >> temp_epmax_hms
echo "0 12.2" > temp_thmin_hms
echo "10 12.2" >> temp_thmin_hms
# vvvv The below are maxed way above the max y so
# that the HMS stuff doesn't appear on the plot. 
# To put them back, remove the four lines below 
# and un-comment the 4 lines above
#echo "0 100" > temp_epmax_hms
#echo "10 100" >> temp_epmax_hms
#echo "0 100" > temp_thmin_hms
#echo "10 100" >> temp_thmin_hms

#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
# vvvv WORKING ON NEW STUFF HERE vvvvvvvvvvvvvvvvvvvvvvvvvv<<<<<<<<<<<<<<<<<
file7="../output/rebinned-x.out"
#awk '$1==1 && $5!="NaN" {print $2,0,$3,$4}' $file7 > temp_hms_azz_stat
echo "100	0	0	0" > temp_hms_azz_stat
awk '$1==2 && $5!="NaN" {print $2,$11,0,$4}' $file7 > temp_shms_azz_stat
#awk '$1==2 && $5!="NaN" {print $2,$11,$3,$4}' $file7 > temp_shms_azz_stat
#awk '$1==2 && $5!="NaN" {print $2,0,$3,$4}' $file7 > temp_shms_azz_stat
#awk '$1==1 && $5!="NaN" {print $2,0,$3,$4}' $file7 > temp_hms_azz_tot
echo "100	0	0	0" > temp_hms_azz_tot
#awk '$1==2 && $5!="NaN" {print $2,0,$3,$9}' $file7 > temp_shms_azz_tot
awk '$1==2 && $5!="NaN" {print $2,$11,0,sqrt($4*$4+$9*$9)}' $file7 > temp_shms_azz_tot
#awk '$1==2 && $5!="NaN" {print $2,$11,$3,sqrt($4*$4+$9*$9)}' $file7 > temp_shms_azz_tot
#awk '$1==2 && $5!="NaN" {print $2,0,$3,$4}' $file7 > temp_shms_azz_tot


echo "100	0	0	0" > temp_hms_stat
echo "100	0	0	0" > temp_hms_tot
awk '$1==2 && $5!="NaN" {print $2,$12,0,$5}' $file7 > temp_shms_stat
#awk '$1==2 && $5!="NaN" {print $2,$12,$3,$5}' $file7 > temp_shms_stat
#awk '$1==2 && $5!="NaN" {print $2,0,$3,$5}' $file7 > temp_shms_stat
#awk '$1==2 && $5!="NaN" {print $2,0,$3,$10}' $file7 > temp_shms_tot
awk '$1==2 && $5!="NaN" {print $2,$12,0,sqrt($5*$5+$10*$10)}' $file7 > temp_shms_tot
#awk '$1==2 && $5!="NaN" {print $2,$12,$3,sqrt($5*$5+$10*$10)}' $file7 > temp_shms_tot
#awk '$1==2 && $5!="NaN" {print $2,0,$3,$5}' $file7 > temp_shms_tot


#awk '$1==2 && $5!="NaN" {print $2-$3,-0.025,"\n"$2-$3,-0.025+sqrt($11*$11)*0.092+0.0037"\n"$2+$3,-0.025+sqrt($11*$11)*0.092+0.0037,"\n"$2+$3,-0.025}' $file7 > temp_shms_azz_stat_bar
#awk '$1==2 && $5!="NaN" {print $2-$3,-0.025,"\n"$2-$3,-0.025+sqrt($11*$11*0.092*0.092+0.0037*0.0037)"\n"$2+$3,-0.025+sqrt($11*$11*0.092*0.092+0.0037*0.0037),"\n"$2+$3,-0.025}' $file7 > temp_shms_azz_stat_bar
#awk '$1==2 && $5!="NaN" {print $2-$3,-0.025,"\n"$2-$3,-0.025+sqrt($11*$11)*0.092"\n"$2+$3,-0.025+sqrt($11*$11)*0.092,"\n"$2+$3,-0.025}' $file7 > temp_shms_azz_stat_bar
awk '$1==2 && $5!="NaN" {print $2-$3,-0.025,"\n"$2-$3,-0.025+$9"\n"$2+$3,-0.025+$9,"\n"$2+$3,-0.025}' $file7 > temp_shms_azz_stat_bar

awk '$1==2 && $5!="NaN" {print $2-$3,-0.014,"\n"$2-$3,-0.014+$10"\n"$2+$3,-0.014+$10,"\n"$2+$3,-0.014}' $file7 > temp_shms_b1_stat_bar
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



# This fills temporary files for Azz +- dAzz
#awk '$1==1 {print $2,$8,$24,$9}' $file4 > temp_hms_azz_stat
#awk '$1==1 && $2!="NaN" {print $2,0,0,$9}' $file4 > temp_hms_azz_stat
#echo "1	100	1	1" > temp_hms_azz_stat
#awk '$1==2 {print $2,$8,$24,$9}' $file4 > temp_shms_azz_stat
#awk '$1==2 && $2!="NaN" {print $2,0,0,$9}' $file4 > temp_shms_azz_stat
awk '$1==3 && $2!="NaN" {print $2,$8,$9}' $file4 > temp_hrs_azz_stat
awk '$1==4 && $2!="NaN" {print $2,$8,$9}' $file4 > temp_solid_azz_stat
awk '$1==5 && $2!="NaN" {print $2,$8,$9}' $file4 > temp_bb_azz_stat
awk '$1==6 && $2!="NaN" {print $2,$8,$9}' $file4 > temp_sbs_azz_stat
#awk '$1==1 {print $2,$8,$24,sqrt($9*S9)}' $file4 > temp_hms_azz_tot
#awk '$1==1 && $2!="NaN" {print $2,0,0,sqrt($9*S9)}' $file4 > temp_hms_azz_tot
#echo "1	100	1	1" > temp_hms_azz_tot
#awk '$1==2 {print $2,$8,$24,sqrt($9*S9)}' $file4 > temp_shms_azz_tot
#awk '$1==2 && $2!="NaN" {print $2,0,0,sqrt($9*S9)}' $file4 > temp_shms_azz_tot
awk '$1==3 && $2!="NaN" {print $2,$8,sqrt($9*S9)}' $file4 > temp_hrs_azz_tot
awk '$1==4 && $2!="NaN" {print $2,$8,sqrt($9*S9)}' $file4 > temp_solid_azz_tot
awk '$1==5 && $2!="NaN" {print $2,$8,sqrt($9*S9)}' $file4 > temp_bb_azz_tot
awk '$1==6 && $2!="NaN" {print $2,$8,sqrt($9*S9)}' $file4 > temp_sbs_azz_tot


file6="../output/xs-take1.out"

hms_csmin=`awk 'BEGIN {min = 1000} {if ($1==1 && $2==5 && $14>0 && $10>0 && $10<3 && $14<min) min=$14} END {print min}' $file6`
hms_csmax=`awk 'BEGIN {max = 0} {if ($1==1 && $2==5 && $14>0 && $10>0 && $10<3 && $14>max) max=$14} END {print max}' $file6`
hms_scale=`awk 'BEGIN{scale = 18/('$hms_csmax'-'$hms_csmin')} END {print scale}' $file6`

shms_csmin=`awk 'BEGIN {min = 1000} {if ($1==2 && ($2==1 || $2==2 || $2==3) && $14>0 && $10>0 && $10<3 && $14<min) min=$14} END {print min}' $file6`
shms_csmax=`awk 'BEGIN {max = 0} {if ($1==2 && ($2==1 || $2==2 || $2==3) && $14>0 && $10>0 && $10<3 && $14>max) max=$14} END {print max}' $file6`
shms_scale=`awk 'BEGIN{scale = 18/('$shms_csmax'-'$shms_csmin')} END {print scale}' $file6`


hmsa_csmin=`awk 'BEGIN {min = 1000} {if ($1==1 && $2==5 && $26>0 && $10>0 && $10<3 && $26<min) min=$26} END {print min}' $file6`
hmsa_csmax=`awk 'BEGIN {max = 0} {if ($1==1 && $2==5 && $26>0 && $10>0 && $10<3 && $26>max) max=$26} END {print max}' $file6`
hmsa_scale=`awk 'BEGIN{scale = 18/('$hmsa_csmax'-'$hmsa_csmin')} END {print scale}' $file6`

shmsa_csmin=`awk 'BEGIN {min = 1000} {if ($1==2 && ($2==1 || $2==2 || $2==3) && $26>0 && $10>0 && $10<3 && $26<min) min=$26} END {print min}' $file6`
shmsa_csmax=`awk 'BEGIN {max = 0} {if ($1==2 && ($2==1 || $2==2 || $2==3) && $26>0 && $10>0 && $10<3 && $26>max) max=$26} END {print max}' $file6`
shmsa_scale=`awk 'BEGIN{scale = 18/('$shmsa_csmax'-'$shmsa_csmin')} END {print scale}' $file6`



# This fills temporary files for Theta_e'
#   vvv Central Values vvv
awk '$1==1 && $2!="NaN" {print $29,$6}' $file4 > temp_hms_ctheta
#awk '$1==1 {print 1000,1000}' $file4 > temp_hms_ctheta
awk '$1==2 && $2!="NaN" {print $29,$6}' $file4 > temp_shms_ctheta
awk '$1==3 && $2!="NaN" {print $29,$6}' $file4 > temp_hrs_ctheta
awk '$1==4 && $2!="NaN" {print $29,$6}' $file4 > temp_solid_ctheta
awk '$1==5 && $2!="NaN" {print $29,$6}' $file4 > temp_bb_ctheta
awk '$1==6 && $2!="NaN" {print $29,$6}' $file4 > temp_sbs_ctheta
#   vvv Full Spread vvv
awk '$1==1 && $14>0 {print $10,$24}' $file6 > temp_hms_theta
#awk '$1==1 {print 1000,1000}' $file6 > temp_hms_theta
awk '$1==2 && $2==1 && $14>0 {print $10,$24}' $file6 > temp_shms_theta
awk '$1==2 && $2==2 && $14>0 {print $10,$24}' $file6 > temp_shms_theta2
awk '$1==2 && $2==3 && $14>0 {print $10,$24}' $file6 > temp_shms_theta3
awk '$1==3 && $14>0 {print $10,$24}' $file6 > temp_hrs_theta
awk '$1==4 && $14>0 {print $10,$24}' $file6 > temp_solid_theta
awk '$1==5 && $14>0 {print $10,$24}' $file6 > temp_bb_theta
awk '$1==6 && $14>0 {print $10,$24}' $file6 > temp_sbs_theta
#   vvv Include Non-Physics Events vvv
awk '$1==1 && $26>0 {print $10,$24}' $file6 > temp_hms_atheta
#awk '$1==1 {print 1000,1000}' $file6 > temp_hms_atheta
awk '$1==2 && $26>0 {print $10,$24}' $file6 > temp_shms_atheta
awk '$1==3 && $26>0 {print $10,$24}' $file6 > temp_hrs_atheta
awk '$1==4 && $26>0 {print $10,$24}' $file6 > temp_solid_atheta
awk '$1==5 && $26>0 {print $10,$24}' $file6 > temp_bb_atheta
awk '$1==6 && $26>0 {print $10,$24}' $file6 > temp_sbs_atheta


# This fills temporary files for Theta_q
#   vvv Central Values vvv
awk '$1==1 && $2!="NaN" {print $29,$15}' $file4 > temp_hms_theta_cq
#awk '$1==1 {print 1000,1000}' $file4 > temp_hms_theta_cq
awk '$1==2 && $2!="NaN" {print $29,$15}' $file4 > temp_shms_theta_cq
awk '$1==3 && $2!="NaN" {print $29,$15}' $file4 > temp_hrs_theta_cq
awk '$1==4 && $2!="NaN" {print $29,$15}' $file4 > temp_solid_theta_cq
awk '$1==5 && $2!="NaN" {print $29,$15}' $file4 > temp_bb_theta_cq
awk '$1==6 && $2!="NaN" {print $29,$15}' $file4 > temp_sbs_theta_cq
#   vvv Full Spread vvv
awk '$1==1 && $14>0 {print $10,$25}' $file6 > temp_hms_theta_q
#awk '$1==1 {print 1000,1000}' $file6 > temp_hms_theta_q
awk '$1==2 && $2==1 && $14>0 {print $10,$25}' $file6 > temp_shms_theta_q
awk '$1==2 && $2==2 && $14>0 {print $10,$25}' $file6 > temp_shms_theta_q2
awk '$1==2 && $2==3 && $14>0 {print $10,$25}' $file6 > temp_shms_theta_q3
awk '$1==3 && $14>0 {print $10,$25}' $file6 > temp_hrs_theta_q
awk '$1==4 && $14>0 {print $10,$25}' $file6 > temp_solid_theta_q
awk '$1==5 && $14>0 {print $10,$25}' $file6 > temp_bb_theta_q
awk '$1==6 && $14>0 {print $10,$25}' $file6 > temp_sbs_theta_q
#   vvv Include Non-Physics Events vvv
awk '$1==1 && $26>0 {print $10,$25}' $file6 > temp_hms_theta_aq
#awk '$1==1 {print 1000,1000}' $file6 > temp_hms_theta_aq
awk '$1==2 && $26>0 {print $10,$25}' $file6 > temp_shms_theta_aq
awk '$1==3 && $26>0 {print $10,$25}' $file6 > temp_hrs_theta_aq
awk '$1==4 && $26>0 {print $10,$25}' $file6 > temp_solid_theta_aq
awk '$1==5 && $26>0 {print $10,$25}' $file6 > temp_bb_theta_aq
awk '$1==6 && $26>0 {print $10,$25}' $file6 > temp_sbs_theta_aq



# This fills temporary files for Q^2
#   vvv Central Values vvv
awk '$1==1 && $2!="NaN" {print $29,$3}' $file4 > temp_hms_cq2
#awk '$1==1 {print 1000,1000}' $file4 > temp_hms_cq2
awk '$1==2 && $2!="NaN" {print $29,$3}' $file4 > temp_shms_cq2
awk '$1==3 && $2!="NaN" {print $29,$3}' $file4 > temp_hrs_cq2
awk '$1==4 && $2!="NaN" {print $29,$3}' $file4 > temp_solid_cq2
awk '$1==5 && $2!="NaN" {print $29,$3}' $file4 > temp_bb_cq2
awk '$1==6 && $2!="NaN" {print $29,$3}' $file4 > temp_sbs_cq2
#   vvv Full Spread vvv
awk '$1==1 && $14>0 {print $10,$8}' $file6 > temp_hms_q2
#awk '$1==1 {print 10000,10000}' $file6 > temp_hms_q2
awk '$1==1 && $2==1 && $14>0 && $10>0 && $10<3 {print $10,$8,$14*'$hms_scale'+19}' $file6 > temp_hms_q21
awk '$1==1 && $2==2 && $14>0 && $10>0 && $10<3 {print $10,$8,$14*'$hms_scale'+19}' $file6 > temp_hms_q22
awk '$1==1 && $2==3 && $14>0 && $10>0 && $10<3 {print $10,$8,$14*'$hms_scale'+19}' $file6 > temp_hms_q23
awk '$1==1 && $2==4 && $14>0 && $10>0 && $10<3 {print $10,$8,$14*'$hms_scale'+19}' $file6 > temp_hms_q24
awk '$1==1 && $2==5 && $14>0 && $10>0 && $10<3 {print $10,$8,$14*'$hms_scale'+19}' $file6 > temp_hms_q25
awk '$1==2 && $2==1 && $14>0 {print $10,$8}' $file6 > temp_shms_q2
#awk '$1==2 && $2==2 && $14>0 {print $10,$8}' $file6 > temp_shms_q22
#awk '$1==2 && $2==3 && $14>0 {print $10,$8}' $file6 > temp_shms_q23
awk '$1==2 && $2==1 && $14>0 && $10>0 && $10<3 {print $10,$8,$14*'$shms_scale'+40}' $file6 > temp_shms_q21
awk '$1==2 && $2==2 && $14>0 && $10>0 && $10<3 {print $10,$8,$14*'$shms_scale'+40}' $file6 > temp_shms_q22
awk '$1==2 && $2==3 && $14>0 && $10>0 && $10<3 {print $10,$8,$14*'$shms_scale'+40}' $file6 > temp_shms_q23
awk '$1==2 && $2==4 && $14>0 && $10>0 && $10<3 {print $10,$8,$14*'$shms_scale'+40}' $file6 > temp_shms_q24
awk '$1==2 && $2==5 && $14>0 && $10>0 && $10<3 {print $10,$8,$14*'$shms_scale'+40}' $file6 > temp_shms_q25


awk '$1==3 && $14>0 {print $10,$8}' $file6 > temp_hrs_q2
awk '$1==4 && $14>0 {print $10,$8}' $file6 > temp_solid_q2
awk '$1==5 && $14>0 {print $10,$8}' $file6 > temp_bb_q2
awk '$1==6 && $14>0 {print $10,$8}' $file6 > temp_sbs_q2
#   vvv Include Non-Physics Events vvv
#awk '$1==1 && $26>0 {print $10,$8}' $file6 > temp_hms_aq2
awk '$1==1 && $26>0 && $10>0 && $10<3 {print $10,$8,$26*'$hmsa_scale'+60}' $file6 > temp_hms_aq2
#awk '$1==1 {print 10000,10000}' $file6 > temp_hms_aq2
#awk '$1==2 && $26>0 {print $10,$8}' $file6 > temp_shms_aq2
awk '$1==2 && $26>0 && $10>0 && $10<3 {print $10,$8,$26*'$shmsa_scale'+60}' $file6 > temp_shms_aq2
awk '$1==3 && $26>0 {print $10,$8}' $file6 > temp_hrs_aq2
awk '$1==4 && $26>0 {print $10,$8}' $file6 > temp_solid_aq2
awk '$1==5 && $26>0 {print $10,$8}' $file6 > temp_bb_aq2
awk '$1==6 && $26>0 {print $10,$8}' $file6 > temp_sbs_aq2



# This fills temporary files for E'
#   vvv Central Values vvv
awk '$1==1 && $2!="NaN" {print $29,$5}' $file4 > temp_hms_cep
#awk '$1==1 {print 1000,1000}' $file4 > temp_hms_cep
awk '$1==2 && $2!="NaN" {print $29,$5}' $file4 > temp_shms_cep
awk '$1==3 && $2!="NaN" {print $29,$5}' $file4 > temp_hrs_cep
awk '$1==4 && $2!="NaN" {print $29,$5}' $file4 > temp_solid_cep
awk '$1==5 && $2!="NaN" {print $29,$5}' $file4 > temp_bb_cep
awk '$1==6 && $2!="NaN" {print $29,$5}' $file4 > temp_sbs_cep
#   vvv Full Spread vvv
awk '$1==1 && $14>0 {print $10,$23}' $file6 > temp_hms_ep
#awk '$1==1 {print 1000,1000}' $file6 > temp_hms_ep
awk '$1==2 && $2==1 && $14>0 {print $10,$23}' $file6 > temp_shms_ep
awk '$1==2 && $2==2 && $14>0 {print $10,$23}' $file6 > temp_shms_ep2
awk '$1==2 && $2==3 && $14>0 {print $10,$23}' $file6 > temp_shms_ep3
awk '$1==3 && $14>0 {print $10,$23}' $file6 > temp_hrs_ep
awk '$1==4 && $14>0 {print $10,$23}' $file6 > temp_solid_ep
awk '$1==5 && $14>0 {print $10,$23}' $file6 > temp_bb_ep
awk '$1==6 && $14>0 {print $10,$23}' $file6 > temp_sbs_ep
#   vvv Include Non-Physics Events vvv
awk '$1==1 && $26>0 {print $10,$23}' $file6 > temp_hms_aep
#awk '$1==1 {print 1000,1000}' $file6 > temp_hms_aep
awk '$1==2 && $26>0 {print $10,$23}' $file6 > temp_shms_aep
awk '$1==3 && $26>0 {print $10,$23}' $file6 > temp_hrs_aep
awk '$1==4 && $26>0 {print $10,$23}' $file6 > temp_solid_aep
awk '$1==5 && $26>0 {print $10,$23}' $file6 > temp_bb_aep
awk '$1==6 && $26>0 {print $10,$23}' $file6 > temp_sbs_aep



# This fills temporary files for E_0
awk '$1==2 {print 0,$23}' $file4 > temp_hms_e0
awk '$1==2 {print 10,$23}' $file4 >> temp_hms_e0
awk '$1==3 && $2==0.10 {print 0,$23}' $file4 > temp_hrs_e0
awk '$1==3 && $2==0.10 {print 10,$23}' $file4 >> temp_hrs_e0
awk '$1==5 && $2==0.10 {print 0,$23}' $file4 > temp_bb_e0
awk '$1==5 && $2==0.10 {print 10,$23}' $file4 >> temp_bb_e0


# This fills temporary files for W
#   vvv Central Values vvv
awk '$1==1 && $2!="NaN" {print $29,$4}' $file4 > temp_hms_cw
#awk '$1==1 {print 1000,1000}' $file4 > temp_hms_cw
awk '$1==2 && $2!="NaN" {print $29,$4}' $file4 > temp_shms_cw
awk '$1==3 && $2!="NaN" {print $29,$4}' $file4 > temp_hrs_cw
awk '$1==4 && $2!="NaN" {print $29,$4}' $file4 > temp_solid_cw
awk '$1==5 && $2!="NaN" {print $29,$4}' $file4 > temp_bb_cw
awk '$1==6 && $2!="NaN" {print $29,$4}' $file4 > temp_sbs_cw
#   vvv Full Spread vvv
awk '$1==1 && $2==5 && $14>0 {print $10,sqrt($12)}' $file6 > temp_hms_w
#awk '$1==1 {print 1000,1000}' $file6 > temp_hms_w
awk '$1==2 && $2==1 && $14>0 {print $10,sqrt($12)}' $file6 > temp_shms_w
awk '$1==2 && $2==2 && $14>0 {print $10,sqrt($12)}' $file6 > temp_shms_w2
awk '$1==2 && $2==3 && $14>0 {print $10,sqrt($12)}' $file6 > temp_shms_w3
awk '$1==3 && $14>0 {print $10,sqrt($12)}' $file6 > temp_hrs_w
awk '$1==4 && $14>0 {print $10,sqrt($12)}' $file6 > temp_solid_w
awk '$1==5 && $14>0 {print $10,sqrt($12)}' $file6 > temp_bb_w
awk '$1==6 && $14>0 {print $10,sqrt($12)}' $file6 > temp_sbs_w
#   vvv Include Non-Physics Events vvv
awk '$1==1 && $2==5 && $26>0 {print $10,sqrt($12)}' $file6 > temp_hms_aw
#awk '$1==1 {print 1000,1000}' $file6 > temp_hms_aw
awk '$1==2 && $26>0 {print $10,sqrt($12)}' $file6 > temp_shms_aw
awk '$1==3 && $26>0 {print $10,sqrt($12)}' $file6 > temp_hrs_aw
awk '$1==4 && $26>0 {print $10,sqrt($12)}' $file6 > temp_solid_aw
awk '$1==5 && $26>0 {print $10,sqrt($12)}' $file6 > temp_bb_aw
awk '$1==6 && $26>0 {print $10,sqrt($12)}' $file6 > temp_sbs_aw





#file3="../output/rates.out"
#awk '$1==2 {print $3,$16}' $file3 > temp_syst
awk '{print $2,$14}' $file4 > temp_syst

#xmgrace -free -settype xy   -block temp_model_miller         -graph 0 -bxy 1:2 \
#              -settype xy   -block temp_model_nosea_mstw     -graph 0 -bxy 1:2 \
#              -settype xy   -block temp_model_sea_mstw       -graph 0 -bxy 1:2 \
#              -settype xy   -block temp_model_sargsian_vn    -graph 0 -bxy 1:2 \
#              -settype xy   -block temp_model_sargsian_lc    -graph 0 -bxy 1:2 \
#              -settype xy   -block temp_model_bacchetta_low  -graph 0 -bxy 1:2 \
#              -settype xy   -block temp_model_bacchetta_up   -graph 0 -bxy 1:2 \
#              -settype xydy -block temp_xb1_tot              -graph 0 -bxy 1:2:3 \
#              -settype xydy -block temp_xb1_stat             -graph 0 -bxy 1:2:3 \
#              -settype xydy -block temp_hms_tot              -graph 0 -bxy 1:2:3 \
#              -settype xydy -block temp_hms_stat             -graph 0 -bxy 1:2:3 \
#              -settype xydy -block temp_shms_tot             -graph 0 -bxy 1:2:3 \
#              -settype xydy -block temp_shms_stat            -graph 0 -bxy 1:2:3 \
#			  -settype bar	-block temp_hms_rates			-graph 1 -bxy 1:2 \
#			  -settype bar	-block temp_shms_rates			-graph 1 -bxy 1:2 \
#			  -settype bar	-block temp_hms_time		-log y	-graph 2 -bxy 1:2 \
#			  -settype bar	-block temp_shms_time 	-log y	-graph 2 -bxy 1:2 \
#              -p b1_proj_new.par -noask

#gracebat -hdevice EPS -printfile b1_rates_hms_shms.eps \
#xmgrace -free \
#gracebat -hdevice PNG -printfile b1_rates_hms_shms.png \
#gracebat -hdevice EPS -printfile hms_shms_b1.eps \
xmgrace \
		-settype xy		-block temp_model_miller		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_model_nosea_mstw	-graph 0 -bxy 1:2 \
		-settype xy		-block temp_model_sea_mstw		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_model_sargsian_vn	-graph 0 -bxy 1:2 \
		-settype xy		-block temp_model_sargsian_lc	-graph 0 -bxy 1:2 \
		-settype xy		-block temp_model_bacchetta_low	-graph 0 -bxy 1:2 \
		-settype xy		-block temp_model_bacchetta_up	-graph 0 -bxy 1:2 \
		-settype xydy	-block temp_xb1_tot				-graph 0 -bxy 1:2:3 \
		-settype xydy	-block temp_xb1_stat			-graph 0 -bxy 1:2:3 \
		-settype xydxdy	-block temp_hms_tot				-graph 0 -bxy 1:2:3:4 \
		-settype xydxdy	-block temp_hms_stat			-graph 0 -bxy 1:2:3:4 \
		-settype xydxdy	-block temp_shms_tot			-graph 0 -bxy 1:2:3:4 \
		-settype xydxdy	-block temp_shms_stat			-graph 0 -bxy 1:2:3:4 \
		-settype xy		-block temp_shms_b1_stat_bar	-graph 0 -bxy 1:2 \
		-p b1_proj_hms_shms.par -noask
#gracebat -hdevice EPS -printfile hms_shms_rates.eps \
#xmgrace \
#		-settype bar	-block temp_1kHz				-graph 1 -bxy 1:2 \
#		-settype bar	-block temp_50kHz				-graph 1 -bxy 1:2 \
#		-settype bar	-block temp_hms_totrates		-graph 1 -bxy 1:2 \
#		-settype bar	-block temp_hms_rates			-graph 1 -bxy 1:2 \
#		-settype bar	-block temp_shms_totrates		-graph 1 -bxy 1:2 \
#		-settype bar	-block temp_shms_rates			-graph 1 -bxy 1:2 \
#		-p b1_proj_hms_shms.par -noask
#gracebat -hdevice EPS -printfile hms_shms_time.eps \
#xmgrace \
#		-settype xy		-block temp_1day	 	-log y	-graph 2 -bxy 1:2 \
#		-settype xy		-block temp_1week	 	-log y	-graph 2 -bxy 1:2 \
#		-settype xy		-block temp_1month	 	-log y	-graph 2 -bxy 1:2 \
#		-settype xy		-block temp_1year		-log y	-graph 2 -bxy 1:2 \
#		-settype bar	-block temp_hms_pactm	-log y	-graph 2 -bxy 1:2 \
#		-settype bar	-block temp_hms_time	-log y	-graph 2 -bxy 1:2 \
#		-settype bar	-block temp_shms_pactm 	-log y	-graph 2 -bxy 1:2 \
#		-settype bar	-block temp_shms_time 	-log y	-graph 2 -bxy 1:2 \
#		-p b1_proj_hms_shms.par -noask
#gracebat -hdevice EPS -printfile hms_shms_Azz.eps \
xmgrace \
		-settype xy   	-block temp_model_nosea_Azz 	-graph 3 -bxy 1:2 \
		-settype xy   	-block temp_model_sea_Azz		-graph 3 -bxy 1:2 \
		-settype xy   	-block temp_model_miller_Azz	-graph 3 -bxy 1:2 \
		-settype xydy 	-block temp_Azz_stat         	-graph 3 -bxy 1:2:3 \
		-settype xydy 	-block temp_Azz_tot          	-graph 3 -bxy 1:2:3 \
		-settype xydxdy	-block temp_hms_azz_tot			-graph 3 -bxy 1:2:3:4 \
		-settype xydxdy	-block temp_hms_azz_stat		-graph 3 -bxy 1:2:3:4 \
		-settype xydxdy	-block temp_shms_azz_tot		-graph 3 -bxy 1:2:3:4 \
		-settype xydxdy	-block temp_shms_azz_stat		-graph 3 -bxy 1:2:3:4 \
		-settype xy		-block temp_shms_azz_stat_bar	-graph 3 -bxy 1:2 \
		-p b1_proj_hms_shms.par -noask
#gracebat -hdevice EPS -printfile hms_shms_theta.eps \
#xmgrace \
#		-settype xy		-block temp_thmin_hms			-graph 4 -bxy 1:2 \
#		-settype xy		-block temp_thmin_shms			-graph 4 -bxy 1:2 \
#		-settype xy		-block temp_hms_atheta			-graph 4 -bxy 1:2 \
#		-settype xy		-block temp_shms_atheta			-graph 4 -bxy 1:2 \
#		-settype xy		-block temp_hms_theta			-graph 4 -bxy 1:2 \
#		-settype xy		-block temp_shms_theta			-graph 4 -bxy 1:2 \
#		-settype xy		-block temp_shms_theta2			-graph 4 -bxy 1:2 \
#		-settype xy		-block temp_shms_theta3			-graph 4 -bxy 1:2 \
#		-settype xy		-block temp_hms_ctheta			-graph 4 -bxy 1:2 \
#		-settype xy		-block temp_shms_ctheta			-graph 4 -bxy 1:2 \
#		-p b1_proj_hms_shms.par -noask
#gracebat -hdevice EPS -printfile hms_shms_q2.eps \
xmgrace \
	-settype xycolor		-block temp_hms_aq2			-graph 5 -bxy 1:2:3 \
	-settype xycolor		-block temp_shms_aq2			-graph 5 -bxy 1:2:3 \
	-settype xycolor		-block temp_hms_q21			-graph 5 -bxy 1:2:3 \
	-settype xycolor		-block temp_hms_q22			-graph 5 -bxy 1:2:3 \
	-settype xycolor		-block temp_hms_q23			-graph 5 -bxy 1:2:3 \
	-settype xycolor		-block temp_hms_q24			-graph 5 -bxy 1:2:3 \
	-settype xycolor		-block temp_hms_q25			-graph 5 -bxy 1:2:3 \
	-settype xycolor		-block temp_shms_q21			-graph 5 -bxy 1:2:3 \
	-settype xycolor		-block temp_shms_q22			-graph 5 -bxy 1:2:3 \
	-settype xycolor		-block temp_shms_q23			-graph 5 -bxy 1:2:3 \
	-settype xycolor		-block temp_shms_q24			-graph 5 -bxy 1:2:3 \
	-settype xycolor		-block temp_shms_q25			-graph 5 -bxy 1:2:3 \
	-settype xy			-block temp_hms_cq2			-graph 5 -bxy 1:2 \
	-settype xy			-block temp_shms_cq2			-graph 5 -bxy 1:2 \
	-p b1_proj_hms_shms.par -noask
#gracebat -hdevice EPS -printfile hms_shms_eprime.eps \
#xmgrace \
#		-settype xy		-block temp_hms_e0				-graph 6 -bxy 1:2 \
#		-settype xy		-block temp_epmax_hms			-graph 6 -bxy 1:2 \
#		-settype xy		-block temp_epmax_shms			-graph 6 -bxy 1:2 \
#		-settype xy		-block temp_hms_aep				-graph 6 -bxy 1:2 \
#		-settype xy		-block temp_shms_aep			-graph 6 -bxy 1:2 \
#		-settype xy		-block temp_hms_ep				-graph 6 -bxy 1:2 \
#		-settype xy		-block temp_shms_ep				-graph 6 -bxy 1:2 \
#		-settype xy		-block temp_shms_ep2			-graph 6 -bxy 1:2 \
#		-settype xy		-block temp_shms_ep3			-graph 6 -bxy 1:2 \
#		-settype xy		-block temp_hms_cep				-graph 6 -bxy 1:2 \
#		-settype xy		-block temp_shms_cep			-graph 6 -bxy 1:2 \
#		-p b1_proj_hms_shms.par -noask
#gracebat -hdevice EPS -printfile hms_shms_w.eps \
#xmgrace \
#		-settype xy		-block temp_wqe					-graph 7 -bxy 1:2 \
#		-settype xy		-block temp_wmin				-graph 7 -bxy 1:2 \
#		-settype xy		-block temp_hms_aw				-graph 7 -bxy 1:2 \
#		-settype xy		-block temp_shms_aw				-graph 7 -bxy 1:2 \
#		-settype xy		-block temp_hms_w				-graph 7 -bxy 1:2 \
#		-settype xy		-block temp_shms_w				-graph 7 -bxy 1:2 \
#		-settype xy		-block temp_shms_w2				-graph 7 -bxy 1:2 \
#		-settype xy		-block temp_shms_w3				-graph 7 -bxy 1:2 \
#		-settype xy		-block temp_hms_cw				-graph 7 -bxy 1:2 \
#		-settype xy		-block temp_shms_cw				-graph 7 -bxy 1:2 \
#		-p b1_proj_hms_shms.par -noask
#gracebat -hdevice EPS -printfile hms_shms_theta_q.eps \
#xmgrace \
#		-settype xy		-block temp_hms_theta_aq		-graph 8 -bxy 1:2 \
#		-settype xy		-block temp_shms_theta_aq		-graph 8 -bxy 1:2 \
#		-settype xy		-block temp_hms_theta_q			-graph 8 -bxy 1:2 \
#		-settype xy		-block temp_shms_theta_q		-graph 8 -bxy 1:2 \
#		-settype xy		-block temp_shms_theta_q2		-graph 8 -bxy 1:2 \
#		-settype xy		-block temp_shms_theta_q3		-graph 8 -bxy 1:2 \
#		-settype xy		-block temp_hms_theta_cq		-graph 8 -bxy 1:2 \
#		-settype xy		-block temp_shms_theta_cq		-graph 8 -bxy 1:2 \
#		-p b1_proj_hms_shms.par -noask 

#gracebat -hdevice PNG -printfile b1_rates_hrs_solid.png \
#		-settype xy		-block temp_model_miller		-graph 0 -bxy 1:2 \
#		-settype xy		-block temp_model_nosea_mstw	-graph 0 -bxy 1:2 \
#		-settype xy		-block temp_model_sea_mstw		-graph 0 -bxy 1:2 \
#		-settype xy		-block temp_model_sargsian_vn	-graph 0 -bxy 1:2 \
#		-settype xy		-block temp_model_sargsian_lc	-graph 0 -bxy 1:2 \
#		-settype xy		-block temp_model_bacchetta_low	-graph 0 -bxy 1:2 \
#		-settype xy		-block temp_model_bacchetta_up	-graph 0 -bxy 1:2 \
#		-settype xydy	-block temp_xb1_tot				-graph 0 -bxy 1:2:3 \
#		-settype xydy	-block temp_xb1_stat			-graph 0 -bxy 1:2:3 \
#		-settype xydy	-block temp_hrs_tot				-graph 0 -bxy 1:2:3 \
#		-settype xydy	-block temp_hrs_stat			-graph 0 -bxy 1:2:3 \
#		-settype xydy	-block temp_solid_tot			-graph 0 -bxy 1:2:3 \
#		-settype xydy	-block temp_solid_stat			-graph 0 -bxy 1:2:3 \
#		-settype bar	-block temp_1kHz		-log y	-graph 1 -bxy 1:2 \
#		-settype bar	-block temp_hrs_rates	-log y	-graph 1 -bxy 1:2 \
#		-settype bar	-block temp_solid_rates	-log y	-graph 1 -bxy 1:2 \
#		-settype xy		-block temp_1day	 	-log y	-graph 2 -bxy 1:2 \
#		-settype xy		-block temp_1week	 	-log y	-graph 2 -bxy 1:2 \
#		-settype xy		-block temp_1month	 	-log y	-graph 2 -bxy 1:2 \
#		-settype xy		-block temp_1year		-log y	-graph 2 -bxy 1:2 \
#		-settype bar	-block temp_hrs_time	-log y	-graph 2 -bxy 1:2 \
#		-settype bar	-block temp_solid_time 	-log y	-graph 2 -bxy 1:2 \
#		-settype xydy	-block temp_hrs_azz_tot			-graph 3 -bxy 1:2:3 \
#		-settype xydy	-block temp_hrs_azz_stat		-graph 3 -bxy 1:2:3 \
#		-settype xydy	-block temp_solid_azz_tot		-graph 3 -bxy 1:2:3 \
#		-settype xydy	-block temp_solid_azz_stat		-graph 3 -bxy 1:2:3 \
#		-settype xy		-block temp_hrs_theta			-graph 4 -bxy 1:2 \
#		-settype xy		-block temp_solid_theta			-graph 4 -bxy 1:2 \
#		-settype xy		-block temp_hrs_q2				-graph 5 -bxy 1:2 \
#		-settype xy		-block temp_solid_q2			-graph 5 -bxy 1:2 \
#		-settype xy		-block temp_hrs_ep				-graph 6 -bxy 1:2 \
#		-settype xy		-block temp_solid_ep			-graph 6 -bxy 1:2 \
#		-settype xy		-block temp_wmin				-graph 7 -bxy 1:2 \
#		-settype xy		-block temp_hrs_w				-graph 7 -bxy 1:2 \
#		-settype xy		-block temp_solid_w				-graph 7 -bxy 1:2 \
#		-settype xy		-block temp_hrs_theta_q			-graph 8 -bxy 1:2 \
#		-settype xy		-block temp_solid_theta_q		-graph 8 -bxy 1:2 \
#		-p b1_proj_hrs_solid.par -noask
#
#gracebat -hdevice PNG -printfile b1_rates_bb_sbs.png \
#		-settype xy		-block temp_model_miller		-graph 0 -bxy 1:2 \
#		-settype xy		-block temp_model_nosea_mstw	-graph 0 -bxy 1:2 \
#		-settype xy		-block temp_model_sea_mstw		-graph 0 -bxy 1:2 \
#		-settype xy		-block temp_model_sargsian_vn	-graph 0 -bxy 1:2 \
#		-settype xy		-block temp_model_sargsian_lc	-graph 0 -bxy 1:2 \
#		-settype xy		-block temp_model_bacchetta_low	-graph 0 -bxy 1:2 \
#		-settype xy		-block temp_model_bacchetta_up	-graph 0 -bxy 1:2 \
#		-settype xydy	-block temp_xb1_tot				-graph 0 -bxy 1:2:3 \
#		-settype xydy	-block temp_xb1_stat			-graph 0 -bxy 1:2:3 \
#		-settype xydy	-block temp_bb_tot				-graph 0 -bxy 1:2:3 \
#		-settype xydy	-block temp_bb_stat				-graph 0 -bxy 1:2:3 \
#		-settype xydy	-block temp_sbs_tot				-graph 0 -bxy 1:2:3 \
#		-settype xydy	-block temp_sbs_stat			-graph 0 -bxy 1:2:3 \
#		-settype bar	-block temp_1kHz		-log y	-graph 1 -bxy 1:2 \
#		-settype bar	-block temp_bb_rates	-log y	-graph 1 -bxy 1:2 \
#		-settype bar	-block temp_sbs_rates	-log y	-graph 1 -bxy 1:2 \
#		-settype xy		-block temp_1day	 	-log y	-graph 2 -bxy 1:2 \
#		-settype xy		-block temp_1week	 	-log y	-graph 2 -bxy 1:2 \
#		-settype xy		-block temp_1month	 	-log y	-graph 2 -bxy 1:2 \
#		-settype xy		-block temp_1year		-log y	-graph 2 -bxy 1:2 \
#		-settype bar	-block temp_bb_time		-log y	-graph 2 -bxy 1:2 \
#		-settype bar	-block temp_sbs_time 	-log y	-graph 2 -bxy 1:2 \
#		-settype xydy	-block temp_bb_azz_tot			-graph 3 -bxy 1:2:3 \
#		-settype xydy	-block temp_bb_azz_stat			-graph 3 -bxy 1:2:3 \
#		-settype xydy	-block temp_sbs_azz_tot			-graph 3 -bxy 1:2:3 \
#		-settype xydy	-block temp_sbs_azz_stat		-graph 3 -bxy 1:2:3 \
#		-settype xy		-block temp_bb_theta			-graph 4 -bxy 1:2 \
#		-settype xy		-block temp_sbs_theta			-graph 4 -bxy 1:2 \
#		-settype xy		-block temp_bb_q2				-graph 5 -bxy 1:2 \
#		-settype xy		-block temp_sbs_q2				-graph 5 -bxy 1:2 \
#		-settype xy		-block temp_bb_ep				-graph 6 -bxy 1:2 \
#		-settype xy		-block temp_sbs_ep				-graph 6 -bxy 1:2 \
#		-settype xy		-block temp_wmin				-graph 7 -bxy 1:2 \
#		-settype xy		-block temp_bb_w				-graph 7 -bxy 1:2 \
#		-settype xy		-block temp_sbs_w				-graph 7 -bxy 1:2 \
#		-settype xy		-block temp_bb_theta_q			-graph 8 -bxy 1:2 \
#		-settype xy		-block temp_sbs_theta_q			-graph 8 -bxy 1:2 \
#		-p b1_proj_bb_sbs.par -noask



rm -f temp*
