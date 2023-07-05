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

file0="/home/ellie/physics/b1/b1_rates/from_patricia/models/SCRIPTS/table2.dat"
awk '$1!="#" {print $1,$3,$4}' $file0 > temp_Azz_stat
awk '$1!="#" {print $1,$3,sqrt($4*$4+$5*$5)}' $file0 > temp_Azz_tot

file_all_models="../../models/all_Azz_calculations.csv"
spec="S1"  # 8.8 GeV SHMS
#spec="H1"  # 8.8 GeV HMS
#spec="S2"  # 6.6 GeV SHMS
#spec="H2"  # 6.6 GeV HMS
#spec="S3"  # 2.2 GeV SHMS
#spec="H3"  # 2.2 GeV HMS
awk '$1=="'$spec'" && $2=="VN-AV18" && $5=="Misak" {print $3,$4}' $file_all_models > temp_misak_vn_av18
awk '$1=="'$spec'" && $2=="VN-CDBonn" && $5=="Misak" {print $3,$4}' $file_all_models > temp_misak_vn_cdbonn
awk '$1=="'$spec'" && $2=="LC-AV18" && $5=="Misak" {print $3,$4}' $file_all_models > temp_misak_lc_av18
awk '$1=="'$spec'" && $2=="LC-CDBonn" && $5=="Misak" {print $3,$4}' $file_all_models > temp_misak_lc_cdbonn
#awk '$1=="'$spec'" && $2=="AV18-Norm" && $5=="Arenhovel" {print $3,$4}' $file_all_models > temp_arenhovel_norm_av18
#awk '$1=="'$spec'" && $2=="AV18-Norm-Rel" && $5=="Arenhovel" {print $3,$4}' $file_all_models > temp_arenhovel_norm_av18_rel
#awk '$1=="'$spec'" && $2=="AV18-Norm-MEC" && $5=="Arenhovel" {print $3,$4}' $file_all_models > temp_arenhovel_norm_av18_mec
#awk '$1=="'$spec'" && $2=="AV18-Norm-MEC-IC" && $5=="Arenhovel" {print $3,$4}' $file_all_models > temp_arenhovel_norm_av18_mec_ic
awk '$1=="'$spec'" && $2=="AV18-Norm-MEC-IC-Rel" && $5=="Arenhovel" {print $3,$4}' $file_all_models > temp_arenhovel_norm_av18_mec_ic_rel
awk '$1=="'$spec'" && $2=="Bonn-Norm-MEC-IC-Rel" && $5=="Arenhovel" {print $3,$4}' $file_all_models > temp_arenhovel_norm_bonn_mec_ic_rel
#awk '$1=="'$spec'" && $2=="AV18-PWBA-NR" && $5=="Arenhovel" {print $3,$4}' $file_all_models > temp_arenhovel_av18_pwba_nr
awk '$1=="'$spec'" && $2=="AV18-PWBA-RC" && $5=="Arenhovel" {print $3,$4}' $file_all_models > temp_arenhovel_av18_pwba_rc
awk '$1=="'$spec'" && $2=="Bonn-PWBA-RC" && $5=="Arenhovel" {print $3,$4}' $file_all_models > temp_arenhovel_bonn_pwba_rc
awk '$1=="'$spec'" && $2=="PW-AV18" && $5=="Wim" {print $3,$4}' $file_all_models > temp_wim_pw_av18
awk '$1=="'$spec'" && $2=="PW-CDBonn" && $5=="Wim" {print $3,$4}' $file_all_models > temp_wim_pw_cdbonn
awk '$1=="'$spec'" && $2=="PW+FSIOff-AV18" && $5=="Wim" {print $3,$4}' $file_all_models > temp_wim_pw_fsioff_av18
awk '$1=="'$spec'" && $2=="PW+FSIOff-CDBonn" && $5=="Wim" {print $3,$4}' $file_all_models > temp_wim_pw_fsioff_cdbonn
awk '$1=="'$spec'" && $2=="PW+FSIOn-AV18" && $5=="Wim" {print $3,$4}' $file_all_models > temp_wim_pw_fsion_av18
awk '$1=="'$spec'" && $2=="PW+FSIOn-CDBonn" && $5=="Wim" {print $3,$4}' $file_all_models > temp_wim_pw_fsion_cdbonn



echo "100   100" > temp_model_miller_Azz
#hms_scale=`awk 'BEGIN{scale = 19/('$hms_csmax'-'$hms_csmin')} END {print scale}' $file6`


file_misak1="/home/ellie/physics/b1/b1_rates/from_patricia/models/misak_mark/vn-av18.dat"
file_misak2="/home/ellie/physics/b1/b1_rates/from_patricia/models/misak_mark/vn-cdbonn.dat"
file_misak3="/home/ellie/physics/b1/b1_rates/from_patricia/models/misak_mark/lc-av18.dat"
file_misak4="/home/ellie/physics/b1/b1_rates/from_patricia/models/misak_mark/lc-cdbonn.dat"
#awk '$1>0 && $1<100 {print $1,$2}' $file_misak1 > temp_misak_vn_av18
#awk '$1>0 && $1<100 {print $1,$2}' $file_misak2 > temp_misak_vn_cdbonn
#awk '$1>0 && $1<100 {print $1,$2}' $file_misak3 > temp_misak_lc_av18
#awk '$1>0 && $1<100 {print $1,$2}' $file_misak4 > temp_misak_lc_cdbonn

#awk '$1!="#" {print $1,0,$7}' $file0 > temp_xb1_stat
#awk '$1!="#" {print $1,0,sqrt($7*$7+$8*$8)}' $file0 > temp_xb1_tot
#awk '$1!="#" {print $1,0,$4}' $file0 > temp_Azz_stat
#awk '$1!="#" {print $1,0,sqrt($4*$4+$5*$5)}' $file0 > temp_Azz_tot


file_ah="/home/ellie/physics/b1/b1_rates/from_patricia/models/arenhovel/arenhovel_azz.dat"
awk '$1==0.3{print $12,$13}' $file_ah > temp_aren_03_av18
awk '$1==0.3{print $12,$14}' $file_ah > temp_aren_03_pwbanr
awk '$1==0.3{print $12,$15}' $file_ah > temp_aren_03_pwbarc
awk '$1==0.3{print $12,$16}' $file_ah > temp_aren_03_normMEC
awk '$1==0.3{print $12,$17}' $file_ah > temp_aren_03_normMECIC
awk '$1==0.3{print $12,$18}' $file_ah > temp_aren_03_normRel
awk '$1==0.3{print $12,$19}' $file_ah > temp_aren_03_normMECICRel

awk '$1==0.2{print $12,$13}' $file_ah > temp_aren_02_av18
awk '$1==0.2{print $12,$14}' $file_ah > temp_aren_02_pwbanr
awk '$1==0.2{print $12,$15}' $file_ah > temp_aren_02_pwbarc
awk '$1==0.2{print $12,$16}' $file_ah > temp_aren_02_normMEC
awk '$1==0.2{print $12,$17}' $file_ah > temp_aren_02_normMECIC
awk '$1==0.2{print $12,$18}' $file_ah > temp_aren_02_normRel
awk '$1==0.2{print $12,$19}' $file_ah > temp_aren_02_normMECICRel

awk '$1==1.8{print $12,$13}' $file_ah > temp_aren_18_av18
awk '$1==1.8{print $12,$14}' $file_ah > temp_aren_18_pwbanr
awk '$1==1.8{print $12,$15}' $file_ah > temp_aren_18_pwbarc
awk '$1==1.8{print $12,$16}' $file_ah > temp_aren_18_normMEC
awk '$1==1.8{print $12,$17}' $file_ah > temp_aren_18_normMECIC
awk '$1==1.8{print $12,$18}' $file_ah > temp_aren_18_normRel
awk '$1==1.8{print $12,$19}' $file_ah > temp_aren_18_normMECICRel

awk '$1==0.7{print $12,$13}' $file_ah > temp_aren_07_av18
awk '$1==0.7{print $12,$14}' $file_ah > temp_aren_07_pwbanr
awk '$1==0.7{print $12,$15}' $file_ah > temp_aren_07_pwbarc
awk '$1==0.7{print $12,$16}' $file_ah > temp_aren_07_normMEC
awk '$1==0.7{print $12,$17}' $file_ah > temp_aren_07_normMECIC
awk '$1==0.7{print $12,$18}' $file_ah > temp_aren_07_normRel
awk '$1==0.7{print $12,$19}' $file_ah > temp_aren_07_normMECICRel

awk '$1==2.9{print $12,$13}' $file_ah > temp_aren_29_av18
awk '$1==2.9{print $12,$14}' $file_ah > temp_aren_29_pwbanr
awk '$1==2.9{print $12,$15}' $file_ah > temp_aren_29_pwbarc
awk '$1==2.9{print $12,$16}' $file_ah > temp_aren_29_normMEC
awk '$1==2.9{print $12,$17}' $file_ah > temp_aren_29_normMECIC
awk '$1==2.9{print $12,$18}' $file_ah > temp_aren_29_normRel
awk '$1==2.9{print $12,$19}' $file_ah > temp_aren_29_normMECICRel

awk '$1==1.5{print $12,$13}' $file_ah > temp_aren_15_av18
awk '$1==1.5{print $12,$14}' $file_ah > temp_aren_15_pwbanr
awk '$1==1.5{print $12,$15}' $file_ah > temp_aren_15_pwbarc
awk '$1==1.5{print $12,$16}' $file_ah > temp_aren_15_normMEC
awk '$1==1.5{print $12,$17}' $file_ah > temp_aren_15_normMECIC
awk '$1==1.5{print $12,$18}' $file_ah > temp_aren_15_normRel
awk '$1==1.5{print $12,$19}' $file_ah > temp_aren_15_normMECICRel

file8="/home/ellie/physics/b1/b1_rates/from_patricia/models/output/Azz_frankfurt.dat"
awk '{print $1,$2}' $file8 > temp_model_frankfurt_Azz

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
file4="/home/ellie/physics/b1/b1_rates/from_patricia/rates/output/prop_table.out"
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
echo "0	0" > temp_hms_rates
echo "0	0" > temp_hms_totrates
echo "0	0" > temp_shms_rates
echo "0	0" > temp_shms_totrates
#awk '$1==1 && $2!="NaN" {print $29,$7}' $file4 > temp_hms_rates
#awk '$1==2 && $2!="NaN" {print $29,$7}' $file4 > temp_shms_rates
awk '$1==1 && $2!="NaN" && $29<2 {print $29,$7}' $file4 >> temp_hms_rates
awk '$1==1 && $2!="NaN" && $29>1.99 {print 0.7,$7}' $file4 >> temp_hms_rates
awk '$1==2 && $2!="NaN" && $29<2 {print $29,$7}' $file4 >> temp_shms_rates
awk '$1==2 && $2!="NaN" && $29>1.99 {print 0.7,$7}' $file4 >> temp_shms_rates
awk '$1==3 && $2!="NaN" {print $29,$7}' $file4 > temp_hrs_rates
awk '$1==4 && $2!="NaN" {print $29,$7}' $file4 > temp_solid_rates
awk '$1==5 && $2!="NaN" {print $29,$7}' $file4 > temp_bb_rates
awk '$1==6 && $2!="NaN" {print $29,$7}' $file4 > temp_sbs_rates
#awk '$1==1 && $2!="NaN" {print $29,$25}' $file4 > temp_hms_totrates
#awk '$1==2 && $2!="NaN" {print $29,$25}' $file4 > temp_shms_totrates
awk '$1==1 && $2!="NaN" && $29<2 {print $29,$25}' $file4 >> temp_hms_totrates
awk '$1==1 && $2!="NaN" && $29>1.99 {print 0.7,$25}' $file4 >> temp_hms_totrates
awk '$1==2 && $2!="NaN" && $29<2 {print $29,$25}' $file4 >> temp_shms_totrates
awk '$1==2 && $2!="NaN" && $29>1.99 {print 0.7,$25}' $file4 >> temp_shms_totrates
awk '$1==3 && $2!="NaN" {print $29,$25}' $file4 > temp_hrs_totrates
awk '$1==4 && $2!="NaN" {print $29,$25}' $file4 > temp_solid_totrates
awk '$1==5 && $2!="NaN" {print $29,$25}' $file4 > temp_bb_totrates
awk '$1==6 && $2!="NaN" {print $29,$25}' $file4 > temp_sbs_totrates


# This fills files that will be used to make bar graphs of the 
# time needed vs x_Bjorken
#awk '$1==1 && $2!="NaN" {print $29,$12}' $file4 > temp_hms_time
#awk '$1==2 && $2!="NaN" {print $29,$12}' $file4 > temp_shms_time
awk '$1==1 && $2!="NaN" && $29<2 {print $29,$12}' $file4 > temp_hms_time
awk '$1==1 && $2!="NaN" && $29>1.99 {print 0.7,$12}' $file4 > temp_hms_time
awk '$1==2 && $2!="NaN" && $29<2 {print $29,$12}' $file4 > temp_shms_time
awk '$1==2 && $2!="NaN" && $29>1.99 {print 0.7,$12}' $file4 > temp_shms_time
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
echo "0 10000" > temp_10kHz
echo "10 10000" >> temp_10kHz
echo "0 3000" > temp_3kHz
echo "10 3000" >> temp_3kHz
echo "0 1.85" > temp_wmin
echo "10 1.85" >> temp_wmin
echo "0 0.938" > temp_wqe
echo "10 0.938" >> temp_wqe
#echo "0 1.85" > temp_wnnmin
#echo "10 1.85" >> temp_wnnmin
echo "0 1.876" > temp_wnnmin
echo "10 1.876" >> temp_wnnmin
#echo "0 1.926" > temp_wnnqe
#echo "10 1.926" >> temp_wnnqe
echo "0 1.976" > temp_wnnqe
echo "10 1.976" >> temp_wnnqe

echo "0 7.3" > temp_thmin_shms
echo "10 7.3" >> temp_thmin_shms
echo "0 10.4" > temp_epmax_shms
echo "10 10.4" >> temp_epmax_shms

echo "0 7.3" > temp_epmax_hms
echo "10 7.3" >> temp_epmax_hms
#echo "0 10.5" > temp_thmin_hms
#echo "10 10.5" >> temp_thmin_hms
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
file7="/home/ellie/physics/b1/b1_rates/from_patricia/rates/output/rebinned-x.out"
#awk '$1==1 && $5!="NaN" {print $2,0,$3,$4}' $file7 > temp_hms_azz_stat
echo "100	0	0	0" > temp_hms_azz_stat
#awk '$1==2 && $5!="NaN" {print $2,$11,$3,$4}' $file7 > temp_shms_azz_stat
awk '$1==2 && $5!="NaN" {print $2,$11,0,$4}' $file7 > temp_shms_azz_stat
#awk '$1==2 && $5!="NaN" {print $2,0,$3,$4}' $file7 > temp_shms_azz_stat
#awk '$1==1 && $5!="NaN" {print $2,0,$3,$4}' $file7 > temp_hms_azz_tot
echo "100	0	0	0" > temp_hms_azz_tot
#awk '$1==2 && $5!="NaN" {print $2,$11,$3,$9}' $file7 > temp_shms_azz_tot
#awk '$1==2 && $5!="NaN" {print $2,0,$3,$4}' $file7 > temp_shms_azz_tot
awk '$1==2 && $5!="NaN" {print $2,$11,0,sqrt($4*$4+$9*$9)}' $file7 > temp_shms_azz_tot
#awk '$1==2 && $5!="NaN" {print $2,$11,$3,sqrt($4*$4+$9*$9)}' $file7 > temp_shms_azz_tot
#awk '$1==2 && $5!="NaN" {print $2,0,$3,sqrt($4*$4+$9*$9)}' $file7 > temp_shms_azz_tot

echo "x      Azz     dAzz_stat  dAzz_sys  Q^2  alpha_tn    t20    dt20_stat dt20_sys" > temp_azz_phys_tot
awk '$1==2 && $5!="NaN" {print $2,$11,$4,$9,$7,$22,$18,$19,$20}' $file7 >> temp_azz_phys_tot

echo "100	0	0	0" > temp_hms_stat
echo "100	0	0	0" > temp_hms_tot
awk '$1==2 && $5!="NaN" {print $2,$12,$3,$5}' $file7 > temp_shms_stat
#awk '$1==2 && $5!="NaN" {print $2,0,$3,$5}' $file7 > temp_shms_stat
#awk '$1==2 && $5!="NaN" {print $2,$12,$3,$10}' $file7 > temp_shms_tot
#awk '$1==2 && $5!="NaN" {print $2,0,$3,$5}' $file7 > temp_shms_tot
awk '$1==2 && $5!="NaN" {print $2,$12,$3,sqrt($5*$5+$10*$10)}' $file7 > temp_shms_tot
#awk '$1==2 && $5!="NaN" {print $2,0,$3,sqrt($5*$5+$10*$10)}' $file7 > temp_shms_tot

#awk '$1==2 && $5!="NaN" {print $2-$3,-0.025,"\n"$2-$3,-0.025+$9"\n"$2+$3,-0.025+$9,"\n"$2+$3,-0.025}' $file7 > temp_shms_azz_sys_bar
awk '$1==2 && $5!="NaN" {print $2-$3,-1.35,"\n"$2-$3,-1.35+sqrt($9*$9)"\n"$2+$3,-1.35+sqrt($9*$9),"\n"$2+$3,-1.35}' $file7 > temp_shms_azz_sys_bar
awk '$1==2 && $5!="NaN" {print $2-$3,-0.013,"\n"$2-$3,-0.013+$10"\n"$2+$3,-0.013+$10,"\n"$2+$3,-0.013}' $file7 > temp_shms_b1_sys_bar
#awk '$1==2 && $5!="NaN" {print $2-$3,-0.0065,"\n"$2-$3,-0.0065+$10"\n"$2+$3,-0.0065+$10,"\n"$2+$3,-0.0065}' $file7 > temp_shms_b1_sys_bar


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

file6="/home/ellie/physics/b1/b1_rates/from_patricia/rates/output/xs-take1.out"

hms_csmin=`awk 'BEGIN {min = 1000} {if ($1==1 && $2==1 && $14>0 && $10>0 && $10<1000 && $14<min) min=$14} END {print min}' $file6`
hms_csmax=`awk 'BEGIN {max = 0} {if ($1==1 && $2==1 && $14>0 && $10>0 && $10<1000 && $14>max) max=$14} END {print max}' $file6`
#hms_csmax="0.263E-05"
#hms_csmax="0.537E-04"
#hms_csmax="0.494E-04"
#hms_csmin="1E-30"
hms_scale=`awk 'BEGIN{scale = 19/('$hms_csmax'-'$hms_csmin')} END {print scale}' $file6`
echo "hms_csmin=" $hms_csmin
echo "hms_csmax=" $hms_csmax

shms_csmin=`awk 'BEGIN {min = 1000} {if ($1==2 && $2==1 && $14>0 && $10>0 && $10<1000 && $14<min) min=$14} END {print min}' $file6`
shms_csmax=`awk 'BEGIN {max = 0} {if ($1==2 && $2==1 && $14>0 && $10>0 && $10<1000 && $14>max) max=$14} END {print max}' $file6`
#shms_csmax=$hms_csmin
#shms_csmax="0.436E-04"
#shms_csmax="0.436E-149"
#shms_csmax="0.436E-149"
#shms_csmax="0.537E-04"
#shms_csmax="0.350E-03"
#shms_csmin="1E-30"
shms_scale=`awk 'BEGIN{scale = 19/('$shms_csmax'-'$shms_csmin')} END {print scale}' $file6`
echo "shms_csmin=" $shms_csmin
echo "shms_csmax=" $shms_csmax


hmsa_csmin=`awk 'BEGIN {min = 1000} {if ($1==1 && $2==1 && $26>0 && $10>0 && $10<1000 && $26<min) min=$26} END {print min}' $file6`
hmsa_csmax=`awk 'BEGIN {max = 0} {if ($1==1 && $2==1 && $26>0 && $10>0 && $10<1000 && $26>max) max=$26} END {print max}' $file6`
#hmsa_csmax="0.189E-03"
#hmsa_csmax="0.216E-03"
#hmsa_csmax="0.200E-03"
#hmsa_csmin="1E-30"
hmsa_scale=`awk 'BEGIN{scale = 19/('$hmsa_csmax'-'$hmsa_csmin')} END {print scale}' $file6`
echo "hmsa_csmin=" $hmsa_csmin
echo "hmsa_csmax=" $hmsa_csmax

shmsa_csmin=`awk 'BEGIN {min = 1000} {if ($1==2 && $2==1 && $26>0 && $10>0 && $10<1000 && $26<min) min=$26} END {print min}' $file6`
shmsa_csmax=`awk 'BEGIN {max = 0} {if ($1==2 && $2==1 && $26>0 && $10>0 && $10<1000 && $26>max) max=$26} END {print max}' $file6`
shmsa_csmax=$hmsa_csmin
#shmsa_csmax="0.189E-03"
#shmsa_csmax="0.216E-03"
#shmsa_csmax="0.115E-02"
#shmsa_csmin="1E-30"
shmsa_scale=`awk 'BEGIN{scale = 19/('$shmsa_csmax'-'$shmsa_csmin')} END {print scale}' $file6`
echo "shmsa_csmin=" $shmsa_csmin
echo "shmsa_csmax=" $shmsa_csmax



# This fills temporary files for Theta_e'
#   vvv Central Values vvv
awk '$1==1 && $2!="NaN" {print $29,$6}' $file4 > temp_hms_ctheta
echo "0.0	0.0" >> temp_hms_ctheta
#awk '$1==1 {print 1000,1000}' $file4 > temp_hms_ctheta
awk '$1==2 && $2!="NaN" {print $29,$6}' $file4 > temp_shms_ctheta
echo "0.0	0.0" >> temp_shms_ctheta
awk '$1==3 && $2!="NaN" {print $29,$6}' $file4 > temp_hrs_ctheta
awk '$1==4 && $2!="NaN" {print $29,$6}' $file4 > temp_solid_ctheta
awk '$1==5 && $2!="NaN" {print $29,$6}' $file4 > temp_bb_ctheta
awk '$1==6 && $2!="NaN" {print $29,$6}' $file4 > temp_sbs_ctheta
#   vvv Full Spread vvv
awk '$1==1 && $14>0 {print $10,$24}' $file6 > temp_hms_theta
awk '$1==1 && $2==1 && $14>0 && $10>0 && $10<1000 {print $10,$24,$14*'$hms_scale'+20}' $file6 > temp_hms_theta1
awk '$1==1 && $2==2 && $14>0 && $10>0 && $10<1000 {print $10,$24,$14*'$hms_scale'+20}' $file6 > temp_hms_theta2
awk '$1==1 && $2==3 && $14>0 && $10>0 && $10<1000 {print $10,$24,$14*'$hms_scale'+20}' $file6 > temp_hms_theta3
awk '$1==1 && $2==4 && $14>0 && $10>0 && $10<1000 {print $10,$24,$14*'$hms_scale'+20}' $file6 > temp_hms_theta4
awk '$1==1 && $2==5 && $14>0 && $10>0 && $10<1000 {print $10,$24,$14*'$hms_scale'+20}' $file6 > temp_hms_theta5
echo "0.0	0.0 0.0" >> temp_hms_ctheta
echo "0.0	0.0 0.0" >> temp_hms_theta1
echo "0.0	0.0 0.0" >> temp_hms_theta2
echo "0.0	0.0 0.0" >> temp_hms_theta3
echo "0.0	0.0 0.0" >> temp_hms_theta4
echo "0.0	0.0 0.0" >> temp_hms_theta5
#awk '$1==1 {print 1000,1000}' $file6 > temp_hms_theta
awk '$1==2 && $14>0 {print $10,$24}' $file6 > temp_shms_theta
awk '$1==2 && $2==1 && $14>0 && $10>0 && $10<1000 {print $10,$24,$14*'$shms_scale'+40}' $file6 > temp_shms_theta1
awk '$1==2 && $2==2 && $14>0 && $10>0 && $10<1000 {print $10,$24,$14*'$shms_scale'+40}' $file6 > temp_shms_theta2
awk '$1==2 && $2==3 && $14>0 && $10>0 && $10<1000 {print $10,$24,$14*'$shms_scale'+40}' $file6 > temp_shms_theta3
awk '$1==2 && $2==4 && $14>0 && $10>0 && $10<1000 {print $10,$24,$14*'$shms_scale'+40}' $file6 > temp_shms_theta4
awk '$1==2 && $2==5 && $14>0 && $10>0 && $10<1000 {print $10,$24,$14*'$shms_scale'+40}' $file6 > temp_shms_theta5
echo "0.0	0.0 0.0" >> temp_shms_ctheta
echo "0.0	0.0 0.0" >> temp_shms_theta1
echo "0.0	0.0 0.0" >> temp_shms_theta2
echo "0.0	0.0 0.0" >> temp_shms_theta3
echo "0.0	0.0 0.0" >> temp_shms_theta4
echo "0.0	0.0 0.0" >> temp_shms_theta5
awk '$1==3 && $14>0 {print $10,$24}' $file6 > temp_hrs_theta
awk '$1==4 && $14>0 {print $10,$24}' $file6 > temp_solid_theta
awk '$1==5 && $14>0 {print $10,$24}' $file6 > temp_bb_theta
awk '$1==6 && $14>0 {print $10,$24}' $file6 > temp_sbs_theta
#   vvv Include Non-Physics Events vvv
awk '$1==1 && $26>0 && $10>0 && $10<1000 {print $10,$24,$26*'$hmsa_scale'+60}' $file6 > temp_hms_atheta
#awk '$1==1 {print 1000,1000}' $file6 > temp_hms_atheta
awk '$1==2 && $26>0 && $10>0 && $10<1000 {print $10,$24,$26*'$shmsa_scale'+60}' $file6 > temp_shms_atheta
echo "0.0	0.0 0.0" >> temp_hms_atheta
echo "0.0	0.0 0.0" >> temp_shms_atheta
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
awk '$1==1 && $2==1 && $14>0 && $10>0 && $10<1000 {print $10,$25,$14*'$hms_scale'+20}' $file6 > temp_hms_theta_q1
awk '$1==1 && $2==2 && $14>0 && $10>0 && $10<1000 {print $10,$25,$14*'$hms_scale'+20}' $file6 > temp_hms_theta_q2
awk '$1==1 && $2==3 && $14>0 && $10>0 && $10<1000 {print $10,$25,$14*'$hms_scale'+20}' $file6 > temp_hms_theta_q3
awk '$1==1 && $2==4 && $14>0 && $10>0 && $10<1000 {print $10,$25,$14*'$hms_scale'+20}' $file6 > temp_hms_theta_q4
awk '$1==1 && $2==5 && $14>0 && $10>0 && $10<1000 {print $10,$25,$14*'$hms_scale'+20}' $file6 > temp_hms_theta_q5
echo "0.0	0.0	0.0" >> temp_hms_theta_cq
echo "0.0	0.0	0.0" >> temp_hms_theta_q1
echo "0.0	0.0	0.0" >> temp_hms_theta_q2
echo "0.0	0.0	0.0" >> temp_hms_theta_q3
echo "0.0	0.0	0.0" >> temp_hms_theta_q4
echo "0.0	0.0	0.0" >> temp_hms_theta_q5
#awk '$1==1 {print 1000,1000}' $file6 > temp_hms_theta_q
awk '$1==2 && $14>0 {print $10,$25}' $file6 > temp_shms_theta_q
awk '$1==2 && $2==1 && $14>0 && $10>0 && $10<1000 {print $10,$25,$14*'$shms_scale'+40}' $file6 > temp_shms_theta_q1
awk '$1==2 && $2==2 && $14>0 && $10>0 && $10<1000 {print $10,$25,$14*'$shms_scale'+40}' $file6 > temp_shms_theta_q2
awk '$1==2 && $2==3 && $14>0 && $10>0 && $10<1000 {print $10,$25,$14*'$shms_scale'+40}' $file6 > temp_shms_theta_q3
awk '$1==2 && $2==4 && $14>0 && $10>0 && $10<1000 {print $10,$25,$14*'$shms_scale'+40}' $file6 > temp_shms_theta_q4
awk '$1==2 && $2==5 && $14>0 && $10>0 && $10<1000 {print $10,$25,$14*'$shms_scale'+40}' $file6 > temp_shms_theta_q5
echo "0.0	0.0	0.0" >> temp_shms_theta_cq
echo "0.0	0.0	0.0" >> temp_shms_theta_q1
echo "0.0	0.0	0.0" >> temp_shms_theta_q2
echo "0.0	0.0	0.0" >> temp_shms_theta_q3
echo "0.0	0.0	0.0" >> temp_shms_theta_q4
echo "0.0	0.0	0.0" >> temp_shms_theta_q5
awk '$1==3 && $14>0 && $10>0 && $10<1000 {print $10,$25}' $file6 > temp_hrs_theta_q
awk '$1==4 && $14>0 && $10>0 && $10<1000 {print $10,$25}' $file6 > temp_solid_theta_q
awk '$1==5 && $14>0 && $10>0 && $10<1000 {print $10,$25}' $file6 > temp_bb_theta_q
awk '$1==6 && $14>0 && $10>0 && $10<1000 {print $10,$25}' $file6 > temp_sbs_theta_q
#   vvv Include Non-Physics Events vvv
awk '$1==1 && $26>0 && $10>0 && $10<1000 {print $10,$25,$26*'$hmsa_scale'+60}' $file6 > temp_hms_theta_aq
#awk '$1==1 {print 1000,1000}' $file6 > temp_hms_theta_aq
awk '$1==2 && $26>0 && $10>0 && $10<1000 {print $10,$25,$26*'$shmsa_scale'+60}' $file6 > temp_shms_theta_aq
awk '$1==3 && $26>0 && $10>0 && $10<1000 {print $10,$25}' $file6 > temp_hrs_theta_aq
awk '$1==4 && $26>0 && $10>0 && $10<1000 {print $10,$25}' $file6 > temp_solid_theta_aq
awk '$1==5 && $26>0 && $10>0 && $10<1000 {print $10,$25}' $file6 > temp_bb_theta_aq
awk '$1==6 && $26>0 && $10>0 && $10<1000 {print $10,$25}' $file6 > temp_sbs_theta_aq

echo "0.0	0.0	0.0" >> temp_hms_theta_aq
echo "0.0	0.0	0.0" >> temp_shms_theta_aq

# This fills temporary files for nu
#   vvv Central Values vvv
awk '$1==1 && $2!="NaN" {print $29,$33}' $file4 > temp_hms_nu_c
#awk '$1==1 {print 1000,1000}' $file4 > temp_hms_nu_c
awk '$1==2 && $2!="NaN" {print $29,$33}' $file4 > temp_shms_nu_c
awk '$1==3 && $2!="NaN" {print $29,$33}' $file4 > temp_hrs_nu_c
awk '$1==4 && $2!="NaN" {print $29,$33}' $file4 > temp_solid_nu_c
awk '$1==5 && $2!="NaN" {print $29,$33}' $file4 > temp_bb_nu_c
awk '$1==6 && $2!="NaN" {print $29,$33}' $file4 > temp_sbs_nu_c
#   vvv Full Spread vvv
awk '$1==1 && $14>0 {print $10,$28}' $file6 > temp_hms_nu
awk '$1==1 && $2==1 && $14>0 && $10>0 && $10<1000 {print $10,$28,$14*'$hms_scale'+20}' $file6 > temp_hms_nu1
awk '$1==1 && $2==2 && $14>0 && $10>0 && $10<1000 {print $10,$28,$14*'$hms_scale'+20}' $file6 > temp_hms_nu2
awk '$1==1 && $2==3 && $14>0 && $10>0 && $10<1000 {print $10,$28,$14*'$hms_scale'+20}' $file6 > temp_hms_nu3
awk '$1==1 && $2==4 && $14>0 && $10>0 && $10<1000 {print $10,$28,$14*'$hms_scale'+20}' $file6 > temp_hms_nu4
awk '$1==1 && $2==5 && $14>0 && $10>0 && $10<1000 {print $10,$28,$14*'$hms_scale'+20}' $file6 > temp_hms_nu5
echo "0.0	0.0	0.0" >> temp_hms_nu_c
echo "0.0	0.0	0.0" >> temp_hms_nu1
echo "0.0	0.0	0.0" >> temp_hms_nu2
echo "0.0	0.0	0.0" >> temp_hms_nu3
echo "0.0	0.0	0.0" >> temp_hms_nu4
echo "0.0	0.0	0.0" >> temp_hms_nu5
#awk '$1==1 {print 1000,1000}' $file6 > temp_hms_nu
awk '$1==2 && $14>0 {print $10,$28}' $file6 > temp_shms_nu
awk '$1==2 && $2==1 && $14>0 && $10>0 && $10<1000 {print $10,$28,$14*'$shms_scale'+40}' $file6 > temp_shms_nu1
awk '$1==2 && $2==2 && $14>0 && $10>0 && $10<1000 {print $10,$28,$14*'$shms_scale'+40}' $file6 > temp_shms_nu2
awk '$1==2 && $2==3 && $14>0 && $10>0 && $10<1000 {print $10,$28,$14*'$shms_scale'+40}' $file6 > temp_shms_nu3
awk '$1==2 && $2==4 && $14>0 && $10>0 && $10<1000 {print $10,$28,$14*'$shms_scale'+40}' $file6 > temp_shms_nu4
awk '$1==2 && $2==5 && $14>0 && $10>0 && $10<1000 {print $10,$28,$14*'$shms_scale'+40}' $file6 > temp_shms_nu5
echo "0.0	0.0	0.0" >> temp_shms_nu_c
echo "0.0	0.0	0.0" >> temp_shms_nu1
echo "0.0	0.0	0.0" >> temp_shms_nu2
echo "0.0	0.0	0.0" >> temp_shms_nu3
echo "0.0	0.0	0.0" >> temp_shms_nu4
echo "0.0	0.0	0.0" >> temp_shms_nu5
awk '$1==3 && $14>0 && $10>0 && $10<1000 {print $10,$28}' $file6 > temp_hrs_nu
awk '$1==4 && $14>0 && $10>0 && $10<1000 {print $10,$28}' $file6 > temp_solid_nu
awk '$1==5 && $14>0 && $10>0 && $10<1000 {print $10,$28}' $file6 > temp_bb_nu
awk '$1==6 && $14>0 && $10>0 && $10<1000 {print $10,$28}' $file6 > temp_sbs_nu
#   vvv Include Non-Physics Events vvv
awk '$1==1 && $26>0 && $10>0 && $10<1000 {print $10,$28,$26*'$hmsa_scale'+60}' $file6 > temp_hms_nu_a
#awk '$1==1 {print 1000,1000}' $file6 > temp_hms_nu_a
awk '$1==2 && $26>0 && $10>0 && $10<1000 {print $10,$28,$26*'$shmsa_scale'+60}' $file6 > temp_shms_nu_a
awk '$1==3 && $26>0 && $10>0 && $10<1000 {print $10,$28}' $file6 > temp_hrs_nu_a
awk '$1==4 && $26>0 && $10>0 && $10<1000 {print $10,$28}' $file6 > temp_solid_nu_a
awk '$1==5 && $26>0 && $10>0 && $10<1000 {print $10,$28}' $file6 > temp_bb_nu_a
awk '$1==6 && $26>0 && $10>0 && $10<1000 {print $10,$28}' $file6 > temp_sbs_nu_a

echo "0.0	0.0	0.0" >> temp_hms_nu_a
echo "0.0	0.0	0.0" >> temp_shms_nu_a


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
#awk '$1==1 && $2==1 && $14>0 && $10>0 && $10<1000 {print $10,$8}' $file6 > temp_hms_q21
awk '$1==1 && $2==1 && $14>0 && $10>0 && $10<1000 {print $10,$8,$14*'$hms_scale'+20}' $file6 > temp_hms_q21
awk '$1==1 && $2==2 && $14>0 && $10>0 && $10<1000 {print $10,$8,$14*'$hms_scale'+20}' $file6 > temp_hms_q22
awk '$1==1 && $2==3 && $14>0 && $10>0 && $10<1000 {print $10,$8,$14*'$hms_scale'+20}' $file6 > temp_hms_q23
awk '$1==1 && $2==4 && $14>0 && $10>0 && $10<1000 {print $10,$8,$14*'$hms_scale'+20}' $file6 > temp_hms_q24
awk '$1==1 && $2==5 && $14>0 && $10>0 && $10<1000 {print $10,$8,$14*'$hms_scale'+20}' $file6 > temp_hms_q25
echo "0.0	0.0	0.0" >> temp_hms_cq2
echo "0.0	0.0	0.0" >> temp_hms_q21
echo "0.0	0.0	0.0" >> temp_hms_q22
echo "0.0	0.0	0.0" >> temp_hms_q23
echo "0.0	0.0	0.0" >> temp_hms_q24
echo "0.0	0.0	0.0" >> temp_hms_q25
#awk '$1==1 {print 10000,10000}' $file6 > temp_hms_q2
awk '$1==2 && $14>0 {print $10,$8}' $file6 > temp_shms_q2
awk '$1==2 && $2==1 && $14>0 && $10>0 && $10<1000 {print $10,$8,$14*'$shms_scale'+40}' $file6 > temp_shms_q21
awk '$1==2 && $2==2 && $14>0 && $10>0 && $10<1000 {print $10,$8,$14*'$shms_scale'+40}' $file6 > temp_shms_q22
awk '$1==2 && $2==3 && $14>0 && $10>0 && $10<1000 {print $10,$8,$14*'$shms_scale'+40}' $file6 > temp_shms_q23
awk '$1==2 && $2==4 && $14>0 && $10>0 && $10<1000 {print $10,$8,$14*'$shms_scale'+40}' $file6 > temp_shms_q24
awk '$1==2 && $2==5 && $14>0 && $10>0 && $10<1000 {print $10,$8,$14*'$shms_scale'+40}' $file6 > temp_shms_q25
echo "0.0	0.0	0.0" >> temp_shms_cq2
echo "0.0	0.0	0.0" >> temp_shms_q21
echo "0.0	0.0	0.0" >> temp_shms_q22
echo "0.0	0.0	0.0" >> temp_shms_q23
echo "0.0	0.0	0.0" >> temp_shms_q24
echo "0.0	0.0	0.0" >> temp_shms_q25
awk '$1==3 && $14>0 {print $10,$8}' $file6 > temp_hrs_q2
awk '$1==4 && $14>0 {print $10,$8}' $file6 > temp_solid_q2
awk '$1==5 && $14>0 {print $10,$8}' $file6 > temp_bb_q2
awk '$1==6 && $14>0 {print $10,$8}' $file6 > temp_sbs_q2
#   vvv Include Non-Physics Events vvv
awk '$1==1 && $2==1 && $26>0 && $10>0 && $10<1000 {print $10,$8,$26*'$hmsa_scale'+60}' $file6 > temp_hms_aq2
#awk '$1==1 {print 10000,10000}' $file6 > temp_hms_aq2
awk '$1==2 && $2==1 && $26>0 && $10>0 && $10<1000 {print $10,$8,$26*'$shmsa_scale'+60}' $file6 > temp_shms_aq2
awk '$1==3 && $26>0 && $10>0 && $10<1000 {print $10,$8}' $file6 > temp_hrs_aq2
awk '$1==4 && $26>0 && $10>0 && $10<1000 {print $10,$8}' $file6 > temp_solid_aq2
awk '$1==5 && $26>0 && $10>0 && $10<1000 {print $10,$8}' $file6 > temp_bb_aq2
awk '$1==6 && $26>0 && $10>0 && $10<1000 {print $10,$8}' $file6 > temp_sbs_aq2
echo "0.0	0.0	0.0" >> temp_hms_aq2
echo "0.0	0.0	0.0" >> temp_shms_aq2


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
awk '$1==1 && $2==1 && $14>0 && $10>0 && $10<1000 {print $10,$23,$14*'$hms_scale'+20}' $file6 > temp_hms_ep1
awk '$1==1 && $2==2 && $14>0 && $10>0 && $10<1000 {print $10,$23,$14*'$hms_scale'+20}' $file6 > temp_hms_ep2
awk '$1==1 && $2==3 && $14>0 && $10>0 && $10<1000 {print $10,$23,$14*'$hms_scale'+20}' $file6 > temp_hms_ep3
awk '$1==1 && $2==4 && $14>0 && $10>0 && $10<1000 {print $10,$23,$14*'$hms_scale'+20}' $file6 > temp_hms_ep4
awk '$1==1 && $2==5 && $14>0 && $10>0 && $10<1000 {print $10,$23,$14*'$hms_scale'+20}' $file6 > temp_hms_ep5
echo "0.0	0.0	0.0" >> temp_hms_cep
echo "0.0	0.0	0.0" >> temp_hms_ep1
echo "0.0	0.0	0.0" >> temp_hms_ep2
echo "0.0	0.0	0.0" >> temp_hms_ep3
echo "0.0	0.0	0.0" >> temp_hms_ep4
echo "0.0	0.0	0.0" >> temp_hms_ep5
#awk '$1==1 {print 1000,1000}' $file6 > temp_hms_ep
awk '$1==2 && $14>0 {print $10,$23}' $file6 > temp_shms_ep
awk '$1==2 && $2==1 && $14>0 && $10>0 && $10<1000 {print $10,$23,$14*'$shms_scale'+40}' $file6 > temp_shms_ep1
awk '$1==2 && $2==2 && $14>0 && $10>0 && $10<1000 {print $10,$23,$14*'$shms_scale'+40}' $file6 > temp_shms_ep2
awk '$1==2 && $2==3 && $14>0 && $10>0 && $10<1000 {print $10,$23,$14*'$shms_scale'+40}' $file6 > temp_shms_ep3
awk '$1==2 && $2==4 && $14>0 && $10>0 && $10<1000 {print $10,$23,$14*'$shms_scale'+40}' $file6 > temp_shms_ep4
awk '$1==2 && $2==5 && $14>0 && $10>0 && $10<1000 {print $10,$23,$14*'$shms_scale'+40}' $file6 > temp_shms_ep5
echo "0.0	0.0	0.0" >> temp_shms_cep
echo "0.0	0.0	0.0" >> temp_shms_ep1
echo "0.0	0.0	0.0" >> temp_shms_ep2
echo "0.0	0.0	0.0" >> temp_shms_ep3
echo "0.0	0.0	0.0" >> temp_shms_ep4
echo "0.0	0.0	0.0" >> temp_shms_ep5
awk '$1==3 && $14>0 && $10>0 && $10<1000 {print $10,$23}' $file6 > temp_hrs_ep
awk '$1==4 && $14>0 && $10>0 && $10<1000 {print $10,$23}' $file6 > temp_solid_ep
awk '$1==5 && $14>0 && $10>0 && $10<1000 {print $10,$23}' $file6 > temp_bb_ep
awk '$1==6 && $14>0 && $10>0 && $10<1000 {print $10,$23}' $file6 > temp_sbs_ep
#   vvv Include Non-Physics Events vvv
awk '$1==1 && $26>0 && $10>0 && $10<1000 {print $10,$23,$26*'$hmsa_scale'+60}' $file6 > temp_hms_aep
#awk '$1==1 {print 1000,1000}' $file6 > temp_hms_aep
awk '$1==2 && $26>0 && $10>0 && $10<1000 {print $10,$23,$26*'$shmsa_scale'+60}' $file6 > temp_shms_aep
awk '$1==3 && $26>0 && $10>0 && $10<1000 {print $10,$23}' $file6 > temp_hrs_aep
awk '$1==4 && $26>0 && $10>0 && $10<1000 {print $10,$23}' $file6 > temp_solid_aep
awk '$1==5 && $26>0 && $10>0 && $10<1000 {print $10,$23}' $file6 > temp_bb_aep
awk '$1==6 && $26>0 && $10>0 && $10<1000 {print $10,$23}' $file6 > temp_sbs_aep
echo "0.0	0.0	0.0" >> temp_hms_aep
echo "0.0	0.0	0.0" >> temp_shms_aep



# This fills temporary files for E_0
awk '$1==2 {print 0,$23}' $file4 > temp_hms_e0
awk '$1==2 {print 10,$23}' $file4 >> temp_hms_e0
awk '$1==3 && $2==0.10 {print 0,$23}' $file4 > temp_hrs_e0
awk '$1==3 && $2==0.10 {print 10,$23}' $file4 >> temp_hrs_e0
awk '$1==5 && $2==0.10 {print 0,$23}' $file4 > temp_bb_e0
awk '$1==5 && $2==0.10 {print 10,$23}' $file4 >> temp_bb_e0


# This fills temporary files for W
#   vvv Central Values vvv
awk '$1==1 && $2!="NaN" && $4!="NaN" {print $29,$4}' $file4 > temp_hms_cw
#awk '$1==1 {print 1000,1000}' $file4 > temp_hms_cw
awk '$1==2 && $2!="NaN" {print $29,$4}' $file4 > temp_shms_cw
awk '$1==3 && $2!="NaN" {print $29,$4}' $file4 > temp_hrs_cw
awk '$1==4 && $2!="NaN" {print $29,$4}' $file4 > temp_solid_cw
awk '$1==5 && $2!="NaN" {print $29,$4}' $file4 > temp_bb_cw
awk '$1==6 && $2!="NaN" {print $29,$4}' $file4 > temp_sbs_cw
#   vvv Full Spread vvv
awk '$1==1 && $14>0 && $12>0 {print $10,sqrt($12)}' $file6 > temp_hms_w
awk '$1==1 && $2==1 && $14>0 && $12>0 && $10>0 && $10<1000 {print $10,sqrt($12),$14*'$hms_scale'+20}' $file6 > temp_hms_w1
awk '$1==1 && $2==2 && $14>0 && $12>0 && $10>0 && $10<1000 {print $10,sqrt($12),$14*'$hms_scale'+20}' $file6 > temp_hms_w2
awk '$1==1 && $2==3 && $14>0 && $12>0 && $10>0 && $10<1000 {print $10,sqrt($12),$14*'$hms_scale'+20}' $file6 > temp_hms_w3
awk '$1==1 && $2==4 && $14>0 && $12>0 && $10>0 && $10<1000 {print $10,sqrt($12),$14*'$hms_scale'+20}' $file6 > temp_hms_w4
awk '$1==1 && $2==5 && $14>0 && $12>0 && $10>0 && $10<1000 {print $10,sqrt($12),$14*'$hms_scale'+20}' $file6 > temp_hms_w5
echo "0.0	0.0	0.0" >> temp_hms_cw
echo "0.0	0.0	0.0" >> temp_hms_w1
echo "0.0	0.0	0.0" >> temp_hms_w2
echo "0.0	0.0	0.0" >> temp_hms_w3
echo "0.0	0.0	0.0" >> temp_hms_w4
echo "0.0	0.0	0.0" >> temp_hms_w5
#awk '$1==1 {print 1000,1000}' $file6 > temp_hms_w
awk '$1==2 && $14>0 && $12>0 {print $10,sqrt($12)}' $file6 > temp_shms_w
awk '$1==2 && $2==1 && $14>0 && $12>0 && $10>0 && $10<1000 {print $10,sqrt($12),$14*'$shms_scale'+40}' $file6 > temp_shms_w1
awk '$1==2 && $2==2 && $14>0 && $12>0 && $10>0 && $10<1000 {print $10,sqrt($12),$14*'$shms_scale'+40}' $file6 > temp_shms_w2
awk '$1==2 && $2==3 && $14>0 && $12>0 && $10>0 && $10<1000 {print $10,sqrt($12),$14*'$shms_scale'+40}' $file6 > temp_shms_w3
awk '$1==2 && $2==4 && $14>0 && $12>0 && $10>0 && $10<1000 {print $10,sqrt($12),$14*'$shms_scale'+40}' $file6 > temp_shms_w4
awk '$1==2 && $2==5 && $14>0 && $12>0 && $10>0 && $10<1000 {print $10,sqrt($12),$14*'$shms_scale'+40}' $file6 > temp_shms_w5
echo "0.0	0.0	0.0" >> temp_shms_cw
echo "0.0	0.0	0.0" >> temp_shms_w1
echo "0.0	0.0	0.0" >> temp_shms_w2
echo "0.0	0.0	0.0" >> temp_shms_w3
echo "0.0	0.0	0.0" >> temp_shms_w4
echo "0.0	0.0	0.0" >> temp_shms_w5
awk '$1==3 && $14>0 && $12>0 {print $10,sqrt($12)}' $file6 > temp_hrs_w
awk '$1==4 && $14>0 && $12>0 {print $10,sqrt($12)}' $file6 > temp_solid_w
awk '$1==5 && $14>0 && $12>0 {print $10,sqrt($12)}' $file6 > temp_bb_w
awk '$1==6 && $14>0 && $12>0 {print $10,sqrt($12)}' $file6 > temp_sbs_w
#   vvv Include Non-Physics Events vvv
awk '$1==1 && $2==1 && $26>0 && $12>0 && $10>0 && $10<1000 {print $10,sqrt($12),$26*'$hmsa_scale'+60}' $file6 > temp_hms_aw
#awk '$1==1 {print 1000,1000}' $file6 > temp_hms_aw
awk '$1==2 && $26>0 && $12>0 && $10>0 && $10<1000 {print $10,sqrt($12),$26*'$shmsa_scale'+60}' $file6 > temp_shms_aw
awk '$1==3 && $26>0 && $12>0 && $10>0 && $10<1000 {print $10,sqrt($12)}' $file6 > temp_hrs_aw
awk '$1==4 && $26>0 && $12>0 && $10>0 && $10<1000 {print $10,sqrt($12)}' $file6 > temp_solid_aw
awk '$1==5 && $26>0 && $12>0 && $10>0 && $10<1000 {print $10,sqrt($12)}' $file6 > temp_bb_aw
awk '$1==6 && $26>0 && $12>0 && $10>0 && $10<1000 {print $10,sqrt($12)}' $file6 > temp_sbs_aw
echo "0.0	0.0	0.0" >> temp_hms_aw
echo "0.0	0.0	0.0" >> temp_shms_aw


# This fills temporary files for W_NN
#   vvv Central Values vvv
awk '$1==1 && $2!="NaN" && $35!="NaN" {print $29,$35}' $file4 > temp_hms_cwnn
#awk '$1==1 {print 1000,1000}' $file4 > temp_hms_cwnn
awk '$1==2 && $2!="NaN" {print $29,$35}' $file4 > temp_shms_cwnn
awk '$1==3 && $2!="NaN" {print $29,$35}' $file4 > temp_hrs_cwnn
awk '$1==4 && $2!="NaN" {print $29,$35}' $file4 > temp_solid_cwnn
awk '$1==5 && $2!="NaN" {print $29,$35}' $file4 > temp_bb_cwnn
awk '$1==6 && $2!="NaN" {print $29,$35}' $file4 > temp_sbs_cwnn
#   vvv Full Spread vvv
awk '$1==1 && $14>0 && $12>0 {print $10,$30}' $file6 > temp_hms_wnn
awk '$1==1 && $2==1 && $14>0 && $12>0 && $10>0 && $10<1000 {print $10,$30,$14*'$hms_scale'+20}' $file6 > temp_hms_wnn1
awk '$1==1 && $2==2 && $14>0 && $12>0 && $10>0 && $10<1000 {print $10,$30,$14*'$hms_scale'+20}' $file6 > temp_hms_wnn2
awk '$1==1 && $2==3 && $14>0 && $12>0 && $10>0 && $10<1000 {print $10,$30,$14*'$hms_scale'+20}' $file6 > temp_hms_wnn3
awk '$1==1 && $2==4 && $14>0 && $12>0 && $10>0 && $10<1000 {print $10,$30,$14*'$hms_scale'+20}' $file6 > temp_hms_wnn4
awk '$1==1 && $2==5 && $14>0 && $12>0 && $10>0 && $10<1000 {print $10,$30,$14*'$hms_scale'+20}' $file6 > temp_hms_wnn5
echo "0.0	0.0	0.0" >> temp_hms_cwnn
echo "0.0	0.0	0.0" >> temp_hms_wnn1
echo "0.0	0.0	0.0" >> temp_hms_wnn2
echo "0.0	0.0	0.0" >> temp_hms_wnn3
echo "0.0	0.0	0.0" >> temp_hms_wnn4
echo "0.0	0.0	0.0" >> temp_hms_wnn5
#awk '$1==1 {print 1000,1000}' $file6 > temp_hms_wnn
awk '$1==2 && $14>0 && $12>0 {print $10,$30}' $file6 > temp_shms_wnn
awk '$1==2 && $2==1 && $14>0 && $12>0 && $10>0 && $10<1000 {print $10,$30,$14*'$shms_scale'+40}' $file6 > temp_shms_wnn1
awk '$1==2 && $2==2 && $14>0 && $12>0 && $10>0 && $10<1000 {print $10,$30,$14*'$shms_scale'+40}' $file6 > temp_shms_wnn2
awk '$1==2 && $2==3 && $14>0 && $12>0 && $10>0 && $10<1000 {print $10,$30,$14*'$shms_scale'+40}' $file6 > temp_shms_wnn3
awk '$1==2 && $2==4 && $14>0 && $12>0 && $10>0 && $10<1000 {print $10,$30,$14*'$shms_scale'+40}' $file6 > temp_shms_wnn4
awk '$1==2 && $2==5 && $14>0 && $12>0 && $10>0 && $10<1000 {print $10,$30,$14*'$shms_scale'+40}' $file6 > temp_shms_wnn5
echo "0.0	0.0	0.0" >> temp_shms_cwnn
echo "0.0	0.0	0.0" >> temp_shms_wnn1
echo "0.0	0.0	0.0" >> temp_shms_wnn2
echo "0.0	0.0	0.0" >> temp_shms_wnn3
echo "0.0	0.0	0.0" >> temp_shms_wnn4
echo "0.0	0.0	0.0" >> temp_shms_wnn5
awk '$1==3 && $14>0 && $12>0 {print $10,$30}' $file6 > temp_hrs_wnn
awk '$1==4 && $14>0 && $12>0 {print $10,$30}' $file6 > temp_solid_wnn
awk '$1==5 && $14>0 && $12>0 {print $10,$30}' $file6 > temp_bb_wnn
awk '$1==6 && $14>0 && $12>0 {print $10,$30}' $file6 > temp_sbs_wnn
#   vvv Include Non-Physics Events vvv
awk '$1==1 && $2==1 && $26>0 && $12>0 && $10>0 && $10<1000 {print $10,$30,$26*'$hmsa_scale'+60}' $file6 > temp_hms_awnn
#awk '$1==1 {print 1000,1000}' $file6 > temp_hms_awnn
awk '$1==2 && $26>0 && $12>0 && $10>0 && $10<1000 {print $10,$30,$26*'$shmsa_scale'+60}' $file6 > temp_shms_awnn
awk '$1==3 && $26>0 && $12>0 && $10>0 && $10<1000 {print $10,$30}' $file6 > temp_hrs_awnn
awk '$1==4 && $26>0 && $12>0 && $10>0 && $10<1000 {print $10,$30}' $file6 > temp_solid_awnn
awk '$1==5 && $26>0 && $12>0 && $10>0 && $10<1000 {print $10,$30}' $file6 > temp_bb_awnn
awk '$1==6 && $26>0 && $12>0 && $10>0 && $10<1000 {print $10,$30}' $file6 > temp_sbs_awnn
echo "0.0	0.0	0.0" >> temp_hms_awnn
echo "0.0	0.0	0.0" >> temp_shms_awnn


file9="/home/ellie/physics/b1/b1_rates/from_patricia/rates/output/cs-check-shms.out"
file10="/home/ellie/physics/b1/b1_rates/from_patricia/rates/output/cs-check-hms.out"
awk '$12!="NaN" {print $1,$12}' $file9 > temp_shms_fdil
awk '$12!="NaN" {print $1,$12}' $file10 > temp_hms_fdil




#xmgrace \
gracebat -hdevice PNG -printfile Azz_rates_hms_shms.png \
		-settype xy		-block temp_shms_fdil				-graph 0 -bxy 1:2 \
		-settype xy		-block temp_hms_fdil				-graph 0 -bxy 1:2 \
		-settype bar		-block temp_1kHz				-graph 1 -bxy 1:2 \
		-settype bar		-block temp_10kHz				-graph 1 -bxy 1:2 \
		-settype xy		-block temp_3kHz				-graph 1 -bxy 1:2 \
		-settype bar		-block temp_shms_totrates			-graph 1 -bxy 1:2 \
		-settype bar		-block temp_shms_rates				-graph 1 -bxy 1:2 \
		-settype bar		-block temp_hms_totrates			-graph 1 -bxy 1:2 \
		-settype bar		-block temp_hms_rates				-graph 1 -bxy 1:2 \
		-settype xy		-block temp_1day	 			-graph 2 -bxy 1:2 \
		-settype xy		-block temp_1week	 			-graph 2 -bxy 1:2 \
		-settype xy		-block temp_1month	 			-graph 2 -bxy 1:2 \
		-settype xy		-block temp_1year				-graph 2 -bxy 1:2 \
		-settype bar		-block temp_hms_pactm				-graph 2 -bxy 1:2 \
		-settype bar		-block temp_hms_time				-graph 2 -bxy 1:2 \
		-settype bar		-block temp_shms_pactm 				-graph 2 -bxy 1:2 \
		-settype bar		-block temp_shms_time 				-graph 2 -bxy 1:2 \
		-settype xy   		-block temp_misak_vn_av18	 		-graph 3 -bxy 1:2 \
		-settype xy   		-block temp_misak_lc_av18			-graph 3 -bxy 1:2 \
		-settype xy   		-block temp_model_miller_Azz			-graph 3 -bxy 1:2 \
		-settype xy   		-block temp_model_frankfurt_Azz			-graph 3 -bxy 1:2 \
		-settype xydy 		-block temp_Azz_stat         			-graph 3 -bxy 1:2:3 \
		-settype xydy 		-block temp_Azz_tot          			-graph 3 -bxy 1:2:3 \
		-settype xydxdy		-block temp_hms_azz_tot				-graph 3 -bxy 1:2:3:4 \
		-settype xydxdy		-block temp_hms_azz_stat			-graph 3 -bxy 1:2:3:4 \
		-settype xydxdy		-block temp_shms_azz_tot			-graph 3 -bxy 1:2:3:4 \
		-settype xydxdy		-block temp_shms_azz_stat			-graph 3 -bxy 1:2:3:4 \
	        -settype xy     	-block temp_shms_azz_sys_bar   			-graph 3 -bxy 1:2 \
		-settype xy   		-block temp_misak_vn_cdbonn	 		-graph 3 -bxy 1:2 \
		-settype xy   		-block temp_misak_lc_cdbonn			-graph 3 -bxy 1:2 \
		-settype xy		-block temp_thmin_hms				-graph 4 -bxy 1:2 \
		-settype xy		-block temp_thmin_shms				-graph 4 -bxy 1:2 \
		-settype xycolor	-block temp_hms_atheta				-graph 4 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_atheta				-graph 4 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_theta1				-graph 4 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_theta2				-graph 4 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_theta3				-graph 4 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_theta4				-graph 4 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_theta5				-graph 4 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_theta1				-graph 4 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_theta2				-graph 4 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_theta3				-graph 4 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_theta4				-graph 4 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_theta5				-graph 4 -bxy 1:2:3 \
		-settype xy		-block temp_hms_ctheta				-graph 4 -bxy 1:2 \
		-settype xy		-block temp_shms_ctheta				-graph 4 -bxy 1:2 \
		-settype xycolor	-block temp_hms_aq2				-graph 5 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_aq2				-graph 5 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_q21				-graph 5 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_q22				-graph 5 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_q23				-graph 5 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_q24				-graph 5 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_q25				-graph 5 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_q21				-graph 5 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_q22				-graph 5 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_q23				-graph 5 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_q24				-graph 5 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_q25				-graph 5 -bxy 1:2:3 \
		-settype xy		-block temp_hms_cq2				-graph 5 -bxy 1:2 \
		-settype xy		-block temp_shms_cq2				-graph 5 -bxy 1:2 \
		-settype xy		-block temp_hms_e0				-graph 6 -bxy 1:2 \
		-settype xy		-block temp_epmax_hms				-graph 6 -bxy 1:2 \
		-settype xy		-block temp_epmax_shms				-graph 6 -bxy 1:2 \
		-settype xycolor	-block temp_hms_aep				-graph 6 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_aep				-graph 6 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_ep1				-graph 6 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_ep2				-graph 6 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_ep3				-graph 6 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_ep4				-graph 6 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_ep5				-graph 6 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_ep1				-graph 6 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_ep2				-graph 6 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_ep3				-graph 6 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_ep4				-graph 6 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_ep5				-graph 6 -bxy 1:2:3 \
		-settype xy		-block temp_hms_cep				-graph 6 -bxy 1:2 \
		-settype xy		-block temp_shms_cep				-graph 6 -bxy 1:2 \
		-settype xy		-block temp_wqe					-graph 7 -bxy 1:2 \
		-settype xy		-block temp_wmin				-graph 7 -bxy 1:2 \
		-settype xycolor	-block temp_hms_aw				-graph 7 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_aw				-graph 7 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_w1				-graph 7 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_w2				-graph 7 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_w3				-graph 7 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_w4				-graph 7 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_w5				-graph 7 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_w1				-graph 7 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_w2				-graph 7 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_w3				-graph 7 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_w4				-graph 7 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_w5				-graph 7 -bxy 1:2:3 \
		-settype xy		-block temp_hms_cw				-graph 7 -bxy 1:2 \
		-settype xy		-block temp_shms_cw				-graph 7 -bxy 1:2 \
		-settype xycolor	-block temp_hms_theta_aq			-graph 8 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_theta_aq			-graph 8 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_theta_q1			-graph 8 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_theta_q2			-graph 8 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_theta_q3			-graph 8 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_theta_q4			-graph 8 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_theta_q5			-graph 8 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_theta_q1			-graph 8 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_theta_q2			-graph 8 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_theta_q3			-graph 8 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_theta_q4			-graph 8 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_theta_q5			-graph 8 -bxy 1:2:3 \
		-settype xy		-block temp_hms_theta_cq			-graph 8 -bxy 1:2 \
		-settype xy		-block temp_shms_theta_cq			-graph 8 -bxy 1:2 \
		-settype xycolor	-block temp_hms_nu_a				-graph 9 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_nu_a				-graph 9 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_nu1				-graph 9 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_nu2				-graph 9 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_nu3				-graph 9 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_nu4				-graph 9 -bxy 1:2:3 \
		-settype xycolor	-block temp_hms_nu5				-graph 9 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_nu1				-graph 9 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_nu2				-graph 9 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_nu3				-graph 9 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_nu4				-graph 9 -bxy 1:2:3 \
		-settype xycolor	-block temp_shms_nu5				-graph 9 -bxy 1:2:3 \
		-settype xy		-block temp_hms_nu_c				-graph 9 -bxy 1:2 \
		-settype xy		-block temp_shms_nu_c				-graph 9 -bxy 1:2 \
		-p /home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/Azz_proj_hms_shms_png.par -noask 
		-p /home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/Azz_proj_hms_shms.par -noask 
		-p /home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/Azz_proj_hms_shms2.par -noask 


display Azz_rates_hms_shms.png

xmgrace \
		-settype xy		-block temp_shms_fdil				-graph 0 -bxy 1:2 \
		-settype xy		-block temp_hms_fdil				-graph 0 -bxy 1:2 \
		-settype xy   		-block temp_misak_vn_av18	 		-graph 3 -bxy 1:2 \
		-settype xy   		-block temp_misak_lc_av18			-graph 3 -bxy 1:2 \
		-settype xy   		-block temp_model_miller_Azz			-graph 3 -bxy 1:2 \
		-settype xy   		-block temp_model_frankfurt_Azz			-graph 3 -bxy 1:2 \
		-settype xydy 		-block temp_Azz_stat         			-graph 3 -bxy 1:2:3 \
		-settype xydy 		-block temp_Azz_tot          			-graph 3 -bxy 1:2:3 \
		-settype xydxdy		-block temp_hms_azz_tot				-graph 3 -bxy 1:2:3:4 \
		-settype xydxdy		-block temp_hms_azz_stat			-graph 3 -bxy 1:2:3:4 \
		-settype xydxdy		-block temp_shms_azz_tot			-graph 3 -bxy 1:2:3:4 \
		-settype xydxdy		-block temp_shms_azz_stat			-graph 3 -bxy 1:2:3:4 \
	        -settype xy     	-block temp_shms_azz_sys_bar   			-graph 3 -bxy 1:2 \
		-settype xy   		-block temp_misak_vn_cdbonn	 		-graph 3 -bxy 1:2 \
		-settype xy   		-block temp_misak_lc_cdbonn			-graph 3 -bxy 1:2 \
 		-settype xy   		-block temp_arenhovel_norm_av18_mec_ic_rel	-graph 3 -bxy 1:2 \
 		-settype xy   		-block temp_arenhovel_norm_bonn_mec_ic_rel	-graph 3 -bxy 1:2 \
 		-settype xy   		-block temp_arenhovel_av18_pwba_rc		-graph 3 -bxy 1:2 \
 		-settype xy   		-block temp_arenhovel_bonn_pwba_rc		-graph 3 -bxy 1:2 \
 		-settype xy   		-block temp_wim_pw_av18				-graph 3 -bxy 1:2 \
 		-settype xy   		-block temp_wim_pw_cdbonn			-graph 3 -bxy 1:2 \
 		-settype xy   		-block temp_wim_pw_fsioff_av18			-graph 3 -bxy 1:2 \
 		-settype xy   		-block temp_wim_pw_fsioff_cdbonn		-graph 3 -bxy 1:2 \
 		-settype xy   		-block temp_wim_pw_fsion_av18			-graph 3 -bxy 1:2 \
 		-settype xy   		-block temp_wim_pw_fsion_cdbonn			-graph 3 -bxy 1:2 \
	-p /home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/Azz_proj_hms_shms.par -noask 

#
#xmgrace \
#		-settype bar		-block temp_1kHz			-log y	-graph 1 -bxy 1:2 \
#		-settype bar		-block temp_10kHz			-log y	-graph 1 -bxy 1:2 \
#		-settype xy			-block temp_3kHz			-log y	-graph 1 -bxy 1:2 \
#		-settype bar		-block temp_shms_totrates	-log y	-graph 1 -bxy 1:2 \
#		-settype bar		-block temp_shms_rates		-log y	-graph 1 -bxy 1:2 \
#		-settype bar		-block temp_hms_totrates	-log y	-graph 1 -bxy 1:2 \
#		-settype bar		-block temp_hms_rates		-log y	-graph 1 -bxy 1:2 \
#		-p /home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/Azz_proj_hms_shms.par -noask 
#
#xmgrace \
#		-settype xy			-block temp_1day	 		-log y	-graph 2 -bxy 1:2 \
#		-settype xy			-block temp_1week	 		-log y	-graph 2 -bxy 1:2 \
#		-settype xy			-block temp_1month	 		-log y	-graph 2 -bxy 1:2 \
#		-settype xy			-block temp_1year			-log y	-graph 2 -bxy 1:2 \
#		-settype bar		-block temp_hms_pactm		-log y	-graph 2 -bxy 1:2 \
#		-settype bar		-block temp_hms_time		-log y	-graph 2 -bxy 1:2 \
#		-settype bar		-block temp_shms_pactm 		-log y	-graph 2 -bxy 1:2 \
#		-settype bar		-block temp_shms_time 		-log y	-graph 2 -bxy 1:2 \
#		-p /home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/Azz_proj_hms_shms.par -noask 
#
#xmgrace \
#		-settype xy   		-block temp_misak_vn_av18	 		-graph 3 -bxy 1:2 \
#		-settype xy   		-block temp_misak_lc_av18			-graph 3 -bxy 1:2 \
#		-settype xy   		-block temp_model_miller_Azz		-graph 3 -bxy 1:2 \
#		-settype xy   		-block temp_model_frankfurt_Azz		-graph 3 -bxy 1:2 \
#		-settype xydy 		-block temp_Azz_stat         		-graph 3 -bxy 1:2:3 \
#		-settype xydy 		-block temp_Azz_tot          		-graph 3 -bxy 1:2:3 \
#		-settype xydxdy		-block temp_hms_azz_tot				-graph 3 -bxy 1:2:3:4 \
#		-settype xydxdy		-block temp_hms_azz_stat			-graph 3 -bxy 1:2:3:4 \
#		-settype xydxdy		-block temp_shms_azz_tot			-graph 3 -bxy 1:2:3:4 \
#		-settype xydxdy		-block temp_shms_azz_stat			-graph 3 -bxy 1:2:3:4 \
#        -settype xy     	-block temp_shms_azz_sys_bar   		-graph 3 -bxy 1:2 \
#		-settype xy   		-block temp_misak_vn_cdbonn	 		-graph 3 -bxy 1:2 \
#		-settype xy   		-block temp_misak_lc_cdbonn			-graph 3 -bxy 1:2 \
#		-p /home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/Azz_proj_hms_shms.par -noask 
#
#xmgrace \
#		-settype xy			-block temp_thmin_hms				-graph 4 -bxy 1:2 \
#		-settype xy			-block temp_thmin_shms				-graph 4 -bxy 1:2 \
#		-settype xycolor	-block temp_hms_atheta				-graph 4 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_atheta				-graph 4 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_theta1				-graph 4 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_theta2				-graph 4 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_theta3				-graph 4 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_theta4				-graph 4 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_theta5				-graph 4 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_theta1				-graph 4 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_theta2				-graph 4 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_theta3				-graph 4 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_theta4				-graph 4 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_theta5				-graph 4 -bxy 1:2:3 \
#		-settype xy			-block temp_hms_ctheta				-graph 4 -bxy 1:2 \
#		-settype xy			-block temp_shms_ctheta				-graph 4 -bxy 1:2 \
#		-p /home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/Azz_proj_hms_shms.par -noask 
#
#xmgrace \
#		-settype xycolor	-block temp_hms_aq2					-graph 5 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_aq2				-graph 5 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_q21					-graph 5 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_q22					-graph 5 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_q23					-graph 5 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_q24					-graph 5 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_q25					-graph 5 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_q21				-graph 5 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_q22				-graph 5 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_q23				-graph 5 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_q24				-graph 5 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_q25				-graph 5 -bxy 1:2:3 \
#		-settype xy			-block temp_hms_cq2					-graph 5 -bxy 1:2 \
#		-settype xy			-block temp_shms_cq2				-graph 5 -bxy 1:2 \
#		-p /home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/Azz_proj_hms_shms.par -noask 
#
#xmgrace \
#		-settype xy			-block temp_hms_e0					-graph 6 -bxy 1:2 \
#		-settype xy			-block temp_epmax_hms				-graph 6 -bxy 1:2 \
#		-settype xy			-block temp_epmax_shms				-graph 6 -bxy 1:2 \
#		-settype xycolor	-block temp_hms_aep					-graph 6 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_aep				-graph 6 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_ep1					-graph 6 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_ep2					-graph 6 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_ep3					-graph 6 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_ep4					-graph 6 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_ep5					-graph 6 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_ep1				-graph 6 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_ep2				-graph 6 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_ep3				-graph 6 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_ep4				-graph 6 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_ep5				-graph 6 -bxy 1:2:3 \
#		-settype xy			-block temp_hms_cep					-graph 6 -bxy 1:2 \
#		-settype xy			-block temp_shms_cep				-graph 6 -bxy 1:2 \
#		-p /home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/Azz_proj_hms_shms.par -noask 
#
#xmgrace \
#		-settype xy			-block temp_wqe						-graph 7 -bxy 1:2 \
#		-settype xy			-block temp_wmin					-graph 7 -bxy 1:2 \
#		-settype xycolor	-block temp_hms_aw					-graph 7 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_aw					-graph 7 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_w1					-graph 7 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_w2					-graph 7 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_w3					-graph 7 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_w4					-graph 7 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_w5					-graph 7 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_w1					-graph 7 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_w2					-graph 7 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_w3					-graph 7 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_w4					-graph 7 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_w5					-graph 7 -bxy 1:2:3 \
#		-settype xy			-block temp_hms_cw					-graph 7 -bxy 1:2 \
#		-settype xy			-block temp_shms_cw					-graph 7 -bxy 1:2 \
#		-p /home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/Azz_proj_hms_shms.par -noask 
#
#xmgrace \
#		-settype xycolor	-block temp_hms_theta_aq			-graph 8 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_theta_aq			-graph 8 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_theta_q1			-graph 8 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_theta_q2			-graph 8 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_theta_q3			-graph 8 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_theta_q4			-graph 8 -bxy 1:2:3 \
#		-settype xycolor	-block temp_hms_theta_q5			-graph 8 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_theta_q1			-graph 8 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_theta_q2			-graph 8 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_theta_q3			-graph 8 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_theta_q4			-graph 8 -bxy 1:2:3 \
#		-settype xycolor	-block temp_shms_theta_q5			-graph 8 -bxy 1:2:3 \
#		-settype xy			-block temp_hms_theta_cq			-graph 8 -bxy 1:2 \
#		-settype xy			-block temp_shms_theta_cq			-graph 8 -bxy 1:2 \
#		-p /home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/Azz_proj_hms_shms.par -noask 
#
#
rm -f temp*
