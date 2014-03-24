#!/bin/sh

# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#
# cs_check.sh
#
# This script checks the cross-section outputs of ptrates.f, which
# go into the dilution factor (fdil).
#
# Elena Long
# ellie@jlab.org
# 9/27/2013
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

file0="/home/ellie/physics/b1/b1_rates/from_patricia/rates/output/rebinned-x.out"
#  1 = Spectrometer # 
#  2 = <x>
#  3 = xdx
#  4 = dAzz
#  5 = db1d
#  6 = w_ave
#  7 = qq
#  8 = Ntotal
#  9 = sys_Azz
# 10 = sys_b1s
# 11 = Azz
# 12 = b1d
# 13 = sig_d_u
# 14 = sig_n
# 15 = sig_he
# 16 = f_dil
# 17 = sig_li
#echo "0	0" > temp_sigma_d_pol
#awk '$12!="NaN" {print $2,$13}' $file0 > temp_sigma_d_unpol
#awk '$12!="NaN" {print $2,$14}' $file0 > temp_sigma_n
#awk '$12!="NaN" {print $2,$15}' $file0 > temp_sigma_he
#awk '$12!="NaN" {print $2,$16}' $file0 > temp_fdil


file1="/home/ellie/physics/b1/b1_rates/from_patricia/rates/output/cs-check.out"
# 1  = x
# 2  = Q^2
# 3  = Theta_e'
# 4  = Beam Energy
# 5  = E'
# 6  = nu
# 7  = W^2
# 8  = Polarized 2D cross-section
# 9  = Unpolarized 2D cross-section
# 10 = Unpolarized 14N cross-section
# 11 = Unpolarized 4He cross-section
# 12 = Dilution Factor (fdil)
# 13 = Unpolarized 12C cross-section
# 14 = 14N/2H SRC Ratio
# 15 = 4He/2H SRC Ratio
# 16 = 12C/2H SRC Ratio
# 17 = Unpolarized 6Li cross-section
# 18 = Lumi*Sigma for Polarized 2D
# 19 = Lumi*Sigma for Unpolarized 2D
# 20 = Lumi*Sigma for Unpolarized 4He (liquid)
# 21 = Lumi*Sigma for Unpolarized 14N
# 22 = Lumi*Sigma for Unpolarized 12C
# 23 = Lumi*Sigma for Unpolarized 6Li
# 24 = Lumi*Sigma for Unpolarized 4He (in lithium)
awk '$12!="NaN" {print $1,$8}'  $file1 >> temp_sigma_d_pol
awk '$12!="NaN" {print $1,$9}'  $file1 >> temp_sigma_d_unpol
#awk '$12!="NaN" {print $1,$13}'  $file1 >> temp_sigma_d_unpol
awk '$12!="NaN" {print $1,$10}' $file1 >> temp_sigma_n
awk '$12!="NaN" {print $1,$11}' $file1 >> temp_sigma_he
awk '$12!="NaN" {print $1,$12}' $file1 >> temp_fdil
awk '$12!="NaN" {print $1,$13}' $file1 >> temp_sigma_c
awk '$12!="NaN" {print $1,$17}' $file1 >> temp_sigma_li
awk '$12!="NaN" {print $1,$11+$9}' $file1 >> temp_sigma_li_hed

echo '-1 1' >> temp_lumsig_d_pol
echo '-1 1' >> temp_lumsig_d_unpol
echo '-1 1' >> temp_lumsig_he
echo '-1 1' >> temp_lumsig_n
echo '-1 1' >> temp_lumsig_c
echo '-1 1' >> temp_lumsig_li
echo '-1 1' >> temp_lumsig_heli

awk '$12!="NaN" && $18>0 {print $1,$18}'  $file1 >> temp_lumsig_d_pol
awk '$12!="NaN" && $19>0 {print $1,$19}'  $file1 >> temp_lumsig_d_unpol
awk '$12!="NaN" && $20>0 {print $1,$20}'  $file1 >> temp_lumsig_he
awk '$12!="NaN" && $21>0 {print $1,$21}'  $file1 >> temp_lumsig_n
awk '$12!="NaN" && $22>0 {print $1,$22}'  $file1 >> temp_lumsig_c
awk '$12!="NaN" && $23>0 {print $1,$23}'  $file1 >> temp_lumsig_li
awk '$12!="NaN" && $24>0 {print $1,$24}'  $file1 >> temp_lumsig_heli
#awk '$12!="NaN" && $24>0 {print $1,$24+($19/2)}'  $file1 >> temp_lumsig_heli

awk '$12!="NaN" {print $1,$14}' $file1 >> temp_src_n
awk '$12!="NaN" {print $1,$15}' $file1 >> temp_src_he
awk '$12!="NaN" {print $1,$16}' $file1 >> temp_src_c

awk '$12!="NaN" {print $6,$8}'  $file1 >> temp_sigma_d_pol_nu
awk '$12!="NaN" {print $6,$9}'  $file1 >> temp_sigma_d_unpol_nu
#awk '$12!="NaN" {print $6,$13}'  $file1 >> temp_sigma_d_unpol_nu
awk '$12!="NaN" {print $6,$10}' $file1 >> temp_sigma_n_nu
awk '$12!="NaN" {print $6,$11}' $file1 >> temp_sigma_he_nu
awk '$12!="NaN" {print $6,$17}' $file1 >> temp_sigma_he_nu



file2="/home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/world_qe_data/2H.dat"
file3="/home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/world_qe_data/4He.dat"
file4="/home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/world_qe_data/carb_18deg.dat"
file5="/home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/world_qe_data/deut_18deg.dat"
# 1 = Z
# 2 = A
# 3 = Energy (GeV)
# 4 = Angle (degrees)
# 5 = nu (GeV)
# 6 = Cross section (nb/GeV*str)
# 7 = Cross section uncertainty
# 8 = Citation
#awk '$3==6.519 {print $5,$6*1E-9,$7*1E-9}'  $file2 >> temp_sigma_d_exp_nu
#awk '$3==6.519 {print 4*$3*($3-$5)*(sin(($4/2)*(3.14159/180))^2)/(2*0.938*$5),$6*1E-9,$7*1E-9}' $file2 >> temp_sigma_d_exp_x
#awk '$3==11.671 {print $5,$6*1E-9,$7*1E-9}' $file2 >> temp_sigma_d_exp_nu
awk '$3==11.671 {print 4*$3*($3-$5)*(sin(($4/2)*(3.14159/180))^2)/(2*0.938*$5),$6*1E-9,$7*1E-9}' $file2 >> temp_sigma_d_exp_x
#awk '{print $1,$2*1E-6,$3*1E-6}'           $file4 >> temp_sigma_d_exp_nu
#awk '{print 4*5.766*(5.766-$1)*(sin((18.0/2)*(3.14159/180))^2)/(2*0.938*$1),$2*1E-6,$3*1E-6}' $file4 >> temp_sigma_d_exp_x
#awk '{print $1,$2*1E-6,$3*1E-6}'           $file5 >> temp_sigma_d_exp_nu
#awk '{print 4*5.766*(5.766-$1)*(sin((18.0/2)*(3.14159/180))^2)/(2*0.938*$1),$2*1E-6,$3*1E-6}' $file5 >> temp_sigma_d_exp_x


#file6="/home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/world_qe_data/misak_deut_6GeV.dat"
#awk '$2>4 && $2<11.0 {print 6.519-$2,$9*1E-6}'    $file6 >> temp_misak_d_nu
#awk '$2>4 && $2<11.0 {print $3,$9*1E-6}'          $file6 >> temp_misak_d_x
#awk '$2>4 && $2<11.0 {print 6.519-$2,$6*1E-6}'    $file6 >> temp_misak_n_nu
#awk '$2>4 && $2<11.0 {print $3,$6*1E-6}'          $file6 >> temp_misak_n_x
#awk '$2>4 && $2<11.0 {print $3,(3*$9/($6+3*$9))}' $file6 >> temp_misak_fdil

file7="/home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/world_qe_data/misak_deut_11GeV.dat"
awk '$2>4 && $2<11.0 {print 11.671-$2,$9*1E-6}'   $file7 >> temp_misak_d_nu
awk '$2>4 && $2<11.0 {print $3,$9*1E-6}'          $file7 >> temp_misak_d_x
awk '$2>4 && $2<11.0 {print 11.671-$2,$6*1E-6}'   $file7 >> temp_misak_n_nu
awk '$2>4 && $2<11.0 {print $3,$6*1E-6}'          $file7 >> temp_misak_n_x
awk '$2>4 && $2<11.0 {print $3,(3*$9/($6+3*$9))}' $file7 >> temp_misak_fdil

#file8="/home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/world_qe_data/misak_hms_66GeV_1245deg_580GeV.dat"
#awk '$2>4 && $2<11.0 {print 6.6-$2,$9*1E-6}'      $file8 >> temp_misak_d_nu
#awk '$2>4 && $2<11.0 {print $3,$9*1E-6}'          $file8 >> temp_misak_d_x
#awk '$2>4 && $2<11.0 {print 6.6-$2,$6*1E-6}'      $file8 >> temp_misak_n_nu
#awk '$2>4 && $2<11.0 {print $3,$6*1E-6}'          $file8 >> temp_misak_n_x
#awk '$2>4 && $2<11.0 {print $3,(3*$9/($6+3*$9))}' $file8 >> temp_misak_fdil

#file9="/home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/world_qe_data/misak_shms_66_GeV_0951deg_607GeV.dat"
#awk '$2>4 && $2<11.0 {print 6.6-$2,$9*1E-6}'      $file9 >> temp_misak_d_nu
#awk '$2>4 && $2<11.0 {print $3,$9*1E-6}'          $file9 >> temp_misak_d_x
#awk '$2>4 && $2<11.0 {print 6.6-$2,$6*1E-6}'      $file9 >> temp_misak_n_nu
#awk '$2>4 && $2<11.0 {print $3,$6*1E-6}'          $file9 >> temp_misak_n_x
#awk '$2>4 && $2<11.0 {print $3,(3*$9/($6+3*$9))}' $file9 >> temp_misak_fdil

#file10="/home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/world_qe_data/e02019_18deg_lc.out"
#awk '$2>2 && $2<11.0 {print 5.766-$2,$9*1E-6}'    $file10 >> temp_misak_d_nu
#awk '$2>2 && $2<11.0 {print 5.766-$2,$6*1E-6}'    $file10 >> temp_misak_d_nu
#awk '$2>2 && $2<11.0 {print $3,$9*1E-6}'          $file10 >> temp_misak_d_x
#awk '$2>2 && $2<11.0 {print 5.766-$2,$6*1E-6}'    $file10 >> temp_misak_n_nu
#awk '$2>2 && $2<11.0 {print $3,$6*1E-6}'          $file10 >> temp_misak_n_x
#awk '$2>2 && $2<11.0 {print $3,(3*$9/($6+3*$9))}' $file10 >> temp_misak_fdil


#gracebat -hdevice PNG -printfile cs_check.png \
#xmgrace\
#	-settype xy		-block temp_sigma_d_pol			-log y 	-graph 0 -bxy 1:2\
#	-settype xy		-block temp_sigma_d_unpol		-log y 	-graph 0 -bxy 1:2\
#	-settype xy		-block temp_sigma_n				-log y	-graph 0 -bxy 1:2\
#	-settype xy		-block temp_sigma_he			-log y	-graph 0 -bxy 1:2\
#	-settype xy		-block temp_misak_d_x			-log y	-graph 0 -bxy 1:2\
#	-settype xy		-block temp_misak_n_x			-log y	-graph 0 -bxy 1:2\
#	-settype xydy	-block temp_sigma_d_exp_x		-log y	-graph 0 -bxy 1:2:3\
#	-settype xy		-block temp_src_n						-graph 1 -bxy 1:2\
#	-settype xy		-block temp_src_he						-graph 1 -bxy 1:2\
#	-settype xy		-block temp_src_c						-graph 1 -bxy 1:2\
#	-p /home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/cs_check_src.par -noask

#gracebat -hdevice PNG -printfile cs_check.png \
xmgrace\
	-settype xy		-block temp_sigma_d_pol				 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_sigma_d_unpol			 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_sigma_n						-graph 0 -bxy 1:2\
	-settype xy		-block temp_sigma_he					-graph 0 -bxy 1:2\
	-settype xy		-block temp_sigma_li_hed				-graph 0 -bxy 1:2\
	-settype xy		-block temp_sigma_li					-graph 0 -bxy 1:2\
	-settype xy		-block temp_misak_d_x					-graph 0 -bxy 1:2\
	-settype xy		-block temp_misak_n_x					-graph 0 -bxy 1:2\
	-settype xydy	-block temp_sigma_d_exp_x				-graph 0 -bxy 1:2:3\
	-settype xy		-block temp_fdil						-graph 1 -bxy 1:2\
	-settype xy		-block temp_misak_fdil					-graph 1 -bxy 1:2\
	-settype xy		-block temp_lumsig_d_pol			 	-graph 2 -bxy 1:2\
	-settype xy		-block temp_lumsig_d_unpol			 	-graph 2 -bxy 1:2\
	-settype xy		-block temp_lumsig_n					-graph 2 -bxy 1:2\
	-settype xy		-block temp_lumsig_he					-graph 2 -bxy 1:2\
	-settype xy		-block temp_lumsig_heli					-graph 2 -bxy 1:2\
	-settype xy		-block temp_lumsig_li					-graph 2 -bxy 1:2\
	-p /home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/cs_check.par -noask

#xmgrace\
#	-settype xy		-block temp_sigma_d_unpol_nu	-log y 	-graph 0 -bxy 1:2\
#	-settype xy		-block temp_misak_d_nu			-log y 	-graph 0 -bxy 1:2\
#	-settype xydy	-block temp_sigma_d_exp_nu		-log y	-graph 0 -bxy 1:2:3\
#	-settype xy		-block temp_sigma_d_unpol_nu	-log y 	-graph 1 -bxy 1:2\
#	-settype xy		-block temp_misak_d_nu			-log y 	-graph 1 -bxy 1:2\
#	-settype xydy	-block temp_sigma_d_exp_nu		-log y	-graph 1 -bxy 1:2:3\
#	-p /home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/cs_check_nu.par -noask

#display cs_check.png

rm temp*

