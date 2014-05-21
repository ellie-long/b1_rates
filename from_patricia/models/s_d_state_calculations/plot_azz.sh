#!/bin/sh

# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#
# plot_azz.sh
#
# This script plots the calculated Azz vs x or k
# 
#
# Elena Long
# ellie@jlab.org
# 5/13/2014
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

python calc_azz.py

# Bonn Potential
file0="./azz_calc/av18_azz.dat"
file1="./azz_calc/cdbonn_azz.dat"
file2="./azz_calc/fs_azz.dat"
file3="./azz_calc/n3lo500_azz.dat"
file4="./azz_calc/n3lo600_azz.dat"
file5="./azz_calc/nimj1_azz.dat"
file6="./azz_calc/nimj2_azz.dat"
file7="./azz_calc/nimj3_azz.dat"
#  1 = momentum (k)
#  2 = Azz
#  3 = r(0,k)
#  4 = r(+1,k)
#  5 = r(-1,k)
awk '$1>0 && $1<2000 {print $1,$2}'  $file0 >> temp_azz_av18
awk '$1>0 && $1<2000 {print $1,$2}'  $file1 >> temp_azz_cdbonn
awk '$1>0 && $1<2000 {print $1,$2}'  $file2 >> temp_azz_fs
awk '$1>0 && $1<2000 {print $1,$2}'  $file3 >> temp_azz_n3lo500
awk '$1>0 && $1<2000 {print $1,$2}'  $file4 >> temp_azz_n3lo600
awk '$1>0 && $1<2000 {print $1,$2}'  $file5 >> temp_azz_nimj1
awk '$1>0 && $1<2000 {print $1,$2}'  $file6 >> temp_azz_nimj2
awk '$1>0 && $1<2000 {print $1,$2}'  $file7 >> temp_azz_nimj3

awk '$1>0 && $1<2000 {print $1,$3}'  $file0 >> temp_rt0_av18
awk '$1>0 && $1<2000 {print $1,$3}'  $file1 >> temp_rt0_cdbonn
awk '$1>0 && $1<2000 {print $1,$3}'  $file2 >> temp_rt0_fs
awk '$1>0 && $1<2000 {print $1,$3}'  $file3 >> temp_rt0_n3lo500
awk '$1>0 && $1<2000 {print $1,$3}'  $file4 >> temp_rt0_n3lo600
awk '$1>0 && $1<2000 {print $1,$3}'  $file5 >> temp_rt0_nimj1
awk '$1>0 && $1<2000 {print $1,$3}'  $file6 >> temp_rt0_nimj2
awk '$1>0 && $1<2000 {print $1,$3}'  $file7 >> temp_rt0_nimj3

awk '$1>0 && $1<2000 {print $1,$4}'  $file0 >> temp_rvp_av18
awk '$1>0 && $1<2000 {print $1,$4}'  $file1 >> temp_rvp_cdbonn
awk '$1>0 && $1<2000 {print $1,$4}'  $file2 >> temp_rvp_fs
awk '$1>0 && $1<2000 {print $1,$4}'  $file3 >> temp_rvp_n3lo500
awk '$1>0 && $1<2000 {print $1,$4}'  $file4 >> temp_rvp_n3lo600
awk '$1>0 && $1<2000 {print $1,$4}'  $file5 >> temp_rvp_nimj1
awk '$1>0 && $1<2000 {print $1,$4}'  $file6 >> temp_rvp_nimj2
awk '$1>0 && $1<2000 {print $1,$4}'  $file7 >> temp_rvp_nimj3

awk '$1>0 && $1<2000 {print $1,$5}'  $file0 >> temp_rvm_av18
awk '$1>0 && $1<2000 {print $1,$5}'  $file1 >> temp_rvm_cdbonn
awk '$1>0 && $1<2000 {print $1,$5}'  $file2 >> temp_rvm_fs
awk '$1>0 && $1<2000 {print $1,$5}'  $file3 >> temp_rvm_n3lo500
awk '$1>0 && $1<2000 {print $1,$5}'  $file4 >> temp_rvm_n3lo600
awk '$1>0 && $1<2000 {print $1,$5}'  $file5 >> temp_rvm_nimj1
awk '$1>0 && $1<2000 {print $1,$5}'  $file6 >> temp_rvm_nimj2
awk '$1>0 && $1<2000 {print $1,$5}'  $file7 >> temp_rvm_nimj3

#gracebat -hdevice PNG -printfile plot_azz.png \
xmgrace\
	-settype xy		-block temp_azz_av18			 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_azz_cdbonn			 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_azz_fs				 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_azz_n3lo500			 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_azz_n3lo600			 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_azz_nimj1			 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_azz_nimj2			 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_azz_nimj3			 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_rt0_av18			 	-graph 1 -bxy 1:2\
	-settype xy		-block temp_rt0_cdbonn			 	-graph 1 -bxy 1:2\
	-settype xy		-block temp_rt0_fs				 	-graph 1 -bxy 1:2\
	-settype xy		-block temp_rt0_n3lo500			 	-graph 1 -bxy 1:2\
	-settype xy		-block temp_rt0_n3lo600			 	-graph 1 -bxy 1:2\
	-settype xy		-block temp_rt0_nimj1			 	-graph 1 -bxy 1:2\
	-settype xy		-block temp_rt0_nimj2			 	-graph 1 -bxy 1:2\
	-settype xy		-block temp_rt0_nimj3			 	-graph 1 -bxy 1:2\
	-settype xy		-block temp_rvp_av18			 	-graph 2 -bxy 1:2\
	-settype xy		-block temp_rvp_cdbonn			 	-graph 2 -bxy 1:2\
	-settype xy		-block temp_rvp_fs				 	-graph 2 -bxy 1:2\
	-settype xy		-block temp_rvp_n3lo500			 	-graph 2 -bxy 1:2\
	-settype xy		-block temp_rvp_n3lo600			 	-graph 2 -bxy 1:2\
	-settype xy		-block temp_rvp_nimj1			 	-graph 2 -bxy 1:2\
	-settype xy		-block temp_rvp_nimj2			 	-graph 2 -bxy 1:2\
	-settype xy		-block temp_rvp_nimj3			 	-graph 2 -bxy 1:2\
	-settype xy		-block temp_rvm_av18			 	-graph 3 -bxy 1:2\
	-settype xy		-block temp_rvm_cdbonn			 	-graph 3 -bxy 1:2\
	-settype xy		-block temp_rvm_fs				 	-graph 3 -bxy 1:2\
	-settype xy		-block temp_rvm_n3lo500			 	-graph 3 -bxy 1:2\
	-settype xy		-block temp_rvm_n3lo600			 	-graph 3 -bxy 1:2\
	-settype xy		-block temp_rvm_nimj1			 	-graph 3 -bxy 1:2\
	-settype xy		-block temp_rvm_nimj2			 	-graph 3 -bxy 1:2\
	-settype xy		-block temp_rvm_nimj3			 	-graph 3 -bxy 1:2\
	-p ./azz_plot_theta.par -noask
#	-p ./azz_plot.par -noask


#display cs_check.png

rm temp*

