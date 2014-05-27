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
#  6 = stdev(Azz)
#  7 = x
#echo "0	0" >> temp_azz_av18
awk '$1>0 && $1<2000 {print $1,$2}'  $file0 >> temp_azz_av18
awk '$1>0 && $1<2000 {print $1,$2}'  $file1 >> temp_azz_cdbonn
awk '$1>0 && $1<2000 {print $1,$2}'  $file2 >> temp_azz_fs
awk '$1>0 && $1<2000 {print $1,$2}'  $file3 >> temp_azz_n3lo500
awk '$1>0 && $1<2000 {print $1,$2}'  $file4 >> temp_azz_n3lo600
awk '$1>0 && $1<2000 {print $1,$2}'  $file5 >> temp_azz_nimj1
awk '$1>0 && $1<2000 {print $1,$2}'  $file6 >> temp_azz_nimj2
awk '$1>0 && $1<2000 {print $1,$2}'  $file7 >> temp_azz_nimj3
#awk '{a[NR]=$0} END {for(i=NR;i>0;i--) print a[i]}' $file0 >> temp_rev_azz_av18
#awk '{a[NR]=$0} END {for(i=NR;i>0;i--) print a[i]}' $file1 >> temp_rev_azz_cdbonn
#awk '{a[NR]=$0} END {for(i=NR;i>0;i--) print a[i]}' $file2 >> temp_rev_azz_fs
#awk '{a[NR]=$0} END {for(i=NR;i>0;i--) print a[i]}' $file3 >> temp_rev_azz_n3lo500
#awk '{a[NR]=$0} END {for(i=NR;i>0;i--) print a[i]}' $file4 >> temp_rev_azz_n3lo600
#awk '{a[NR]=$0} END {for(i=NR;i>0;i--) print a[i]}' $file5 >> temp_rev_azz_nimj1
#awk '{a[NR]=$0} END {for(i=NR;i>0;i--) print a[i]}' $file6 >> temp_rev_azz_nimj2
#awk '{a[NR]=$0} END {for(i=NR;i>0;i--) print a[i]}' $file7 >> temp_rev_azz_nimj3
#awk '$1>0 && $1<2000 {print $1,$2-$6}'  temp_rev_azz_av18 >> temp_azz_av18
#awk '$1>0 && $1<2000 {print $1,$2-$6}'  temp_rev_azz_cdbonn >> temp_azz_cdbonn
#awk '$1>0 && $1<2000 {print $1,$2-$6}'  temp_rev_azz_fs >> temp_azz_fs
#awk '$1>0 && $1<2000 {print $1,$2-$6}'  temp_rev_azz_n3lo500 >> temp_azz_n3lo500
#awk '$1>0 && $1<2000 {print $1,$2-$6}'  temp_rev_azz_n3lo600 >> temp_azz_n3lo600
#awk '$1>0 && $1<2000 {print $1,$2-$6}'  temp_rev_azz_nimj1 >> temp_azz_nimj1
#awk '$1>0 && $1<2000 {print $1,$2-$6}'  temp_rev_azz_nimj2 >> temp_azz_nimj2
#awk '$1>0 && $1<2000 {print $1,$2-$6}'  temp_rev_azz_nimj3 >> temp_azz_nimj3

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
	-p ./azz_plot.par -noask
#	-p ./azz_plot_theta.par -noask


file10="./azz_calc/av18_azz_x.dat"
file11="./azz_calc/cdbonn_azz_x.dat"
file12="./azz_calc/fs_azz_x.dat"
file13="./azz_calc/n3lo500_azz_x.dat"
file14="./azz_calc/n3lo600_azz_x.dat"
file15="./azz_calc/nimj1_azz_x.dat"
file16="./azz_calc/nimj2_azz_x.dat"
file17="./azz_calc/nimj3_azz_x.dat"
#  1 = x
#  2 = Azz
#  3 = r(0,k)
#  4 = r(-1,k)
#  5 = stdev(Azz)
#  6 = Azz
awk '$1>0 && $1<2000 {print $1,$2}'  $file10 >> temp_x_azz_av18
awk '$1>0 && $1<2000 {print $1,$2}'  $file11 >> temp_x_azz_cdbonn
awk '$1>0 && $1<2000 {print $1,$2}'  $file12 >> temp_x_azz_fs
awk '$1>0 && $1<2000 {print $1,$2}'  $file13 >> temp_x_azz_n3lo500
awk '$1>0 && $1<2000 {print $1,$2}'  $file14 >> temp_x_azz_n3lo600
awk '$1>0 && $1<2000 {print $1,$2}'  $file15 >> temp_x_azz_nimj1
awk '$1>0 && $1<2000 {print $1,$2}'  $file16 >> temp_x_azz_nimj2
awk '$1>0 && $1<2000 {print $1,$2}'  $file17 >> temp_x_azz_nimj3
#awk '{a[NR]=$0} END {for(i=NR;i>0;i--) print a[i]}' $file10 >> temp_x_rev_azz_av18
#awk '{a[NR]=$0} END {for(i=NR;i>0;i--) print a[i]}' $file11 >> temp_x_rev_azz_cdbonn
#awk '{a[NR]=$0} END {for(i=NR;i>0;i--) print a[i]}' $file12 >> temp_x_rev_azz_fs
#awk '{a[NR]=$0} END {for(i=NR;i>0;i--) print a[i]}' $file13 >> temp_x_rev_azz_n3lo500
#awk '{a[NR]=$0} END {for(i=NR;i>0;i--) print a[i]}' $file14 >> temp_x_rev_azz_n3lo600
#awk '{a[NR]=$0} END {for(i=NR;i>0;i--) print a[i]}' $file15 >> temp_x_rev_azz_nimj1
#awk '{a[NR]=$0} END {for(i=NR;i>0;i--) print a[i]}' $file16 >> temp_x_rev_azz_nimj2
#awk '{a[NR]=$0} END {for(i=NR;i>0;i--) print a[i]}' $file17 >> temp_x_rev_azz_nimj3
#awk '$1>0 && $1<2000 {print $1,$2-$5}'  temp_x_rev_azz_av18 >> temp_x_azz_av18
#awk '$1>0 && $1<2000 {print $1,$2-$5}'  temp_x_rev_azz_cdbonn >> temp_x_azz_cdbonn
#awk '$1>0 && $1<2000 {print $1,$2-$5}'  temp_x_rev_azz_fs >> temp_x_azz_fs
#awk '$1>0 && $1<2000 {print $1,$2-$5}'  temp_x_rev_azz_n3lo500 >> temp_x_azz_n3lo500
#awk '$1>0 && $1<2000 {print $1,$2-$5}'  temp_x_rev_azz_n3lo600 >> temp_x_azz_n3lo600
#awk '$1>0 && $1<2000 {print $1,$2-$5}'  temp_x_rev_azz_nimj1 >> temp_x_azz_nimj1
#awk '$1>0 && $1<2000 {print $1,$2-$5}'  temp_x_rev_azz_nimj2 >> temp_x_azz_nimj2
#awk '$1>0 && $1<2000 {print $1,$2-$5}'  temp_x_rev_azz_nimj3 >> temp_x_azz_nimj3




awk '$1>0 && $1<2000 {print $1,$3}'  $file10 >> temp_x_rt0_av18
awk '$1>0 && $1<2000 {print $1,$3}'  $file11 >> temp_x_rt0_cdbonn
awk '$1>0 && $1<2000 {print $1,$3}'  $file12 >> temp_x_rt0_fs
awk '$1>0 && $1<2000 {print $1,$3}'  $file13 >> temp_x_rt0_n3lo500
awk '$1>0 && $1<2000 {print $1,$3}'  $file14 >> temp_x_rt0_n3lo600
awk '$1>0 && $1<2000 {print $1,$3}'  $file15 >> temp_x_rt0_nimj1
awk '$1>0 && $1<2000 {print $1,$3}'  $file16 >> temp_x_rt0_nimj2
awk '$1>0 && $1<2000 {print $1,$3}'  $file17 >> temp_x_rt0_nimj3

awk '$1>0 && $1<2000 {print $1,$4}'  $file10 >> temp_x_rvp_av18
awk '$1>0 && $1<2000 {print $1,$4}'  $file11 >> temp_x_rvp_cdbonn
awk '$1>0 && $1<2000 {print $1,$4}'  $file12 >> temp_x_rvp_fs
awk '$1>0 && $1<2000 {print $1,$4}'  $file13 >> temp_x_rvp_n3lo500
awk '$1>0 && $1<2000 {print $1,$4}'  $file14 >> temp_x_rvp_n3lo600
awk '$1>0 && $1<2000 {print $1,$4}'  $file15 >> temp_x_rvp_nimj1
awk '$1>0 && $1<2000 {print $1,$4}'  $file16 >> temp_x_rvp_nimj2
awk '$1>0 && $1<2000 {print $1,$4}'  $file17 >> temp_x_rvp_nimj3

awk '$1>0 && $1<2000 {print $1,$5}'  $file10 >> temp_x_rvm_av18
awk '$1>0 && $1<2000 {print $1,$5}'  $file11 >> temp_x_rvm_cdbonn
awk '$1>0 && $1<2000 {print $1,$5}'  $file12 >> temp_x_rvm_fs
awk '$1>0 && $1<2000 {print $1,$5}'  $file13 >> temp_x_rvm_n3lo500
awk '$1>0 && $1<2000 {print $1,$5}'  $file14 >> temp_x_rvm_n3lo600
awk '$1>0 && $1<2000 {print $1,$5}'  $file15 >> temp_x_rvm_nimj1
awk '$1>0 && $1<2000 {print $1,$5}'  $file16 >> temp_x_rvm_nimj2
awk '$1>0 && $1<2000 {print $1,$5}'  $file17 >> temp_x_rvm_nimj3

#gracebat -hdevice PNG -printfile plot_azz.png \
xmgrace\
	-settype xy		-block temp_x_azz_av18			 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_x_azz_cdbonn		 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_x_azz_fs			 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_x_azz_n3lo500		 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_x_azz_n3lo600		 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_x_azz_nimj1			 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_x_azz_nimj2			 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_x_azz_nimj3			 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_x_rt0_av18			 	-graph 1 -bxy 1:2\
	-settype xy		-block temp_x_rt0_cdbonn		 	-graph 1 -bxy 1:2\
	-settype xy		-block temp_x_rt0_fs			 	-graph 1 -bxy 1:2\
	-settype xy		-block temp_x_rt0_n3lo500			-graph 1 -bxy 1:2\
	-settype xy		-block temp_x_rt0_n3lo600			-graph 1 -bxy 1:2\
	-settype xy		-block temp_x_rt0_nimj1			 	-graph 1 -bxy 1:2\
	-settype xy		-block temp_x_rt0_nimj2			 	-graph 1 -bxy 1:2\
	-settype xy		-block temp_x_rt0_nimj3			 	-graph 1 -bxy 1:2\
	-settype xy		-block temp_x_rvp_av18			 	-graph 2 -bxy 1:2\
	-settype xy		-block temp_x_rvp_cdbonn			-graph 2 -bxy 1:2\
	-settype xy		-block temp_x_rvp_fs				-graph 2 -bxy 1:2\
	-settype xy		-block temp_x_rvp_n3lo500			-graph 2 -bxy 1:2\
	-settype xy		-block temp_x_rvp_n3lo600			-graph 2 -bxy 1:2\
	-settype xy		-block temp_x_rvp_nimj1			 	-graph 2 -bxy 1:2\
	-settype xy		-block temp_x_rvp_nimj2			 	-graph 2 -bxy 1:2\
	-settype xy		-block temp_x_rvp_nimj3			 	-graph 2 -bxy 1:2\
	-settype xy		-block temp_x_rvm_av18			 	-graph 3 -bxy 1:2\
	-settype xy		-block temp_x_rvm_cdbonn			-graph 3 -bxy 1:2\
	-settype xy		-block temp_x_rvm_fs				-graph 3 -bxy 1:2\
	-settype xy		-block temp_x_rvm_n3lo500			-graph 3 -bxy 1:2\
	-settype xy		-block temp_x_rvm_n3lo600			-graph 3 -bxy 1:2\
	-settype xy		-block temp_x_rvm_nimj1			 	-graph 3 -bxy 1:2\
	-settype xy		-block temp_x_rvm_nimj2			 	-graph 3 -bxy 1:2\
	-settype xy		-block temp_x_rvm_nimj3			 	-graph 3 -bxy 1:2\
	-p ./azz_plot_x.par -noask




#display cs_check.png

rm temp*

