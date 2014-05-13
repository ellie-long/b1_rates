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
awk '$1>0 && $1<2000 {print $1,$2}'  $file0 >> temp_av18
awk '$1>0 && $1<2000 {print $1,$2}'  $file1 >> temp_cdbonn
awk '$1>0 && $1<2000 {print $1,$2}'  $file2 >> temp_fs
awk '$1>0 && $1<2000 {print $1,$2}'  $file3 >> temp_n3lo500
awk '$1>0 && $1<2000 {print $1,$2}'  $file4 >> temp_n3lo600
awk '$1>0 && $1<2000 {print $1,$2}'  $file5 >> temp_nimj1
awk '$1>0 && $1<2000 {print $1,$2}'  $file6 >> temp_nimj2
awk '$1>0 && $1<2000 {print $1,$2}'  $file7 >> temp_nimj3


#gracebat -hdevice PNG -printfile cs_check.png \
xmgrace\
	-settype xy		-block temp_av18				 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_cdbonn				 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_fs					 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_n3lo500				 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_n3lo600				 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_nimj1				 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_nimj2				 	-graph 0 -bxy 1:2\
	-settype xy		-block temp_nimj3				 	-graph 0 -bxy 1:2\
	-p ./azz_plot.par -noask


#display cs_check.png

rm temp*

