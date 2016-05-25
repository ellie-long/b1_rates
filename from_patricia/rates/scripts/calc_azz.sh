



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

rm -f temp*

#echo "0	0" > temp_H1-LC-AV18
#echo "0	0" > temp_H1-LC-CDBonn
#echo "0	0" > temp_H1-VN-AV18
#echo "0	0" > temp_H1-VN-CDBonn
#echo "0	0" > temp_H1-PW-AV18
#echo "0	0" > temp_H1-PW-CDBonn
#echo "0	0" > temp_H1-PW-FSIOn-AV18
#echo "0	0" > temp_H1-PW-FSIOn-CDBonn
#echo "0	0" > temp_H1-PW-FSIOff-AV18
#echo "0	0" > temp_H1-PW-FSIOff-CDBonn
#echo "0	0" > temp_H1-AV18-Norm
#echo "0	0" > temp_H1-Bonn-Norm
#echo "0	0" > temp_H1-AV18-Norm-MEC
#echo "0	0" > temp_H1-Bonn-Norm-MEC
#echo "0	0" > temp_H1-AV18-Norm-MEC-IC
#echo "0	0" > temp_H1-Bonn-Norm-MEC-IC
#echo "0	0" > temp_H1-AV18-Norm-MEC-IC-Rel
#echo "0	0" > temp_H1-Bonn-Norm-MEC-IC-Rel
#echo "0	0" > temp_H1-AV18-Norm-Rel
#echo "0	0" > temp_H1-Bonn-Norm-Rel
#echo "0	0" > temp_H1-AV18-PWBA-NR
#echo "0	0" > temp_H1-Bonn-PWBA-NR
#echo "0	0" > temp_H1-AV18-PWBA-RC
#echo "0	0" > temp_H1-Bonn-PWBA-RC

#echo "0	0" > temp_H2-LC-AV18
#echo "0	0" > temp_H2-LC-CDBonn
#echo "0	0" > temp_H2-VN-AV18
#echo "0	0" > temp_H2-VN-CDBonn
echo "0	0" > temp_H2-PW-AV18
echo "0	0" > temp_H2-PW-CDBonn
echo "0	0" > temp_H2-PW-FSIOn-AV18
echo "0	0" > temp_H2-PW-FSIOn-CDBonn
echo "0	0" > temp_H2-PW-FSIOff-AV18
echo "0	0" > temp_H2-PW-FSIOff-CDBonn
#echo "0	0" > temp_H2-AV18-Norm
#echo "0	0" > temp_H2-Bonn-Norm
#echo "0	0" > temp_H2-AV18-Norm-MEC
#echo "0	0" > temp_H2-Bonn-Norm-MEC
#echo "0	0" > temp_H2-AV18-Norm-MEC-IC
#echo "0	0" > temp_H2-Bonn-Norm-MEC-IC
#echo "0	0" > temp_H2-AV18-Norm-MEC-IC-Rel
#echo "0	0" > temp_H2-Bonn-Norm-MEC-IC-Rel
#echo "0	0" > temp_H2-AV18-Norm-Rel
#echo "0	0" > temp_H2-Bonn-Norm-Rel
#echo "0	0" > temp_H2-AV18-PWBA-NR
#echo "0	0" > temp_H2-Bonn-PWBA-NR
#echo "0	0" > temp_H2-AV18-PWBA-RC
#echo "0	0" > temp_H2-Bonn-PWBA-RC

echo "0	0" > temp_H3-LC-AV18
echo "0	0" > temp_H3-LC-CDBonn
echo "0	0" > temp_H3-VN-AV18
echo "0	0" > temp_H3-VN-CDBonn
echo "0	0" > temp_H3-PW-AV18
echo "0	0" > temp_H3-PW-CDBonn
echo "0	0" > temp_H3-PW-FSIOn-AV18
echo "0	0" > temp_H3-PW-FSIOn-CDBonn
echo "0	0" > temp_H3-PW-FSIOff-AV18
echo "0	0" > temp_H3-PW-FSIOff-CDBonn
#echo "0	0" > temp_H3-AV18-Norm
#echo "0	0" > temp_H3-Bonn-Norm
#echo "0	0" > temp_H3-AV18-Norm-MEC
#echo "0	0" > temp_H3-Bonn-Norm-MEC
#echo "0	0" > temp_H3-AV18-Norm-MEC-IC
#echo "0	0" > temp_H3-Bonn-Norm-MEC-IC
#echo "0	0" > temp_H3-AV18-Norm-MEC-IC-Rel
#echo "0	0" > temp_H3-Bonn-Norm-MEC-IC-Rel
#echo "0	0" > temp_H3-AV18-Norm-Rel
#echo "0	0" > temp_H3-Bonn-Norm-Rel
#echo "0	0" > temp_H3-AV18-PWBA-NR
#echo "0	0" > temp_H3-Bonn-PWBA-NR
#echo "0	0" > temp_H3-AV18-PWBA-RC
#echo "0	0" > temp_H3-Bonn-PWBA-RC

#echo "0	0" > temp_S1-LC-AV18
#echo "0	0" > temp_S1-LC-CDBonn
#echo "0	0" > temp_S1-VN-AV18
#echo "0	0" > temp_S1-VN-CDBonn
#echo "0	0" > temp_S1-PW-AV18
#echo "0	0" > temp_S1-PW-CDBonn
#echo "0	0" > temp_S1-PW-FSIOn-AV18
#echo "0	0" > temp_S1-PW-FSIOn-CDBonn
#echo "0	0" > temp_S1-PW-FSIOff-AV18
#echo "0	0" > temp_S1-PW-FSIOff-CDBonn
#echo "0	0" > temp_S1-AV18-Norm
#echo "0	0" > temp_S1-Bonn-Norm
#echo "0	0" > temp_S1-AV18-Norm-MEC
#echo "0	0" > temp_S1-Bonn-Norm-MEC
#echo "0	0" > temp_S1-AV18-Norm-MEC-IC
#echo "0	0" > temp_S1-Bonn-Norm-MEC-IC
#echo "0	0" > temp_S1-AV18-Norm-MEC-IC-Rel
#echo "0	0" > temp_S1-Bonn-Norm-MEC-IC-Rel
#echo "0	0" > temp_S1-AV18-Norm-Rel
#echo "0	0" > temp_S1-Bonn-Norm-Rel
#echo "0	0" > temp_S1-AV18-PWBA-NR
#echo "0	0" > temp_S1-Bonn-PWBA-NR
#echo "0	0" > temp_S1-AV18-PWBA-RC
#echo "0	0" > temp_S1-Bonn-PWBA-RC

echo "0	0" > temp_S2-LC-AV18
echo "0	0" > temp_S2-LC-CDBonn
echo "0	0" > temp_S2-VN-AV18
echo "0	0" > temp_S2-VN-CDBonn
echo "0	0" > temp_S2-PW-AV18
echo "0	0" > temp_S2-PW-CDBonn
echo "0	0" > temp_S2-PW-FSIOn-AV18
echo "0	0" > temp_S2-PW-FSIOn-CDBonn
echo "0	0" > temp_S2-PW-FSIOff-AV18
echo "0	0" > temp_S2-PW-FSIOff-CDBonn
#echo "0	0" > temp_S2-AV18-Norm
#echo "0	0" > temp_S2-Bonn-Norm
#echo "0	0" > temp_S2-AV18-Norm-MEC
#echo "0	0" > temp_S2-Bonn-Norm-MEC
#echo "0	0" > temp_S2-AV18-Norm-MEC-IC
#echo "0	0" > temp_S2-Bonn-Norm-MEC-IC
#echo "0	0" > temp_S2-AV18-Norm-MEC-IC-Rel
#echo "0	0" > temp_S2-Bonn-Norm-MEC-IC-Rel
#echo "0	0" > temp_S2-AV18-Norm-Rel
#echo "0	0" > temp_S2-Bonn-Norm-Rel
#echo "0	0" > temp_S2-AV18-PWBA-NR
#echo "0	0" > temp_S2-Bonn-PWBA-NR
#echo "0	0" > temp_S2-AV18-PWBA-RC
#echo "0	0" > temp_S2-Bonn-PWBA-RC

echo "0	0" > temp_S3-LC-AV18
echo "0	0" > temp_S3-LC-CDBonn
echo "0	0" > temp_S3-VN-AV18
echo "0	0" > temp_S3-VN-CDBonn
echo "0	0" > temp_S3-PW-AV18
echo "0	0" > temp_S3-PW-CDBonn
echo "0	0" > temp_S3-PW-FSIOn-AV18
echo "0	0" > temp_S3-PW-FSIOn-CDBonn
echo "0	0" > temp_S3-PW-FSIOff-AV18
echo "0	0" > temp_S3-PW-FSIOff-CDBonn
#echo "0	0" > temp_S3-AV18-Norm
#echo "0	0" > temp_S3-Bonn-Norm
#echo "0	0" > temp_S3-AV18-Norm-MEC
#echo "0	0" > temp_S3-Bonn-Norm-MEC
#echo "0	0" > temp_S3-AV18-Norm-MEC-IC
#echo "0	0" > temp_S3-Bonn-Norm-MEC-IC
#echo "0	0" > temp_S3-AV18-Norm-MEC-IC-Rel
#echo "0	0" > temp_S3-Bonn-Norm-MEC-IC-Rel
#echo "0	0" > temp_S3-AV18-Norm-Rel
#echo "0	0" > temp_S3-Bonn-Norm-Rel
#echo "0	0" > temp_S3-AV18-PWBA-NR
#echo "0	0" > temp_S3-Bonn-PWBA-NR
#echo "0	0" > temp_S3-AV18-PWBA-RC
#echo "0	0" > temp_S3-Bonn-PWBA-RC

file1="/home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/all_Azz_calculations.dat"
file0="/home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/all_Azz_calculations_with_cs.dat"
awk '$1=="H1" && $2=="AV18-Norm" {print $3,$4}' $file0 >> temp_H1-AV18-Norm
awk '$1=="H2" && $2=="AV18-Norm" {print $3,$4}' $file0 >> temp_H2-AV18-Norm
awk '$1=="H3" && $2=="AV18-Norm" {print $3,$4}' $file0 >> temp_H3-AV18-Norm
awk '$1=="S1" && $2=="AV18-Norm" {print $3,$4}' $file0 >> temp_S1-AV18-Norm
awk '$1=="S2" && $2=="AV18-Norm" {print $3,$4}' $file0 >> temp_S2-AV18-Norm
awk '$1=="S3" && $2=="AV18-Norm" {print $3,$4}' $file0 >> temp_S3-AV18-Norm
awk '$1=="H1" && $2=="AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_H1-AV18-Norm-MEC
awk '$1=="H2" && $2=="AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_H2-AV18-Norm-MEC
awk '$1=="H3" && $2=="AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_H3-AV18-Norm-MEC
awk '$1=="S1" && $2=="AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_S1-AV18-Norm-MEC
awk '$1=="S2" && $2=="AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_S2-AV18-Norm-MEC
awk '$1=="S3" && $2=="AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_S3-AV18-Norm-MEC
awk '$1=="H1" && $2=="AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H1-AV18-Norm-MEC-IC
awk '$1=="H2" && $2=="AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H2-AV18-Norm-MEC-IC
awk '$1=="H3" && $2=="AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H3-AV18-Norm-MEC-IC
awk '$1=="S1" && $2=="AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S1-AV18-Norm-MEC-IC
awk '$1=="S2" && $2=="AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S2-AV18-Norm-MEC-IC
awk '$1=="S3" && $2=="AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S3-AV18-Norm-MEC-IC
awk '$1=="H1" && $2=="AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H1-AV18-Norm-MEC-IC-Rel
awk '$1=="H2" && $2=="AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H2-AV18-Norm-MEC-IC-Rel
awk '$1=="H3" && $2=="AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H3-AV18-Norm-MEC-IC-Rel
awk '$1=="S1" && $2=="AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S1-AV18-Norm-MEC-IC-Rel
awk '$1=="S2" && $2=="AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S2-AV18-Norm-MEC-IC-Rel
awk '$1=="S3" && $2=="AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S3-AV18-Norm-MEC-IC-Rel
awk '$1=="H1" && $2=="AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_H1-AV18-Norm-Rel
awk '$1=="H2" && $2=="AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_H2-AV18-Norm-Rel
awk '$1=="H3" && $2=="AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_H3-AV18-Norm-Rel
awk '$1=="S1" && $2=="AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_S1-AV18-Norm-Rel
awk '$1=="S2" && $2=="AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_S2-AV18-Norm-Rel
awk '$1=="S3" && $2=="AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_S3-AV18-Norm-Rel
awk '$1=="H1" && $2=="AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_H1-AV18-PWBA-NR
awk '$1=="H2" && $2=="AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_H2-AV18-PWBA-NR
awk '$1=="H3" && $2=="AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_H3-AV18-PWBA-NR
awk '$1=="S1" && $2=="AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_S1-AV18-PWBA-NR
awk '$1=="S2" && $2=="AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_S2-AV18-PWBA-NR
awk '$1=="S3" && $2=="AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_S3-AV18-PWBA-NR
awk '$1=="H1" && $2=="AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_H1-AV18-PWBA-RC
awk '$1=="H2" && $2=="AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_H2-AV18-PWBA-RC
awk '$1=="H3" && $2=="AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_H3-AV18-PWBA-RC
awk '$1=="S1" && $2=="AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_S1-AV18-PWBA-RC
awk '$1=="S2" && $2=="AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_S2-AV18-PWBA-RC
awk '$1=="S3" && $2=="AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_S3-AV18-PWBA-RC
awk '$1=="H1" && $2=="Bonn-Norm" {print $3,$4}' $file0 >> temp_H1-Bonn-Norm
awk '$1=="H2" && $2=="Bonn-Norm" {print $3,$4}' $file0 >> temp_H2-Bonn-Norm
awk '$1=="H3" && $2=="Bonn-Norm" {print $3,$4}' $file0 >> temp_H3-Bonn-Norm
awk '$1=="S1" && $2=="Bonn-Norm" {print $3,$4}' $file0 >> temp_S1-Bonn-Norm
awk '$1=="S2" && $2=="Bonn-Norm" {print $3,$4}' $file0 >> temp_S2-Bonn-Norm
awk '$1=="S3" && $2=="Bonn-Norm" {print $3,$4}' $file0 >> temp_S3-Bonn-Norm
awk '$1=="H1" && $2=="Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_H1-Bonn-Norm-MEC
awk '$1=="H2" && $2=="Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_H2-Bonn-Norm-MEC
awk '$1=="H3" && $2=="Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_H3-Bonn-Norm-MEC
awk '$1=="S1" && $2=="Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_S1-Bonn-Norm-MEC
awk '$1=="S2" && $2=="Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_S2-Bonn-Norm-MEC
awk '$1=="S3" && $2=="Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_S3-Bonn-Norm-MEC
awk '$1=="H1" && $2=="Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H1-Bonn-Norm-MEC-IC
awk '$1=="H2" && $2=="Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H2-Bonn-Norm-MEC-IC
awk '$1=="H3" && $2=="Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H3-Bonn-Norm-MEC-IC
awk '$1=="S1" && $2=="Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S1-Bonn-Norm-MEC-IC
awk '$1=="S2" && $2=="Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S2-Bonn-Norm-MEC-IC
awk '$1=="S3" && $2=="Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S3-Bonn-Norm-MEC-IC
awk '$1=="H1" && $2=="Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H1-Bonn-Norm-MEC-IC-Rel
awk '$1=="H2" && $2=="Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H2-Bonn-Norm-MEC-IC-Rel
awk '$1=="H3" && $2=="Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H3-Bonn-Norm-MEC-IC-Rel
awk '$1=="S1" && $2=="Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S1-Bonn-Norm-MEC-IC-Rel
awk '$1=="S2" && $2=="Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S2-Bonn-Norm-MEC-IC-Rel
awk '$1=="S3" && $2=="Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S3-Bonn-Norm-MEC-IC-Rel
awk '$1=="H1" && $2=="Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_H1-Bonn-Norm-Rel
awk '$1=="H2" && $2=="Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_H2-Bonn-Norm-Rel
awk '$1=="H3" && $2=="Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_H3-Bonn-Norm-Rel
awk '$1=="S1" && $2=="Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_S1-Bonn-Norm-Rel
awk '$1=="S2" && $2=="Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_S2-Bonn-Norm-Rel
awk '$1=="S3" && $2=="Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_S3-Bonn-Norm-Rel
awk '$1=="H1" && $2=="Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_H1-Bonn-PWBA-NR
awk '$1=="H2" && $2=="Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_H2-Bonn-PWBA-NR
awk '$1=="H3" && $2=="Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_H3-Bonn-PWBA-NR
awk '$1=="S1" && $2=="Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_S1-Bonn-PWBA-NR
awk '$1=="S2" && $2=="Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_S2-Bonn-PWBA-NR
awk '$1=="S3" && $2=="Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_S3-Bonn-PWBA-NR
awk '$1=="H1" && $2=="Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_H1-Bonn-PWBA-RC
awk '$1=="H2" && $2=="Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_H2-Bonn-PWBA-RC
awk '$1=="H3" && $2=="Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_H3-Bonn-PWBA-RC
awk '$1=="S1" && $2=="Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_S1-Bonn-PWBA-RC
awk '$1=="S2" && $2=="Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_S2-Bonn-PWBA-RC
awk '$1=="S3" && $2=="Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_S3-Bonn-PWBA-RC
awk '$1=="H1" && $2=="LC-AV18" {print $3,$4}' $file0 >> temp_H1-LC-AV18
awk '$1=="H2" && $2=="LC-AV18" {print $3,$4}' $file0 >> temp_H2-LC-AV18
awk '$1=="H3" && $2=="LC-AV18" {print $3,$4}' $file0 >> temp_H3-LC-AV18
awk '$1=="S1" && $2=="LC-AV18" {print $3,$4}' $file0 >> temp_S1-LC-AV18
awk '$1=="S1" && $2=="LC-AV18" {print $3,$4}' $file0 >> S1-LC-AV18
awk '$1=="S2" && $2=="LC-AV18" {print $3,$4}' $file0 >> temp_S2-LC-AV18
awk '$1=="S3" && $2=="LC-AV18" {print $3,$4}' $file0 >> temp_S3-LC-AV18
awk '$1=="H1" && $2=="LC-CDBonn" {print $3,$4}' $file0 >> temp_H1-LC-CDBonn
awk '$1=="H2" && $2=="LC-CDBonn" {print $3,$4}' $file0 >> temp_H2-LC-CDBonn
awk '$1=="H3" && $2=="LC-CDBonn" {print $3,$4}' $file0 >> temp_H3-LC-CDBonn
awk '$1=="S1" && $2=="LC-CDBonn" {print $3,$4}' $file0 >> temp_S1-LC-CDBonn
awk '$1=="S2" && $2=="LC-CDBonn" {print $3,$4}' $file0 >> temp_S2-LC-CDBonn
awk '$1=="S3" && $2=="LC-CDBonn" {print $3,$4}' $file0 >> temp_S3-LC-CDBonn
awk '$1=="H1" && $2=="VN-AV18" {print $3,$4}' $file0 >> temp_H1-VN-AV18
awk '$1=="H2" && $2=="VN-AV18" {print $3,$4}' $file0 >> temp_H2-VN-AV18
awk '$1=="H3" && $2=="VN-AV18" {print $3,$4}' $file0 >> temp_H3-VN-AV18
awk '$1=="S1" && $2=="VN-AV18" {print $3,$4}' $file0 >> temp_S1-VN-AV18
awk '$1=="S2" && $2=="VN-AV18" {print $3,$4}' $file0 >> temp_S2-VN-AV18
awk '$1=="S3" && $2=="VN-AV18" {print $3,$4}' $file0 >> temp_S3-VN-AV18
awk '$1=="H1" && $2=="VN-CDBonn" {print $3,$4}' $file0 >> temp_H1-VN-CDBonn
awk '$1=="H2" && $2=="VN-CDBonn" {print $3,$4}' $file0 >> temp_H2-VN-CDBonn
awk '$1=="H3" && $2=="VN-CDBonn" {print $3,$4}' $file0 >> temp_H3-VN-CDBonn
awk '$1=="S1" && $2=="VN-CDBonn" {print $3,$4}' $file0 >> temp_S1-VN-CDBonn
awk '$1=="S2" && $2=="VN-CDBonn" {print $3,$4}' $file0 >> temp_S2-VN-CDBonn
awk '$1=="S3" && $2=="VN-CDBonn" {print $3,$4}' $file0 >> temp_S3-VN-CDBonn
awk '$1=="H1" && $2=="PW-AV18" {print $3,$4}' $file0 >> temp_H1-PW-AV18
awk '$1=="H2" && $2=="PW-AV18" {print $3,$4}' $file0 >> temp_H2-PW-AV18
awk '$1=="H3" && $2=="PW-AV18" {print $3,$4}' $file0 >> temp_H3-PW-AV18
awk '$1=="S1" && $2=="PW-AV18" {print $3,$4}' $file0 >> temp_S1-PW-AV18
awk '$1=="S2" && $2=="PW-AV18" {print $3,$4}' $file0 >> temp_S2-PW-AV18
awk '$1=="S3" && $2=="PW-AV18" {print $3,$4}' $file0 >> temp_S3-PW-AV18
awk '$1=="H1" && $2=="PW-CDBonn" {print $3,$4}' $file0 >> temp_H1-PW-CDBonn
awk '$1=="H2" && $2=="PW-CDBonn" {print $3,$4}' $file0 >> temp_H2-PW-CDBonn
awk '$1=="H3" && $2=="PW-CDBonn" {print $3,$4}' $file0 >> temp_H3-PW-CDBonn
awk '$1=="S1" && $2=="PW-CDBonn" {print $3,$4}' $file0 >> temp_S1-PW-CDBonn
awk '$1=="S2" && $2=="PW-CDBonn" {print $3,$4}' $file0 >> temp_S2-PW-CDBonn
awk '$1=="S3" && $2=="PW-CDBonn" {print $3,$4}' $file0 >> temp_S3-PW-CDBonn
awk '$1=="H1" && $2=="PW+FSIOff-AV18" {print $3,$4}' $file0 >> temp_H1-PW-FSIOff-AV18
awk '$1=="H2" && $2=="PW+FSIOff-AV18" {print $3,$4}' $file0 >> temp_H2-PW-FSIOff-AV18
awk '$1=="H3" && $2=="PW+FSIOff-AV18" {print $3,$4}' $file0 >> temp_H3-PW-FSIOff-AV18
#		-settype xy			-block 				-graph 0 -bxy 1:2 \
awk '$1=="S1" && $2=="PW+FSIOff-AV18" {print $3,$4}' $file0 >> temp_S1-PW-FSIOff-AV18
awk '$1=="S2" && $2=="PW+FSIOff-AV18" {print $3,$4}' $file0 >> temp_S2-PW-FSIOff-AV18
awk '$1=="S3" && $2=="PW+FSIOff-AV18" {print $3,$4}' $file0 >> temp_S3-PW-FSIOff-AV18
awk '$1=="H1" && $2=="PW+FSIOff-CDBonn" {print $3,$4}' $file0 >> temp_H1-PW-FSIOff-CDBonn
awk '$1=="H2" && $2=="PW+FSIOff-CDBonn" {print $3,$4}' $file0 >> temp_H2-PW-FSIOff-CDBonn
awk '$1=="H3" && $2=="PW+FSIOff-CDBonn" {print $3,$4}' $file0 >> temp_H3-PW-FSIOff-CDBonn
awk '$1=="S1" && $2=="PW+FSIOff-CDBonn" {print $3,$4}' $file0 >> temp_S1-PW-FSIOff-CDBonn
awk '$1=="S2" && $2=="PW+FSIOff-CDBonn" {print $3,$4}' $file0 >> temp_S2-PW-FSIOff-CDBonn
awk '$1=="S3" && $2=="PW+FSIOff-CDBonn" {print $3,$4}' $file0 >> temp_S3-PW-FSIOff-CDBonn
awk '$1=="H1" && $2=="PW+FSIOn-AV18" {print $3,$4}' $file0 >> temp_H1-PW-FSIOn-AV18
awk '$1=="H2" && $2=="PW+FSIOn-AV18" {print $3,$4}' $file0 >> temp_H2-PW-FSIOn-AV18
awk '$1=="H3" && $2=="PW+FSIOn-AV18" {print $3,$4}' $file0 >> temp_H3-PW-FSIOn-AV18
awk '$1=="S1" && $2=="PW+FSIOn-AV18" {print $3,$4}' $file0 >> temp_S1-PW-FSIOn-AV18
awk '$1=="S2" && $2=="PW+FSIOn-AV18" {print $3,$4}' $file0 >> temp_S2-PW-FSIOn-AV18
awk '$1=="S3" && $2=="PW+FSIOn-AV18" {print $3,$4}' $file0 >> temp_S3-PW-FSIOn-AV18
awk '$1=="H1" && $2=="PW+FSIOn-CDBonn" {print $3,$4}' $file0 >> temp_H1-PW-FSIOn-CDBonn
awk '$1=="H2" && $2=="PW+FSIOn-CDBonn" {print $3,$4}' $file0 >> temp_H2-PW-FSIOn-CDBonn
awk '$1=="H3" && $2=="PW+FSIOn-CDBonn" {print $3,$4}' $file0 >> temp_H3-PW-FSIOn-CDBonn
awk '$1=="S1" && $2=="PW+FSIOn-CDBonn" {print $3,$4}' $file0 >> temp_S1-PW-FSIOn-CDBonn
awk '$1=="S2" && $2=="PW+FSIOn-CDBonn" {print $3,$4}' $file0 >> temp_S2-PW-FSIOn-CDBonn
awk '$1=="S3" && $2=="PW+FSIOn-CDBonn" {print $3,$4}' $file0 >> temp_S3-PW-FSIOn-CDBonn


awk '$1=="H1" && $2=="alphaVd-AV18-Norm" {print $3,$4}' $file0 >> temp_H1-alphaVd-AV18-Norm
awk '$1=="H2" && $2=="alphaVd-AV18-Norm" {print $3,$4}' $file0 >> temp_H2-alphaVd-AV18-Norm
awk '$1=="H3" && $2=="alphaVd-AV18-Norm" {print $3,$4}' $file0 >> temp_H3-alphaVd-AV18-Norm
awk '$1=="S1" && $2=="alphaVd-AV18-Norm" {print $3,$4}' $file0 >> temp_S1-alphaVd-AV18-Norm
awk '$1=="S2" && $2=="alphaVd-AV18-Norm" {print $3,$4}' $file0 >> temp_S2-alphaVd-AV18-Norm
awk '$1=="S3" && $2=="alphaVd-AV18-Norm" {print $3,$4}' $file0 >> temp_S3-alphaVd-AV18-Norm
awk '$1=="H1" && $2=="alphaVd-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_H1-alphaVd-AV18-Norm-MEC
awk '$1=="H2" && $2=="alphaVd-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_H2-alphaVd-AV18-Norm-MEC
awk '$1=="H3" && $2=="alphaVd-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_H3-alphaVd-AV18-Norm-MEC
awk '$1=="S1" && $2=="alphaVd-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_S1-alphaVd-AV18-Norm-MEC
awk '$1=="S2" && $2=="alphaVd-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_S2-alphaVd-AV18-Norm-MEC
awk '$1=="S3" && $2=="alphaVd-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_S3-alphaVd-AV18-Norm-MEC
awk '$1=="H1" && $2=="alphaVd-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H1-alphaVd-AV18-Norm-MEC-IC
awk '$1=="H2" && $2=="alphaVd-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H2-alphaVd-AV18-Norm-MEC-IC
awk '$1=="H3" && $2=="alphaVd-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H3-alphaVd-AV18-Norm-MEC-IC
awk '$1=="S1" && $2=="alphaVd-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S1-alphaVd-AV18-Norm-MEC-IC
awk '$1=="S2" && $2=="alphaVd-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S2-alphaVd-AV18-Norm-MEC-IC
awk '$1=="S3" && $2=="alphaVd-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S3-alphaVd-AV18-Norm-MEC-IC
awk '$1=="H1" && $2=="alphaVd-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H1-alphaVd-AV18-Norm-MEC-IC-Rel
awk '$1=="H2" && $2=="alphaVd-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H2-alphaVd-AV18-Norm-MEC-IC-Rel
awk '$1=="H3" && $2=="alphaVd-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H3-alphaVd-AV18-Norm-MEC-IC-Rel
awk '$1=="S1" && $2=="alphaVd-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S1-alphaVd-AV18-Norm-MEC-IC-Rel
awk '$1=="S2" && $2=="alphaVd-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S2-alphaVd-AV18-Norm-MEC-IC-Rel
awk '$1=="S3" && $2=="alphaVd-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S3-alphaVd-AV18-Norm-MEC-IC-Rel
awk '$1=="H1" && $2=="alphaVd-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_H1-alphaVd-AV18-Norm-Rel
awk '$1=="H2" && $2=="alphaVd-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_H2-alphaVd-AV18-Norm-Rel
awk '$1=="H3" && $2=="alphaVd-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_H3-alphaVd-AV18-Norm-Rel
awk '$1=="S1" && $2=="alphaVd-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_S1-alphaVd-AV18-Norm-Rel
awk '$1=="S2" && $2=="alphaVd-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_S2-alphaVd-AV18-Norm-Rel
awk '$1=="S3" && $2=="alphaVd-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_S3-alphaVd-AV18-Norm-Rel
awk '$1=="H1" && $2=="alphaVd-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_H1-alphaVd-AV18-PWBA-NR
awk '$1=="H2" && $2=="alphaVd-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_H2-alphaVd-AV18-PWBA-NR
awk '$1=="H3" && $2=="alphaVd-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_H3-alphaVd-AV18-PWBA-NR
awk '$1=="S1" && $2=="alphaVd-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_S1-alphaVd-AV18-PWBA-NR
awk '$1=="S2" && $2=="alphaVd-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_S2-alphaVd-AV18-PWBA-NR
awk '$1=="S3" && $2=="alphaVd-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_S3-alphaVd-AV18-PWBA-NR
awk '$1=="H1" && $2=="alphaVd-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_H1-alphaVd-AV18-PWBA-RC
awk '$1=="H2" && $2=="alphaVd-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_H2-alphaVd-AV18-PWBA-RC
awk '$1=="H3" && $2=="alphaVd-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_H3-alphaVd-AV18-PWBA-RC
awk '$1=="S1" && $2=="alphaVd-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_S1-alphaVd-AV18-PWBA-RC
awk '$1=="S2" && $2=="alphaVd-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_S2-alphaVd-AV18-PWBA-RC
awk '$1=="S3" && $2=="alphaVd-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_S3-alphaVd-AV18-PWBA-RC
awk '$1=="H1" && $2=="alphaVd-Bonn-Norm" {print $3,$4}' $file0 >> temp_H1-alphaVd-Bonn-Norm
awk '$1=="H2" && $2=="alphaVd-Bonn-Norm" {print $3,$4}' $file0 >> temp_H2-alphaVd-Bonn-Norm
awk '$1=="H3" && $2=="alphaVd-Bonn-Norm" {print $3,$4}' $file0 >> temp_H3-alphaVd-Bonn-Norm
awk '$1=="S1" && $2=="alphaVd-Bonn-Norm" {print $3,$4}' $file0 >> temp_S1-alphaVd-Bonn-Norm
awk '$1=="S2" && $2=="alphaVd-Bonn-Norm" {print $3,$4}' $file0 >> temp_S2-alphaVd-Bonn-Norm
awk '$1=="S3" && $2=="alphaVd-Bonn-Norm" {print $3,$4}' $file0 >> temp_S3-alphaVd-Bonn-Norm
awk '$1=="H1" && $2=="alphaVd-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_H1-alphaVd-Bonn-Norm-MEC
awk '$1=="H2" && $2=="alphaVd-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_H2-alphaVd-Bonn-Norm-MEC
awk '$1=="H3" && $2=="alphaVd-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_H3-alphaVd-Bonn-Norm-MEC
awk '$1=="S1" && $2=="alphaVd-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_S1-alphaVd-Bonn-Norm-MEC
awk '$1=="S2" && $2=="alphaVd-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_S2-alphaVd-Bonn-Norm-MEC
awk '$1=="S3" && $2=="alphaVd-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_S3-alphaVd-Bonn-Norm-MEC
awk '$1=="H1" && $2=="alphaVd-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H1-alphaVd-Bonn-Norm-MEC-IC
awk '$1=="H2" && $2=="alphaVd-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H2-alphaVd-Bonn-Norm-MEC-IC
awk '$1=="H3" && $2=="alphaVd-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H3-alphaVd-Bonn-Norm-MEC-IC
awk '$1=="S1" && $2=="alphaVd-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S1-alphaVd-Bonn-Norm-MEC-IC
awk '$1=="S2" && $2=="alphaVd-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S2-alphaVd-Bonn-Norm-MEC-IC
awk '$1=="S3" && $2=="alphaVd-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S3-alphaVd-Bonn-Norm-MEC-IC
awk '$1=="H1" && $2=="alphaVd-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H1-alphaVd-Bonn-Norm-MEC-IC-Rel
awk '$1=="H2" && $2=="alphaVd-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H2-alphaVd-Bonn-Norm-MEC-IC-Rel
awk '$1=="H3" && $2=="alphaVd-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H3-alphaVd-Bonn-Norm-MEC-IC-Rel
awk '$1=="S1" && $2=="alphaVd-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S1-alphaVd-Bonn-Norm-MEC-IC-Rel
awk '$1=="S2" && $2=="alphaVd-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S2-alphaVd-Bonn-Norm-MEC-IC-Rel
awk '$1=="S3" && $2=="alphaVd-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S3-alphaVd-Bonn-Norm-MEC-IC-Rel
awk '$1=="H1" && $2=="alphaVd-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_H1-alphaVd-Bonn-Norm-Rel
awk '$1=="H2" && $2=="alphaVd-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_H2-alphaVd-Bonn-Norm-Rel
awk '$1=="H3" && $2=="alphaVd-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_H3-alphaVd-Bonn-Norm-Rel
awk '$1=="S1" && $2=="alphaVd-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_S1-alphaVd-Bonn-Norm-Rel
awk '$1=="S2" && $2=="alphaVd-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_S2-alphaVd-Bonn-Norm-Rel
awk '$1=="S3" && $2=="alphaVd-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_S3-alphaVd-Bonn-Norm-Rel
awk '$1=="H1" && $2=="alphaVd-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_H1-alphaVd-Bonn-PWBA-NR
awk '$1=="H2" && $2=="alphaVd-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_H2-alphaVd-Bonn-PWBA-NR
awk '$1=="H3" && $2=="alphaVd-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_H3-alphaVd-Bonn-PWBA-NR
awk '$1=="S1" && $2=="alphaVd-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_S1-alphaVd-Bonn-PWBA-NR
awk '$1=="S2" && $2=="alphaVd-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_S2-alphaVd-Bonn-PWBA-NR
awk '$1=="S3" && $2=="alphaVd-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_S3-alphaVd-Bonn-PWBA-NR
awk '$1=="H1" && $2=="alphaVd-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_H1-alphaVd-Bonn-PWBA-RC
awk '$1=="H2" && $2=="alphaVd-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_H2-alphaVd-Bonn-PWBA-RC
awk '$1=="H3" && $2=="alphaVd-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_H3-alphaVd-Bonn-PWBA-RC
awk '$1=="S1" && $2=="alphaVd-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_S1-alphaVd-Bonn-PWBA-RC
awk '$1=="S2" && $2=="alphaVd-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_S2-alphaVd-Bonn-PWBA-RC
awk '$1=="S3" && $2=="alphaVd-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_S3-alphaVd-Bonn-PWBA-RC


awk '$1=="H1" && $2=="alphaVed-AV18-Norm" {print $3,$4}' $file0 >> temp_H1-alphaVed-AV18-Norm
awk '$1=="H2" && $2=="alphaVed-AV18-Norm" {print $3,$4}' $file0 >> temp_H2-alphaVed-AV18-Norm
awk '$1=="H3" && $2=="alphaVed-AV18-Norm" {print $3,$4}' $file0 >> temp_H3-alphaVed-AV18-Norm
awk '$1=="S1" && $2=="alphaVed-AV18-Norm" {print $3,$4}' $file0 >> temp_S1-alphaVed-AV18-Norm
awk '$1=="S2" && $2=="alphaVed-AV18-Norm" {print $3,$4}' $file0 >> temp_S2-alphaVed-AV18-Norm
awk '$1=="S3" && $2=="alphaVed-AV18-Norm" {print $3,$4}' $file0 >> temp_S3-alphaVed-AV18-Norm
awk '$1=="H1" && $2=="alphaVed-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_H1-alphaVed-AV18-Norm-MEC
awk '$1=="H2" && $2=="alphaVed-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_H2-alphaVed-AV18-Norm-MEC
awk '$1=="H3" && $2=="alphaVed-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_H3-alphaVed-AV18-Norm-MEC
awk '$1=="S1" && $2=="alphaVed-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_S1-alphaVed-AV18-Norm-MEC
awk '$1=="S2" && $2=="alphaVed-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_S2-alphaVed-AV18-Norm-MEC
awk '$1=="S3" && $2=="alphaVed-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_S3-alphaVed-AV18-Norm-MEC
awk '$1=="H1" && $2=="alphaVed-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H1-alphaVed-AV18-Norm-MEC-IC
awk '$1=="H2" && $2=="alphaVed-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H2-alphaVed-AV18-Norm-MEC-IC
awk '$1=="H3" && $2=="alphaVed-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H3-alphaVed-AV18-Norm-MEC-IC
awk '$1=="S1" && $2=="alphaVed-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S1-alphaVed-AV18-Norm-MEC-IC
awk '$1=="S2" && $2=="alphaVed-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S2-alphaVed-AV18-Norm-MEC-IC
awk '$1=="S3" && $2=="alphaVed-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S3-alphaVed-AV18-Norm-MEC-IC
awk '$1=="H1" && $2=="alphaVed-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H1-alphaVed-AV18-Norm-MEC-IC-Rel
awk '$1=="H2" && $2=="alphaVed-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H2-alphaVed-AV18-Norm-MEC-IC-Rel
awk '$1=="H3" && $2=="alphaVed-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H3-alphaVed-AV18-Norm-MEC-IC-Rel
awk '$1=="S1" && $2=="alphaVed-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S1-alphaVed-AV18-Norm-MEC-IC-Rel
awk '$1=="S2" && $2=="alphaVed-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S2-alphaVed-AV18-Norm-MEC-IC-Rel
awk '$1=="S3" && $2=="alphaVed-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S3-alphaVed-AV18-Norm-MEC-IC-Rel
awk '$1=="H1" && $2=="alphaVed-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_H1-alphaVed-AV18-Norm-Rel
awk '$1=="H2" && $2=="alphaVed-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_H2-alphaVed-AV18-Norm-Rel
awk '$1=="H3" && $2=="alphaVed-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_H3-alphaVed-AV18-Norm-Rel
awk '$1=="S1" && $2=="alphaVed-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_S1-alphaVed-AV18-Norm-Rel
awk '$1=="S2" && $2=="alphaVed-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_S2-alphaVed-AV18-Norm-Rel
awk '$1=="S3" && $2=="alphaVed-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_S3-alphaVed-AV18-Norm-Rel
awk '$1=="H1" && $2=="alphaVed-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_H1-alphaVed-AV18-PWBA-NR
awk '$1=="H2" && $2=="alphaVed-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_H2-alphaVed-AV18-PWBA-NR
awk '$1=="H3" && $2=="alphaVed-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_H3-alphaVed-AV18-PWBA-NR
awk '$1=="S1" && $2=="alphaVed-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_S1-alphaVed-AV18-PWBA-NR
awk '$1=="S2" && $2=="alphaVed-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_S2-alphaVed-AV18-PWBA-NR
awk '$1=="S3" && $2=="alphaVed-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_S3-alphaVed-AV18-PWBA-NR
awk '$1=="H1" && $2=="alphaVed-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_H1-alphaVed-AV18-PWBA-RC
awk '$1=="H2" && $2=="alphaVed-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_H2-alphaVed-AV18-PWBA-RC
awk '$1=="H3" && $2=="alphaVed-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_H3-alphaVed-AV18-PWBA-RC
awk '$1=="S1" && $2=="alphaVed-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_S1-alphaVed-AV18-PWBA-RC
awk '$1=="S2" && $2=="alphaVed-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_S2-alphaVed-AV18-PWBA-RC
awk '$1=="S3" && $2=="alphaVed-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_S3-alphaVed-AV18-PWBA-RC
awk '$1=="H1" && $2=="alphaVed-Bonn-Norm" {print $3,$4}' $file0 >> temp_H1-alphaVed-Bonn-Norm
awk '$1=="H2" && $2=="alphaVed-Bonn-Norm" {print $3,$4}' $file0 >> temp_H2-alphaVed-Bonn-Norm
awk '$1=="H3" && $2=="alphaVed-Bonn-Norm" {print $3,$4}' $file0 >> temp_H3-alphaVed-Bonn-Norm
awk '$1=="S1" && $2=="alphaVed-Bonn-Norm" {print $3,$4}' $file0 >> temp_S1-alphaVed-Bonn-Norm
awk '$1=="S2" && $2=="alphaVed-Bonn-Norm" {print $3,$4}' $file0 >> temp_S2-alphaVed-Bonn-Norm
awk '$1=="S3" && $2=="alphaVed-Bonn-Norm" {print $3,$4}' $file0 >> temp_S3-alphaVed-Bonn-Norm
awk '$1=="H1" && $2=="alphaVed-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_H1-alphaVed-Bonn-Norm-MEC
awk '$1=="H2" && $2=="alphaVed-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_H2-alphaVed-Bonn-Norm-MEC
awk '$1=="H3" && $2=="alphaVed-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_H3-alphaVed-Bonn-Norm-MEC
awk '$1=="S1" && $2=="alphaVed-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_S1-alphaVed-Bonn-Norm-MEC
awk '$1=="S2" && $2=="alphaVed-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_S2-alphaVed-Bonn-Norm-MEC
awk '$1=="S3" && $2=="alphaVed-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_S3-alphaVed-Bonn-Norm-MEC
awk '$1=="H1" && $2=="alphaVed-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H1-alphaVed-Bonn-Norm-MEC-IC
awk '$1=="H2" && $2=="alphaVed-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H2-alphaVed-Bonn-Norm-MEC-IC
awk '$1=="H3" && $2=="alphaVed-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H3-alphaVed-Bonn-Norm-MEC-IC
awk '$1=="S1" && $2=="alphaVed-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S1-alphaVed-Bonn-Norm-MEC-IC
awk '$1=="S2" && $2=="alphaVed-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S2-alphaVed-Bonn-Norm-MEC-IC
awk '$1=="S3" && $2=="alphaVed-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S3-alphaVed-Bonn-Norm-MEC-IC
awk '$1=="H1" && $2=="alphaVed-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H1-alphaVed-Bonn-Norm-MEC-IC-Rel
awk '$1=="H2" && $2=="alphaVed-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H2-alphaVed-Bonn-Norm-MEC-IC-Rel
awk '$1=="H3" && $2=="alphaVed-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H3-alphaVed-Bonn-Norm-MEC-IC-Rel
awk '$1=="S1" && $2=="alphaVed-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S1-alphaVed-Bonn-Norm-MEC-IC-Rel
awk '$1=="S2" && $2=="alphaVed-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S2-alphaVed-Bonn-Norm-MEC-IC-Rel
awk '$1=="S3" && $2=="alphaVed-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S3-alphaVed-Bonn-Norm-MEC-IC-Rel
awk '$1=="H1" && $2=="alphaVed-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_H1-alphaVed-Bonn-Norm-Rel
awk '$1=="H2" && $2=="alphaVed-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_H2-alphaVed-Bonn-Norm-Rel
awk '$1=="H3" && $2=="alphaVed-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_H3-alphaVed-Bonn-Norm-Rel
awk '$1=="S1" && $2=="alphaVed-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_S1-alphaVed-Bonn-Norm-Rel
awk '$1=="S2" && $2=="alphaVed-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_S2-alphaVed-Bonn-Norm-Rel
awk '$1=="S3" && $2=="alphaVed-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_S3-alphaVed-Bonn-Norm-Rel
awk '$1=="H1" && $2=="alphaVed-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_H1-alphaVed-Bonn-PWBA-NR
awk '$1=="H2" && $2=="alphaVed-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_H2-alphaVed-Bonn-PWBA-NR
awk '$1=="H3" && $2=="alphaVed-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_H3-alphaVed-Bonn-PWBA-NR
awk '$1=="S1" && $2=="alphaVed-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_S1-alphaVed-Bonn-PWBA-NR
awk '$1=="S2" && $2=="alphaVed-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_S2-alphaVed-Bonn-PWBA-NR
awk '$1=="S3" && $2=="alphaVed-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_S3-alphaVed-Bonn-PWBA-NR
awk '$1=="H1" && $2=="alphaVed-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_H1-alphaVed-Bonn-PWBA-RC
awk '$1=="H2" && $2=="alphaVed-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_H2-alphaVed-Bonn-PWBA-RC
awk '$1=="H3" && $2=="alphaVed-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_H3-alphaVed-Bonn-PWBA-RC
awk '$1=="S1" && $2=="alphaVed-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_S1-alphaVed-Bonn-PWBA-RC
awk '$1=="S2" && $2=="alphaVed-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_S2-alphaVed-Bonn-PWBA-RC
awk '$1=="S3" && $2=="alphaVed-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_S3-alphaVed-Bonn-PWBA-RC


awk '$1=="H1" && $2=="alphaTed-AV18-Norm" {print $3,$4}' $file0 >> temp_H1-alphaTed-AV18-Norm
awk '$1=="H2" && $2=="alphaTed-AV18-Norm" {print $3,$4}' $file0 >> temp_H2-alphaTed-AV18-Norm
awk '$1=="H3" && $2=="alphaTed-AV18-Norm" {print $3,$4}' $file0 >> temp_H3-alphaTed-AV18-Norm
awk '$1=="S1" && $2=="alphaTed-AV18-Norm" {print $3,$4}' $file0 >> temp_S1-alphaTed-AV18-Norm
awk '$1=="S2" && $2=="alphaTed-AV18-Norm" {print $3,$4}' $file0 >> temp_S2-alphaTed-AV18-Norm
awk '$1=="S3" && $2=="alphaTed-AV18-Norm" {print $3,$4}' $file0 >> temp_S3-alphaTed-AV18-Norm
awk '$1=="H1" && $2=="alphaTed-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_H1-alphaTed-AV18-Norm-MEC
awk '$1=="H2" && $2=="alphaTed-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_H2-alphaTed-AV18-Norm-MEC
awk '$1=="H3" && $2=="alphaTed-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_H3-alphaTed-AV18-Norm-MEC
awk '$1=="S1" && $2=="alphaTed-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_S1-alphaTed-AV18-Norm-MEC
awk '$1=="S2" && $2=="alphaTed-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_S2-alphaTed-AV18-Norm-MEC
awk '$1=="S3" && $2=="alphaTed-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_S3-alphaTed-AV18-Norm-MEC
awk '$1=="H1" && $2=="alphaTed-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H1-alphaTed-AV18-Norm-MEC-IC
awk '$1=="H2" && $2=="alphaTed-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H2-alphaTed-AV18-Norm-MEC-IC
awk '$1=="H3" && $2=="alphaTed-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H3-alphaTed-AV18-Norm-MEC-IC
awk '$1=="S1" && $2=="alphaTed-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S1-alphaTed-AV18-Norm-MEC-IC
awk '$1=="S2" && $2=="alphaTed-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S2-alphaTed-AV18-Norm-MEC-IC
awk '$1=="S3" && $2=="alphaTed-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S3-alphaTed-AV18-Norm-MEC-IC
awk '$1=="H1" && $2=="alphaTed-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H1-alphaTed-AV18-Norm-MEC-IC-Rel
awk '$1=="H2" && $2=="alphaTed-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H2-alphaTed-AV18-Norm-MEC-IC-Rel
awk '$1=="H3" && $2=="alphaTed-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H3-alphaTed-AV18-Norm-MEC-IC-Rel
awk '$1=="S1" && $2=="alphaTed-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S1-alphaTed-AV18-Norm-MEC-IC-Rel
awk '$1=="S2" && $2=="alphaTed-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S2-alphaTed-AV18-Norm-MEC-IC-Rel
awk '$1=="S3" && $2=="alphaTed-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S3-alphaTed-AV18-Norm-MEC-IC-Rel
awk '$1=="H1" && $2=="alphaTed-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_H1-alphaTed-AV18-Norm-Rel
awk '$1=="H2" && $2=="alphaTed-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_H2-alphaTed-AV18-Norm-Rel
awk '$1=="H3" && $2=="alphaTed-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_H3-alphaTed-AV18-Norm-Rel
awk '$1=="S1" && $2=="alphaTed-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_S1-alphaTed-AV18-Norm-Rel
awk '$1=="S2" && $2=="alphaTed-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_S2-alphaTed-AV18-Norm-Rel
awk '$1=="S3" && $2=="alphaTed-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_S3-alphaTed-AV18-Norm-Rel
awk '$1=="H1" && $2=="alphaTed-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_H1-alphaTed-AV18-PWBA-NR
awk '$1=="H2" && $2=="alphaTed-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_H2-alphaTed-AV18-PWBA-NR
awk '$1=="H3" && $2=="alphaTed-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_H3-alphaTed-AV18-PWBA-NR
awk '$1=="S1" && $2=="alphaTed-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_S1-alphaTed-AV18-PWBA-NR
awk '$1=="S2" && $2=="alphaTed-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_S2-alphaTed-AV18-PWBA-NR
awk '$1=="S3" && $2=="alphaTed-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_S3-alphaTed-AV18-PWBA-NR
awk '$1=="H1" && $2=="alphaTed-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_H1-alphaTed-AV18-PWBA-RC
awk '$1=="H2" && $2=="alphaTed-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_H2-alphaTed-AV18-PWBA-RC
awk '$1=="H3" && $2=="alphaTed-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_H3-alphaTed-AV18-PWBA-RC
awk '$1=="S1" && $2=="alphaTed-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_S1-alphaTed-AV18-PWBA-RC
awk '$1=="S2" && $2=="alphaTed-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_S2-alphaTed-AV18-PWBA-RC
awk '$1=="S3" && $2=="alphaTed-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_S3-alphaTed-AV18-PWBA-RC
awk '$1=="H1" && $2=="alphaTed-Bonn-Norm" {print $3,$4}' $file0 >> temp_H1-alphaTed-Bonn-Norm
awk '$1=="H2" && $2=="alphaTed-Bonn-Norm" {print $3,$4}' $file0 >> temp_H2-alphaTed-Bonn-Norm
awk '$1=="H3" && $2=="alphaTed-Bonn-Norm" {print $3,$4}' $file0 >> temp_H3-alphaTed-Bonn-Norm
awk '$1=="S1" && $2=="alphaTed-Bonn-Norm" {print $3,$4}' $file0 >> temp_S1-alphaTed-Bonn-Norm
awk '$1=="S2" && $2=="alphaTed-Bonn-Norm" {print $3,$4}' $file0 >> temp_S2-alphaTed-Bonn-Norm
awk '$1=="S3" && $2=="alphaTed-Bonn-Norm" {print $3,$4}' $file0 >> temp_S3-alphaTed-Bonn-Norm
awk '$1=="H1" && $2=="alphaTed-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_H1-alphaTed-Bonn-Norm-MEC
awk '$1=="H2" && $2=="alphaTed-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_H2-alphaTed-Bonn-Norm-MEC
awk '$1=="H3" && $2=="alphaTed-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_H3-alphaTed-Bonn-Norm-MEC
awk '$1=="S1" && $2=="alphaTed-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_S1-alphaTed-Bonn-Norm-MEC
awk '$1=="S2" && $2=="alphaTed-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_S2-alphaTed-Bonn-Norm-MEC
awk '$1=="S3" && $2=="alphaTed-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_S3-alphaTed-Bonn-Norm-MEC
awk '$1=="H1" && $2=="alphaTed-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H1-alphaTed-Bonn-Norm-MEC-IC
awk '$1=="H2" && $2=="alphaTed-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H2-alphaTed-Bonn-Norm-MEC-IC
awk '$1=="H3" && $2=="alphaTed-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H3-alphaTed-Bonn-Norm-MEC-IC
awk '$1=="S1" && $2=="alphaTed-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S1-alphaTed-Bonn-Norm-MEC-IC
awk '$1=="S2" && $2=="alphaTed-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S2-alphaTed-Bonn-Norm-MEC-IC
awk '$1=="S3" && $2=="alphaTed-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S3-alphaTed-Bonn-Norm-MEC-IC
awk '$1=="H1" && $2=="alphaTed-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H1-alphaTed-Bonn-Norm-MEC-IC-Rel
awk '$1=="H2" && $2=="alphaTed-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H2-alphaTed-Bonn-Norm-MEC-IC-Rel
awk '$1=="H3" && $2=="alphaTed-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H3-alphaTed-Bonn-Norm-MEC-IC-Rel
awk '$1=="S1" && $2=="alphaTed-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S1-alphaTed-Bonn-Norm-MEC-IC-Rel
awk '$1=="S2" && $2=="alphaTed-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S2-alphaTed-Bonn-Norm-MEC-IC-Rel
awk '$1=="S3" && $2=="alphaTed-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S3-alphaTed-Bonn-Norm-MEC-IC-Rel
awk '$1=="H1" && $2=="alphaTed-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_H1-alphaTed-Bonn-Norm-Rel
awk '$1=="H2" && $2=="alphaTed-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_H2-alphaTed-Bonn-Norm-Rel
awk '$1=="H3" && $2=="alphaTed-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_H3-alphaTed-Bonn-Norm-Rel
awk '$1=="S1" && $2=="alphaTed-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_S1-alphaTed-Bonn-Norm-Rel
awk '$1=="S2" && $2=="alphaTed-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_S2-alphaTed-Bonn-Norm-Rel
awk '$1=="S3" && $2=="alphaTed-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_S3-alphaTed-Bonn-Norm-Rel
awk '$1=="H1" && $2=="alphaTed-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_H1-alphaTed-Bonn-PWBA-NR
awk '$1=="H2" && $2=="alphaTed-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_H2-alphaTed-Bonn-PWBA-NR
awk '$1=="H3" && $2=="alphaTed-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_H3-alphaTed-Bonn-PWBA-NR
awk '$1=="S1" && $2=="alphaTed-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_S1-alphaTed-Bonn-PWBA-NR
awk '$1=="S2" && $2=="alphaTed-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_S2-alphaTed-Bonn-PWBA-NR
awk '$1=="S3" && $2=="alphaTed-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_S3-alphaTed-Bonn-PWBA-NR
awk '$1=="H1" && $2=="alphaTed-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_H1-alphaTed-Bonn-PWBA-RC
awk '$1=="H2" && $2=="alphaTed-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_H2-alphaTed-Bonn-PWBA-RC
awk '$1=="H3" && $2=="alphaTed-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_H3-alphaTed-Bonn-PWBA-RC
awk '$1=="S1" && $2=="alphaTed-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_S1-alphaTed-Bonn-PWBA-RC
awk '$1=="S2" && $2=="alphaTed-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_S2-alphaTed-Bonn-PWBA-RC
awk '$1=="S3" && $2=="alphaTed-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_S3-alphaTed-Bonn-PWBA-RC


awk '$1=="H1" && $2=="cs-dsdo-AV18-Norm" {print $3,$4}' $file0 >> temp_H1-cs-dsdo-AV18-Norm
awk '$1=="H2" && $2=="cs-dsdo-AV18-Norm" {print $3,$4}' $file0 >> temp_H2-cs-dsdo-AV18-Norm
awk '$1=="H3" && $2=="cs-dsdo-AV18-Norm" {print $3,$4}' $file0 >> temp_H3-cs-dsdo-AV18-Norm
awk '$1=="S1" && $2=="cs-dsdo-AV18-Norm" {print $3,$4}' $file0 >> temp_S1-cs-dsdo-AV18-Norm
awk '$1=="S2" && $2=="cs-dsdo-AV18-Norm" {print $3,$4}' $file0 >> temp_S2-cs-dsdo-AV18-Norm
awk '$1=="S3" && $2=="cs-dsdo-AV18-Norm" {print $3,$4}' $file0 >> temp_S3-cs-dsdo-AV18-Norm
awk '$1=="H1" && $2=="cs-dsdo-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_H1-cs-dsdo-AV18-Norm-MEC
awk '$1=="H2" && $2=="cs-dsdo-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_H2-cs-dsdo-AV18-Norm-MEC
awk '$1=="H3" && $2=="cs-dsdo-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_H3-cs-dsdo-AV18-Norm-MEC
awk '$1=="S1" && $2=="cs-dsdo-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_S1-cs-dsdo-AV18-Norm-MEC
awk '$1=="S2" && $2=="cs-dsdo-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_S2-cs-dsdo-AV18-Norm-MEC
awk '$1=="S3" && $2=="cs-dsdo-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_S3-cs-dsdo-AV18-Norm-MEC
awk '$1=="H1" && $2=="cs-dsdo-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H1-cs-dsdo-AV18-Norm-MEC-IC
awk '$1=="H2" && $2=="cs-dsdo-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H2-cs-dsdo-AV18-Norm-MEC-IC
awk '$1=="H3" && $2=="cs-dsdo-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H3-cs-dsdo-AV18-Norm-MEC-IC
awk '$1=="S1" && $2=="cs-dsdo-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S1-cs-dsdo-AV18-Norm-MEC-IC
awk '$1=="S2" && $2=="cs-dsdo-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S2-cs-dsdo-AV18-Norm-MEC-IC
awk '$1=="S3" && $2=="cs-dsdo-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S3-cs-dsdo-AV18-Norm-MEC-IC
awk '$1=="H1" && $2=="cs-dsdo-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H1-cs-dsdo-AV18-Norm-MEC-IC-Rel
awk '$1=="H2" && $2=="cs-dsdo-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H2-cs-dsdo-AV18-Norm-MEC-IC-Rel
awk '$1=="H3" && $2=="cs-dsdo-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H3-cs-dsdo-AV18-Norm-MEC-IC-Rel
awk '$1=="S1" && $2=="cs-dsdo-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S1-cs-dsdo-AV18-Norm-MEC-IC-Rel
awk '$1=="S2" && $2=="cs-dsdo-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S2-cs-dsdo-AV18-Norm-MEC-IC-Rel
awk '$1=="S3" && $2=="cs-dsdo-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S3-cs-dsdo-AV18-Norm-MEC-IC-Rel
awk '$1=="H1" && $2=="cs-dsdo-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_H1-cs-dsdo-AV18-Norm-Rel
awk '$1=="H2" && $2=="cs-dsdo-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_H2-cs-dsdo-AV18-Norm-Rel
awk '$1=="H3" && $2=="cs-dsdo-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_H3-cs-dsdo-AV18-Norm-Rel
awk '$1=="S1" && $2=="cs-dsdo-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_S1-cs-dsdo-AV18-Norm-Rel
awk '$1=="S2" && $2=="cs-dsdo-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_S2-cs-dsdo-AV18-Norm-Rel
awk '$1=="S3" && $2=="cs-dsdo-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_S3-cs-dsdo-AV18-Norm-Rel
awk '$1=="H1" && $2=="cs-dsdo-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_H1-cs-dsdo-AV18-PWBA-NR
awk '$1=="H2" && $2=="cs-dsdo-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_H2-cs-dsdo-AV18-PWBA-NR
awk '$1=="H3" && $2=="cs-dsdo-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_H3-cs-dsdo-AV18-PWBA-NR
awk '$1=="S1" && $2=="cs-dsdo-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_S1-cs-dsdo-AV18-PWBA-NR
awk '$1=="S2" && $2=="cs-dsdo-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_S2-cs-dsdo-AV18-PWBA-NR
awk '$1=="S3" && $2=="cs-dsdo-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_S3-cs-dsdo-AV18-PWBA-NR
awk '$1=="H1" && $2=="cs-dsdo-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_H1-cs-dsdo-AV18-PWBA-RC
awk '$1=="H2" && $2=="cs-dsdo-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_H2-cs-dsdo-AV18-PWBA-RC
awk '$1=="H3" && $2=="cs-dsdo-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_H3-cs-dsdo-AV18-PWBA-RC
awk '$1=="S1" && $2=="cs-dsdo-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_S1-cs-dsdo-AV18-PWBA-RC
awk '$1=="S2" && $2=="cs-dsdo-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_S2-cs-dsdo-AV18-PWBA-RC
awk '$1=="S3" && $2=="cs-dsdo-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_S3-cs-dsdo-AV18-PWBA-RC
awk '$1=="H1" && $2=="cs-dsdo-Bonn-Norm" {print $3,$4}' $file0 >> temp_H1-cs-dsdo-Bonn-Norm
awk '$1=="H2" && $2=="cs-dsdo-Bonn-Norm" {print $3,$4}' $file0 >> temp_H2-cs-dsdo-Bonn-Norm
awk '$1=="H3" && $2=="cs-dsdo-Bonn-Norm" {print $3,$4}' $file0 >> temp_H3-cs-dsdo-Bonn-Norm
awk '$1=="S1" && $2=="cs-dsdo-Bonn-Norm" {print $3,$4}' $file0 >> temp_S1-cs-dsdo-Bonn-Norm
awk '$1=="S2" && $2=="cs-dsdo-Bonn-Norm" {print $3,$4}' $file0 >> temp_S2-cs-dsdo-Bonn-Norm
awk '$1=="S3" && $2=="cs-dsdo-Bonn-Norm" {print $3,$4}' $file0 >> temp_S3-cs-dsdo-Bonn-Norm
awk '$1=="H1" && $2=="cs-dsdo-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_H1-cs-dsdo-Bonn-Norm-MEC
awk '$1=="H2" && $2=="cs-dsdo-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_H2-cs-dsdo-Bonn-Norm-MEC
awk '$1=="H3" && $2=="cs-dsdo-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_H3-cs-dsdo-Bonn-Norm-MEC
awk '$1=="S1" && $2=="cs-dsdo-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_S1-cs-dsdo-Bonn-Norm-MEC
awk '$1=="S2" && $2=="cs-dsdo-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_S2-cs-dsdo-Bonn-Norm-MEC
awk '$1=="S3" && $2=="cs-dsdo-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_S3-cs-dsdo-Bonn-Norm-MEC
awk '$1=="H1" && $2=="cs-dsdo-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H1-cs-dsdo-Bonn-Norm-MEC-IC
awk '$1=="H2" && $2=="cs-dsdo-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H2-cs-dsdo-Bonn-Norm-MEC-IC
awk '$1=="H3" && $2=="cs-dsdo-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H3-cs-dsdo-Bonn-Norm-MEC-IC
awk '$1=="S1" && $2=="cs-dsdo-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S1-cs-dsdo-Bonn-Norm-MEC-IC
awk '$1=="S2" && $2=="cs-dsdo-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S2-cs-dsdo-Bonn-Norm-MEC-IC
awk '$1=="S3" && $2=="cs-dsdo-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S3-cs-dsdo-Bonn-Norm-MEC-IC
awk '$1=="H1" && $2=="cs-dsdo-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H1-cs-dsdo-Bonn-Norm-MEC-IC-Rel
awk '$1=="H2" && $2=="cs-dsdo-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H2-cs-dsdo-Bonn-Norm-MEC-IC-Rel
awk '$1=="H3" && $2=="cs-dsdo-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H3-cs-dsdo-Bonn-Norm-MEC-IC-Rel
awk '$1=="S1" && $2=="cs-dsdo-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S1-cs-dsdo-Bonn-Norm-MEC-IC-Rel
awk '$1=="S2" && $2=="cs-dsdo-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S2-cs-dsdo-Bonn-Norm-MEC-IC-Rel
awk '$1=="S3" && $2=="cs-dsdo-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S3-cs-dsdo-Bonn-Norm-MEC-IC-Rel
awk '$1=="H1" && $2=="cs-dsdo-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_H1-cs-dsdo-Bonn-Norm-Rel
awk '$1=="H2" && $2=="cs-dsdo-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_H2-cs-dsdo-Bonn-Norm-Rel
awk '$1=="H3" && $2=="cs-dsdo-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_H3-cs-dsdo-Bonn-Norm-Rel
awk '$1=="S1" && $2=="cs-dsdo-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_S1-cs-dsdo-Bonn-Norm-Rel
awk '$1=="S2" && $2=="cs-dsdo-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_S2-cs-dsdo-Bonn-Norm-Rel
awk '$1=="S3" && $2=="cs-dsdo-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_S3-cs-dsdo-Bonn-Norm-Rel
awk '$1=="H1" && $2=="cs-dsdo-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_H1-cs-dsdo-Bonn-PWBA-NR
awk '$1=="H2" && $2=="cs-dsdo-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_H2-cs-dsdo-Bonn-PWBA-NR
awk '$1=="H3" && $2=="cs-dsdo-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_H3-cs-dsdo-Bonn-PWBA-NR
awk '$1=="S1" && $2=="cs-dsdo-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_S1-cs-dsdo-Bonn-PWBA-NR
awk '$1=="S2" && $2=="cs-dsdo-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_S2-cs-dsdo-Bonn-PWBA-NR
awk '$1=="S3" && $2=="cs-dsdo-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_S3-cs-dsdo-Bonn-PWBA-NR
awk '$1=="H1" && $2=="cs-dsdo-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_H1-cs-dsdo-Bonn-PWBA-RC
awk '$1=="H2" && $2=="cs-dsdo-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_H2-cs-dsdo-Bonn-PWBA-RC
awk '$1=="H3" && $2=="cs-dsdo-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_H3-cs-dsdo-Bonn-PWBA-RC
awk '$1=="S1" && $2=="cs-dsdo-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_S1-cs-dsdo-Bonn-PWBA-RC
awk '$1=="S2" && $2=="cs-dsdo-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_S2-cs-dsdo-Bonn-PWBA-RC
awk '$1=="S3" && $2=="cs-dsdo-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_S3-cs-dsdo-Bonn-PWBA-RC


awk '$1=="H1" && $2=="cs-dsdol-AV18-Norm" {print $3,$4}' $file0 >> temp_H1-cs-dsdol-AV18-Norm
awk '$1=="H2" && $2=="cs-dsdol-AV18-Norm" {print $3,$4}' $file0 >> temp_H2-cs-dsdol-AV18-Norm
awk '$1=="H3" && $2=="cs-dsdol-AV18-Norm" {print $3,$4}' $file0 >> temp_H3-cs-dsdol-AV18-Norm
awk '$1=="S1" && $2=="cs-dsdol-AV18-Norm" {print $3,$4}' $file0 >> temp_S1-cs-dsdol-AV18-Norm
awk '$1=="S2" && $2=="cs-dsdol-AV18-Norm" {print $3,$4}' $file0 >> temp_S2-cs-dsdol-AV18-Norm
awk '$1=="S3" && $2=="cs-dsdol-AV18-Norm" {print $3,$4}' $file0 >> temp_S3-cs-dsdol-AV18-Norm
awk '$1=="H1" && $2=="cs-dsdol-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_H1-cs-dsdol-AV18-Norm-MEC
awk '$1=="H2" && $2=="cs-dsdol-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_H2-cs-dsdol-AV18-Norm-MEC
awk '$1=="H3" && $2=="cs-dsdol-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_H3-cs-dsdol-AV18-Norm-MEC
awk '$1=="S1" && $2=="cs-dsdol-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_S1-cs-dsdol-AV18-Norm-MEC
awk '$1=="S2" && $2=="cs-dsdol-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_S2-cs-dsdol-AV18-Norm-MEC
awk '$1=="S3" && $2=="cs-dsdol-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_S3-cs-dsdol-AV18-Norm-MEC
awk '$1=="H1" && $2=="cs-dsdol-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H1-cs-dsdol-AV18-Norm-MEC-IC
awk '$1=="H2" && $2=="cs-dsdol-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H2-cs-dsdol-AV18-Norm-MEC-IC
awk '$1=="H3" && $2=="cs-dsdol-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H3-cs-dsdol-AV18-Norm-MEC-IC
awk '$1=="S1" && $2=="cs-dsdol-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S1-cs-dsdol-AV18-Norm-MEC-IC
awk '$1=="S2" && $2=="cs-dsdol-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S2-cs-dsdol-AV18-Norm-MEC-IC
awk '$1=="S3" && $2=="cs-dsdol-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S3-cs-dsdol-AV18-Norm-MEC-IC
awk '$1=="H1" && $2=="cs-dsdol-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H1-cs-dsdol-AV18-Norm-MEC-IC-Rel
awk '$1=="H2" && $2=="cs-dsdol-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H2-cs-dsdol-AV18-Norm-MEC-IC-Rel
awk '$1=="H3" && $2=="cs-dsdol-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H3-cs-dsdol-AV18-Norm-MEC-IC-Rel
awk '$1=="S1" && $2=="cs-dsdol-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S1-cs-dsdol-AV18-Norm-MEC-IC-Rel
awk '$1=="S2" && $2=="cs-dsdol-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S2-cs-dsdol-AV18-Norm-MEC-IC-Rel
awk '$1=="S3" && $2=="cs-dsdol-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S3-cs-dsdol-AV18-Norm-MEC-IC-Rel
awk '$1=="H1" && $2=="cs-dsdol-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_H1-cs-dsdol-AV18-Norm-Rel
awk '$1=="H2" && $2=="cs-dsdol-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_H2-cs-dsdol-AV18-Norm-Rel
awk '$1=="H3" && $2=="cs-dsdol-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_H3-cs-dsdol-AV18-Norm-Rel
awk '$1=="S1" && $2=="cs-dsdol-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_S1-cs-dsdol-AV18-Norm-Rel
awk '$1=="S2" && $2=="cs-dsdol-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_S2-cs-dsdol-AV18-Norm-Rel
awk '$1=="S3" && $2=="cs-dsdol-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_S3-cs-dsdol-AV18-Norm-Rel
awk '$1=="H1" && $2=="cs-dsdol-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_H1-cs-dsdol-AV18-PWBA-NR
awk '$1=="H2" && $2=="cs-dsdol-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_H2-cs-dsdol-AV18-PWBA-NR
awk '$1=="H3" && $2=="cs-dsdol-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_H3-cs-dsdol-AV18-PWBA-NR
awk '$1=="S1" && $2=="cs-dsdol-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_S1-cs-dsdol-AV18-PWBA-NR
awk '$1=="S2" && $2=="cs-dsdol-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_S2-cs-dsdol-AV18-PWBA-NR
awk '$1=="S3" && $2=="cs-dsdol-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_S3-cs-dsdol-AV18-PWBA-NR
awk '$1=="H1" && $2=="cs-dsdol-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_H1-cs-dsdol-AV18-PWBA-RC
awk '$1=="H2" && $2=="cs-dsdol-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_H2-cs-dsdol-AV18-PWBA-RC
awk '$1=="H3" && $2=="cs-dsdol-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_H3-cs-dsdol-AV18-PWBA-RC
awk '$1=="S1" && $2=="cs-dsdol-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_S1-cs-dsdol-AV18-PWBA-RC
awk '$1=="S2" && $2=="cs-dsdol-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_S2-cs-dsdol-AV18-PWBA-RC
awk '$1=="S3" && $2=="cs-dsdol-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_S3-cs-dsdol-AV18-PWBA-RC
awk '$1=="H1" && $2=="cs-dsdol-Bonn-Norm" {print $3,$4}' $file0 >> temp_H1-cs-dsdol-Bonn-Norm
awk '$1=="H2" && $2=="cs-dsdol-Bonn-Norm" {print $3,$4}' $file0 >> temp_H2-cs-dsdol-Bonn-Norm
awk '$1=="H3" && $2=="cs-dsdol-Bonn-Norm" {print $3,$4}' $file0 >> temp_H3-cs-dsdol-Bonn-Norm
awk '$1=="S1" && $2=="cs-dsdol-Bonn-Norm" {print $3,$4}' $file0 >> temp_S1-cs-dsdol-Bonn-Norm
awk '$1=="S2" && $2=="cs-dsdol-Bonn-Norm" {print $3,$4}' $file0 >> temp_S2-cs-dsdol-Bonn-Norm
awk '$1=="S3" && $2=="cs-dsdol-Bonn-Norm" {print $3,$4}' $file0 >> temp_S3-cs-dsdol-Bonn-Norm
awk '$1=="H1" && $2=="cs-dsdol-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_H1-cs-dsdol-Bonn-Norm-MEC
awk '$1=="H2" && $2=="cs-dsdol-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_H2-cs-dsdol-Bonn-Norm-MEC
awk '$1=="H3" && $2=="cs-dsdol-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_H3-cs-dsdol-Bonn-Norm-MEC
awk '$1=="S1" && $2=="cs-dsdol-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_S1-cs-dsdol-Bonn-Norm-MEC
awk '$1=="S2" && $2=="cs-dsdol-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_S2-cs-dsdol-Bonn-Norm-MEC
awk '$1=="S3" && $2=="cs-dsdol-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_S3-cs-dsdol-Bonn-Norm-MEC
awk '$1=="H1" && $2=="cs-dsdol-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H1-cs-dsdol-Bonn-Norm-MEC-IC
awk '$1=="H2" && $2=="cs-dsdol-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H2-cs-dsdol-Bonn-Norm-MEC-IC
awk '$1=="H3" && $2=="cs-dsdol-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H3-cs-dsdol-Bonn-Norm-MEC-IC
awk '$1=="S1" && $2=="cs-dsdol-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S1-cs-dsdol-Bonn-Norm-MEC-IC
awk '$1=="S2" && $2=="cs-dsdol-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S2-cs-dsdol-Bonn-Norm-MEC-IC
awk '$1=="S3" && $2=="cs-dsdol-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S3-cs-dsdol-Bonn-Norm-MEC-IC
awk '$1=="H1" && $2=="cs-dsdol-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H1-cs-dsdol-Bonn-Norm-MEC-IC-Rel
awk '$1=="H2" && $2=="cs-dsdol-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H2-cs-dsdol-Bonn-Norm-MEC-IC-Rel
awk '$1=="H3" && $2=="cs-dsdol-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H3-cs-dsdol-Bonn-Norm-MEC-IC-Rel
awk '$1=="S1" && $2=="cs-dsdol-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S1-cs-dsdol-Bonn-Norm-MEC-IC-Rel
awk '$1=="S2" && $2=="cs-dsdol-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S2-cs-dsdol-Bonn-Norm-MEC-IC-Rel
awk '$1=="S3" && $2=="cs-dsdol-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S3-cs-dsdol-Bonn-Norm-MEC-IC-Rel
awk '$1=="H1" && $2=="cs-dsdol-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_H1-cs-dsdol-Bonn-Norm-Rel
awk '$1=="H2" && $2=="cs-dsdol-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_H2-cs-dsdol-Bonn-Norm-Rel
awk '$1=="H3" && $2=="cs-dsdol-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_H3-cs-dsdol-Bonn-Norm-Rel
awk '$1=="S1" && $2=="cs-dsdol-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_S1-cs-dsdol-Bonn-Norm-Rel
awk '$1=="S2" && $2=="cs-dsdol-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_S2-cs-dsdol-Bonn-Norm-Rel
awk '$1=="S3" && $2=="cs-dsdol-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_S3-cs-dsdol-Bonn-Norm-Rel
awk '$1=="H1" && $2=="cs-dsdol-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_H1-cs-dsdol-Bonn-PWBA-NR
awk '$1=="H2" && $2=="cs-dsdol-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_H2-cs-dsdol-Bonn-PWBA-NR
awk '$1=="H3" && $2=="cs-dsdol-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_H3-cs-dsdol-Bonn-PWBA-NR
awk '$1=="S1" && $2=="cs-dsdol-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_S1-cs-dsdol-Bonn-PWBA-NR
awk '$1=="S2" && $2=="cs-dsdol-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_S2-cs-dsdol-Bonn-PWBA-NR
awk '$1=="S3" && $2=="cs-dsdol-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_S3-cs-dsdol-Bonn-PWBA-NR
awk '$1=="H1" && $2=="cs-dsdol-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_H1-cs-dsdol-Bonn-PWBA-RC
awk '$1=="H2" && $2=="cs-dsdol-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_H2-cs-dsdol-Bonn-PWBA-RC
awk '$1=="H3" && $2=="cs-dsdol-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_H3-cs-dsdol-Bonn-PWBA-RC
awk '$1=="S1" && $2=="cs-dsdol-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_S1-cs-dsdol-Bonn-PWBA-RC
awk '$1=="S2" && $2=="cs-dsdol-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_S2-cs-dsdol-Bonn-PWBA-RC
awk '$1=="S3" && $2=="cs-dsdol-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_S3-cs-dsdol-Bonn-PWBA-RC


awk '$1=="H1" && $2=="cs-dsdot-AV18-Norm" {print $3,$4}' $file0 >> temp_H1-cs-dsdot-AV18-Norm
awk '$1=="H2" && $2=="cs-dsdot-AV18-Norm" {print $3,$4}' $file0 >> temp_H2-cs-dsdot-AV18-Norm
awk '$1=="H3" && $2=="cs-dsdot-AV18-Norm" {print $3,$4}' $file0 >> temp_H3-cs-dsdot-AV18-Norm
awk '$1=="S1" && $2=="cs-dsdot-AV18-Norm" {print $3,$4}' $file0 >> temp_S1-cs-dsdot-AV18-Norm
awk '$1=="S2" && $2=="cs-dsdot-AV18-Norm" {print $3,$4}' $file0 >> temp_S2-cs-dsdot-AV18-Norm
awk '$1=="S3" && $2=="cs-dsdot-AV18-Norm" {print $3,$4}' $file0 >> temp_S3-cs-dsdot-AV18-Norm
awk '$1=="H1" && $2=="cs-dsdot-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_H1-cs-dsdot-AV18-Norm-MEC
awk '$1=="H2" && $2=="cs-dsdot-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_H2-cs-dsdot-AV18-Norm-MEC
awk '$1=="H3" && $2=="cs-dsdot-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_H3-cs-dsdot-AV18-Norm-MEC
awk '$1=="S1" && $2=="cs-dsdot-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_S1-cs-dsdot-AV18-Norm-MEC
awk '$1=="S2" && $2=="cs-dsdot-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_S2-cs-dsdot-AV18-Norm-MEC
awk '$1=="S3" && $2=="cs-dsdot-AV18-Norm-MEC" {print $3,$4}' $file0 >> temp_S3-cs-dsdot-AV18-Norm-MEC
awk '$1=="H1" && $2=="cs-dsdot-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H1-cs-dsdot-AV18-Norm-MEC-IC
awk '$1=="H2" && $2=="cs-dsdot-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H2-cs-dsdot-AV18-Norm-MEC-IC
awk '$1=="H3" && $2=="cs-dsdot-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H3-cs-dsdot-AV18-Norm-MEC-IC
awk '$1=="S1" && $2=="cs-dsdot-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S1-cs-dsdot-AV18-Norm-MEC-IC
awk '$1=="S2" && $2=="cs-dsdot-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S2-cs-dsdot-AV18-Norm-MEC-IC
awk '$1=="S3" && $2=="cs-dsdot-AV18-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S3-cs-dsdot-AV18-Norm-MEC-IC
awk '$1=="H1" && $2=="cs-dsdot-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H1-cs-dsdot-AV18-Norm-MEC-IC-Rel
awk '$1=="H2" && $2=="cs-dsdot-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H2-cs-dsdot-AV18-Norm-MEC-IC-Rel
awk '$1=="H3" && $2=="cs-dsdot-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H3-cs-dsdot-AV18-Norm-MEC-IC-Rel
awk '$1=="S1" && $2=="cs-dsdot-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S1-cs-dsdot-AV18-Norm-MEC-IC-Rel
awk '$1=="S2" && $2=="cs-dsdot-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S2-cs-dsdot-AV18-Norm-MEC-IC-Rel
awk '$1=="S3" && $2=="cs-dsdot-AV18-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S3-cs-dsdot-AV18-Norm-MEC-IC-Rel
awk '$1=="H1" && $2=="cs-dsdot-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_H1-cs-dsdot-AV18-Norm-Rel
awk '$1=="H2" && $2=="cs-dsdot-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_H2-cs-dsdot-AV18-Norm-Rel
awk '$1=="H3" && $2=="cs-dsdot-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_H3-cs-dsdot-AV18-Norm-Rel
awk '$1=="S1" && $2=="cs-dsdot-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_S1-cs-dsdot-AV18-Norm-Rel
awk '$1=="S2" && $2=="cs-dsdot-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_S2-cs-dsdot-AV18-Norm-Rel
awk '$1=="S3" && $2=="cs-dsdot-AV18-Norm-Rel" {print $3,$4}' $file0 >> temp_S3-cs-dsdot-AV18-Norm-Rel
awk '$1=="H1" && $2=="cs-dsdot-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_H1-cs-dsdot-AV18-PWBA-NR
awk '$1=="H2" && $2=="cs-dsdot-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_H2-cs-dsdot-AV18-PWBA-NR
awk '$1=="H3" && $2=="cs-dsdot-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_H3-cs-dsdot-AV18-PWBA-NR
awk '$1=="S1" && $2=="cs-dsdot-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_S1-cs-dsdot-AV18-PWBA-NR
awk '$1=="S2" && $2=="cs-dsdot-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_S2-cs-dsdot-AV18-PWBA-NR
awk '$1=="S3" && $2=="cs-dsdot-AV18-PWBA-NR" {print $3,$4}' $file0 >> temp_S3-cs-dsdot-AV18-PWBA-NR
awk '$1=="H1" && $2=="cs-dsdot-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_H1-cs-dsdot-AV18-PWBA-RC
awk '$1=="H2" && $2=="cs-dsdot-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_H2-cs-dsdot-AV18-PWBA-RC
awk '$1=="H3" && $2=="cs-dsdot-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_H3-cs-dsdot-AV18-PWBA-RC
awk '$1=="S1" && $2=="cs-dsdot-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_S1-cs-dsdot-AV18-PWBA-RC
awk '$1=="S2" && $2=="cs-dsdot-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_S2-cs-dsdot-AV18-PWBA-RC
awk '$1=="S3" && $2=="cs-dsdot-AV18-PWBA-RC" {print $3,$4}' $file0 >> temp_S3-cs-dsdot-AV18-PWBA-RC
awk '$1=="H1" && $2=="cs-dsdot-Bonn-Norm" {print $3,$4}' $file0 >> temp_H1-cs-dsdot-Bonn-Norm
awk '$1=="H2" && $2=="cs-dsdot-Bonn-Norm" {print $3,$4}' $file0 >> temp_H2-cs-dsdot-Bonn-Norm
awk '$1=="H3" && $2=="cs-dsdot-Bonn-Norm" {print $3,$4}' $file0 >> temp_H3-cs-dsdot-Bonn-Norm
awk '$1=="S1" && $2=="cs-dsdot-Bonn-Norm" {print $3,$4}' $file0 >> temp_S1-cs-dsdot-Bonn-Norm
awk '$1=="S2" && $2=="cs-dsdot-Bonn-Norm" {print $3,$4}' $file0 >> temp_S2-cs-dsdot-Bonn-Norm
awk '$1=="S3" && $2=="cs-dsdot-Bonn-Norm" {print $3,$4}' $file0 >> temp_S3-cs-dsdot-Bonn-Norm
awk '$1=="H1" && $2=="cs-dsdot-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_H1-cs-dsdot-Bonn-Norm-MEC
awk '$1=="H2" && $2=="cs-dsdot-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_H2-cs-dsdot-Bonn-Norm-MEC
awk '$1=="H3" && $2=="cs-dsdot-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_H3-cs-dsdot-Bonn-Norm-MEC
awk '$1=="S1" && $2=="cs-dsdot-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_S1-cs-dsdot-Bonn-Norm-MEC
awk '$1=="S2" && $2=="cs-dsdot-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_S2-cs-dsdot-Bonn-Norm-MEC
awk '$1=="S3" && $2=="cs-dsdot-Bonn-Norm-MEC" {print $3,$4}' $file0 >> temp_S3-cs-dsdot-Bonn-Norm-MEC
awk '$1=="H1" && $2=="cs-dsdot-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H1-cs-dsdot-Bonn-Norm-MEC-IC
awk '$1=="H2" && $2=="cs-dsdot-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H2-cs-dsdot-Bonn-Norm-MEC-IC
awk '$1=="H3" && $2=="cs-dsdot-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_H3-cs-dsdot-Bonn-Norm-MEC-IC
awk '$1=="S1" && $2=="cs-dsdot-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S1-cs-dsdot-Bonn-Norm-MEC-IC
awk '$1=="S2" && $2=="cs-dsdot-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S2-cs-dsdot-Bonn-Norm-MEC-IC
awk '$1=="S3" && $2=="cs-dsdot-Bonn-Norm-MEC-IC" {print $3,$4}' $file0 >> temp_S3-cs-dsdot-Bonn-Norm-MEC-IC
awk '$1=="H1" && $2=="cs-dsdot-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H1-cs-dsdot-Bonn-Norm-MEC-IC-Rel
awk '$1=="H2" && $2=="cs-dsdot-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H2-cs-dsdot-Bonn-Norm-MEC-IC-Rel
awk '$1=="H3" && $2=="cs-dsdot-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_H3-cs-dsdot-Bonn-Norm-MEC-IC-Rel
awk '$1=="S1" && $2=="cs-dsdot-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S1-cs-dsdot-Bonn-Norm-MEC-IC-Rel
awk '$1=="S2" && $2=="cs-dsdot-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S2-cs-dsdot-Bonn-Norm-MEC-IC-Rel
awk '$1=="S3" && $2=="cs-dsdot-Bonn-Norm-MEC-IC-Rel" {print $3,$4}' $file0 >> temp_S3-cs-dsdot-Bonn-Norm-MEC-IC-Rel
awk '$1=="H1" && $2=="cs-dsdot-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_H1-cs-dsdot-Bonn-Norm-Rel
awk '$1=="H2" && $2=="cs-dsdot-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_H2-cs-dsdot-Bonn-Norm-Rel
awk '$1=="H3" && $2=="cs-dsdot-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_H3-cs-dsdot-Bonn-Norm-Rel
awk '$1=="S1" && $2=="cs-dsdot-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_S1-cs-dsdot-Bonn-Norm-Rel
awk '$1=="S2" && $2=="cs-dsdot-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_S2-cs-dsdot-Bonn-Norm-Rel
awk '$1=="S3" && $2=="cs-dsdot-Bonn-Norm-Rel" {print $3,$4}' $file0 >> temp_S3-cs-dsdot-Bonn-Norm-Rel
awk '$1=="H1" && $2=="cs-dsdot-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_H1-cs-dsdot-Bonn-PWBA-NR
awk '$1=="H2" && $2=="cs-dsdot-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_H2-cs-dsdot-Bonn-PWBA-NR
awk '$1=="H3" && $2=="cs-dsdot-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_H3-cs-dsdot-Bonn-PWBA-NR
awk '$1=="S1" && $2=="cs-dsdot-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_S1-cs-dsdot-Bonn-PWBA-NR
awk '$1=="S2" && $2=="cs-dsdot-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_S2-cs-dsdot-Bonn-PWBA-NR
awk '$1=="S3" && $2=="cs-dsdot-Bonn-PWBA-NR" {print $3,$4}' $file0 >> temp_S3-cs-dsdot-Bonn-PWBA-NR
awk '$1=="H1" && $2=="cs-dsdot-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_H1-cs-dsdot-Bonn-PWBA-RC
awk '$1=="H2" && $2=="cs-dsdot-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_H2-cs-dsdot-Bonn-PWBA-RC
awk '$1=="H3" && $2=="cs-dsdot-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_H3-cs-dsdot-Bonn-PWBA-RC
awk '$1=="S1" && $2=="cs-dsdot-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_S1-cs-dsdot-Bonn-PWBA-RC
awk '$1=="S2" && $2=="cs-dsdot-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_S2-cs-dsdot-Bonn-PWBA-RC
awk '$1=="S3" && $2=="cs-dsdot-Bonn-PWBA-RC" {print $3,$4}' $file0 >> temp_S3-cs-dsdot-Bonn-PWBA-RC



awk '$6<10 && $6>-10 && $1=="S1" && $2=="AV18-Norm" {print $3,$6}' $file1 >> temp_comp_S1-AV18-Norm
awk '$6<10 && $6>-10 && $1=="S1" && $2=="AV18-Norm-MEC" {print $3,$6}' $file1 >> temp_comp_S1-AV18-Norm-MEC
awk '$6<10 && $6>-10 && $1=="S1" && $2=="AV18-Norm-MEC-IC" {print $3,$6}' $file1 >> temp_comp_S1-AV18-Norm-MEC-IC
awk '$6<10 && $6>-10 && $1=="S1" && $2=="AV18-Norm-MEC-IC-Rel" {print $3,$6}' $file1 >> temp_comp_S1-AV18-Norm-MEC-IC-Rel
awk '$6<10 && $6>-10 && $1=="S1" && $2=="AV18-Norm-Rel" {print $3,$6}' $file1 >> temp_comp_S1-AV18-Norm-Rel
awk '$6<10 && $6>-10 && $1=="S1" && $2=="AV18-PWBA-NR" {print $3,$6}' $file1 >> temp_comp_S1-AV18-PWBA-NR
awk '$6<10 && $6>-10 && $1=="S1" && $2=="AV18-PWBA-RC" {print $3,$6}' $file1 >> temp_comp_S1-AV18-PWBA-RC
awk '$6<10 && $6>-10 && $1=="S1" && $2=="Bonn-Norm" {print $3,$6}' $file1 >> temp_comp_S1-Bonn-Norm
awk '$6<10 && $6>-10 && $1=="S1" && $2=="Bonn-Norm-MEC" {print $3,$6}' $file1 >> temp_comp_S1-Bonn-Norm-MEC
awk '$6<10 && $6>-10 && $1=="S1" && $2=="Bonn-Norm-MEC-IC" {print $3,$6}' $file1 >> temp_comp_S1-Bonn-Norm-MEC-IC
awk '$6<10 && $6>-10 && $1=="S1" && $2=="Bonn-Norm-MEC-IC-Rel" {print $3,$6}' $file1 >> temp_comp_S1-Bonn-Norm-MEC-IC-Rel
awk '$6<10 && $6>-10 && $1=="S1" && $2=="Bonn-Norm-Rel" {print $3,$6}' $file1 >> temp_comp_S1-Bonn-Norm-Rel
awk '$6<10 && $6>-10 && $1=="S1" && $2=="Bonn-PWBA-NR" {print $3,$6}' $file1 >> temp_comp_S1-Bonn-PWBA-NR
awk '$6<10 && $6>-10 && $1=="S1" && $2=="Bonn-PWBA-RC" {print $3,$6}' $file1 >> temp_comp_S1-Bonn-PWBA-RC
awk '$6<10 && $6>-10 && $1=="S1" && $2=="LC-AV18" {print $3,$6}' $file1 >> temp_comp_S1-LC-AV18
awk '$6<10 && $6>-10 && $1=="S1" && $2=="LC-CDBonn" {print $3,$6}' $file1 >> temp_comp_S1-LC-CDBonn
awk '$6<10 && $6>-10 && $1=="S1" && $2=="VN-AV18" {print $3,$6}' $file1 >> temp_comp_S1-VN-AV18
awk '$6<10 && $6>-10 && $1=="S1" && $2=="VN-CDBonn" {print $3,$6}' $file1 >> temp_comp_S1-VN-CDBonn
awk '$6<10 && $6>-10 && $1=="S1" && $2=="PW-AV18" {print $3,$6}' $file1 >> temp_comp_S1-PW-AV18
awk '$6<10 && $6>-10 && $1=="S1" && $2=="PW-CDBonn" {print $3,$6}' $file1 >> temp_comp_S1-PW-CDBonn
awk '$6<10 && $6>-10 && $1=="S1" && $2=="PW+FSIOff-AV18" {print $3,$6}' $file1 >> temp_comp_S1-PW-FSIOff-AV18
awk '$6<10 && $6>-10 && $1=="S1" && $2=="PW+FSIOff-CDBonn" {print $3,$6}' $file1 >> temp_comp_S1-PW-FSIOff-CDBonn
awk '$6<10 && $6>-10 && $1=="S1" && $2=="PW+FSIOn-AV18" {print $3,$6}' $file1 >> temp_comp_S1-PW-FSIOn-AV18
awk '$6<10 && $6>-10 && $1=="S1" && $2=="PW+FSIOn-CDBonn" {print $3,$6}' $file1 >> temp_comp_S1-PW-FSIOn-CDBonn
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVd-AV18-Norm" {print $3,$6}' $file1 >> temp_comp_S1-alphaVd-AV18-Norm
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVd-AV18-Norm-MEC" {print $3,$6}' $file1 >> temp_comp_S1-alphaVd-AV18-Norm-MEC
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVd-AV18-Norm-MEC-IC" {print $3,$6}' $file1 >> temp_comp_S1-alphaVd-AV18-Norm-MEC-IC
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVd-AV18-Norm-MEC-IC-Rel" {print $3,$6}' $file1 >> temp_comp_S1-alphaVd-AV18-Norm-MEC-IC-Rel
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVd-AV18-Norm-Rel" {print $3,$6}' $file1 >> temp_comp_S1-alphaVd-AV18-Norm-Rel
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVd-AV18-PWBA-NR" {print $3,$6}' $file1 >> temp_comp_S1-alphaVd-AV18-PWBA-NR
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVd-AV18-PWBA-RC" {print $3,$6}' $file1 >> temp_comp_S1-alphaVd-AV18-PWBA-RC
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVd-Bonn-Norm" {print $3,$6}' $file1 >> temp_comp_S1-alphaVd-Bonn-Norm
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVd-Bonn-Norm-MEC" {print $3,$6}' $file1 >> temp_comp_S1-alphaVd-Bonn-Norm-MEC
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVd-Bonn-Norm-MEC-IC" {print $3,$6}' $file1 >> temp_comp_S1-alphaVd-Bonn-Norm-MEC-IC
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVd-Bonn-Norm-MEC-IC-Rel" {print $3,$6}' $file1 >> temp_comp_S1-alphaVd-Bonn-Norm-MEC-IC-Rel
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVd-Bonn-Norm-Rel" {print $3,$6}' $file1 >> temp_comp_S1-alphaVd-Bonn-Norm-Rel
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVd-Bonn-PWBA-NR" {print $3,$6}' $file1 >> temp_comp_S1-alphaVd-Bonn-PWBA-NR
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVd-Bonn-PWBA-RC" {print $3,$6}' $file1 >> temp_comp_S1-alphaVd-Bonn-PWBA-RC
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVed-AV18-Norm" {print $3,$6}' $file1 >> temp_comp_S1-alphaVed-AV18-Norm
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVed-AV18-Norm-MEC" {print $3,$6}' $file1 >> temp_comp_S1-alphaVed-AV18-Norm-MEC
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVed-AV18-Norm-MEC-IC" {print $3,$6}' $file1 >> temp_comp_S1-alphaVed-AV18-Norm-MEC-IC
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVed-AV18-Norm-MEC-IC-Rel" {print $3,$6}' $file1 >> temp_comp_S1-alphaVed-AV18-Norm-MEC-IC-Rel
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVed-AV18-Norm-Rel" {print $3,$6}' $file1 >> temp_comp_S1-alphaVed-AV18-Norm-Rel
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVed-AV18-PWBA-NR" {print $3,$6}' $file1 >> temp_comp_S1-alphaVed-AV18-PWBA-NR
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVed-AV18-PWBA-RC" {print $3,$6}' $file1 >> temp_comp_S1-alphaVed-AV18-PWBA-RC
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVed-Bonn-Norm" {print $3,$6}' $file1 >> temp_comp_S1-alphaVed-Bonn-Norm
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVed-Bonn-Norm-MEC" {print $3,$6}' $file1 >> temp_comp_S1-alphaVed-Bonn-Norm-MEC
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVed-Bonn-Norm-MEC-IC" {print $3,$6}' $file1 >> temp_comp_S1-alphaVed-Bonn-Norm-MEC-IC
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVed-Bonn-Norm-MEC-IC-Rel" {print $3,$6}' $file1 >> temp_comp_S1-alphaVed-Bonn-Norm-MEC-IC-Rel
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVed-Bonn-Norm-Rel" {print $3,$6}' $file1 >> temp_comp_S1-alphaVed-Bonn-Norm-Rel
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVed-Bonn-PWBA-NR" {print $3,$6}' $file1 >> temp_comp_S1-alphaVed-Bonn-PWBA-NR
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaVed-Bonn-PWBA-RC" {print $3,$6}' $file1 >> temp_comp_S1-alphaVed-Bonn-PWBA-RC
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaTed-AV18-Norm" {print $3,$6}' $file1 >> temp_comp_S1-alphaTed-AV18-Norm
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaTed-AV18-Norm-MEC" {print $3,$6}' $file1 >> temp_comp_S1-alphaTed-AV18-Norm-MEC
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaTed-AV18-Norm-MEC-IC" {print $3,$6}' $file1 >> temp_comp_S1-alphaTed-AV18-Norm-MEC-IC
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaTed-AV18-Norm-MEC-IC-Rel" {print $3,$6}' $file1 >> temp_comp_S1-alphaTed-AV18-Norm-MEC-IC-Rel
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaTed-AV18-Norm-Rel" {print $3,$6}' $file1 >> temp_comp_S1-alphaTed-AV18-Norm-Rel
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaTed-AV18-PWBA-NR" {print $3,$6}' $file1 >> temp_comp_S1-alphaTed-AV18-PWBA-NR
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaTed-AV18-PWBA-RC" {print $3,$6}' $file1 >> temp_comp_S1-alphaTed-AV18-PWBA-RC
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaTed-Bonn-Norm" {print $3,$6}' $file1 >> temp_comp_S1-alphaTed-Bonn-Norm
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaTed-Bonn-Norm-MEC" {print $3,$6}' $file1 >> temp_comp_S1-alphaTed-Bonn-Norm-MEC
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaTed-Bonn-Norm-MEC-IC" {print $3,$6}' $file1 >> temp_comp_S1-alphaTed-Bonn-Norm-MEC-IC
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaTed-Bonn-Norm-MEC-IC-Rel" {print $3,$6}' $file1 >> temp_comp_S1-alphaTed-Bonn-Norm-MEC-IC-Rel
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaTed-Bonn-Norm-Rel" {print $3,$6}' $file1 >> temp_comp_S1-alphaTed-Bonn-Norm-Rel
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaTed-Bonn-PWBA-NR" {print $3,$6}' $file1 >> temp_comp_S1-alphaTed-Bonn-PWBA-NR
awk '$6<10 && $6>-10 && $1=="S1" && $2=="alphaTed-Bonn-PWBA-RC" {print $3,$6}' $file1 >> temp_comp_S1-alphaTed-Bonn-PWBA-RC






#gracebat -hdevice PNG -printfile Azz_calcs.png \
xmgrace \
		-settype xy			-block	temp_H1-LC-AV18					-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H1-LC-CDBonn				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H1-VN-AV18					-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H1-VN-CDBonn				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H1-PW-AV18					-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H1-PW-CDBonn				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H1-PW-FSIOn-AV18			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H1-PW-FSIOn-CDBonn			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H1-PW-FSIOff-AV18			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H1-PW-FSIOff-CDBonn		-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H1-AV18-Norm				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H1-Bonn-Norm				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H1-AV18-Norm-MEC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H1-Bonn-Norm-MEC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H1-AV18-Norm-MEC-IC		-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H1-Bonn-Norm-MEC-IC		-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H1-AV18-Norm-MEC-IC-Rel	-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H1-Bonn-Norm-MEC-IC-Rel	-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H1-AV18-Norm-Rel			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H1-Bonn-Norm-Rel			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H1-AV18-PWBA-NR			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H1-Bonn-PWBA-NR			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H1-AV18-PWBA-RC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H1-Bonn-PWBA-RC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVd-AV18-Norm				-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVd-Bonn-Norm				-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVd-AV18-Norm-MEC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVd-Bonn-Norm-MEC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVd-AV18-Norm-MEC-IC		-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVd-Bonn-Norm-MEC-IC		-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVd-AV18-Norm-MEC-IC-Rel	-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVd-Bonn-Norm-MEC-IC-Rel	-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVd-AV18-Norm-Rel			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVd-Bonn-Norm-Rel			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVd-AV18-PWBA-NR			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVd-Bonn-PWBA-NR			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVd-AV18-PWBA-RC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVd-Bonn-PWBA-RC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVed-AV18-Norm				-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVed-Bonn-Norm				-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVed-AV18-Norm-MEC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVed-Bonn-Norm-MEC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVed-AV18-Norm-MEC-IC		-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVed-Bonn-Norm-MEC-IC		-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVed-AV18-Norm-MEC-IC-Rel	-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVed-Bonn-Norm-MEC-IC-Rel	-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVed-AV18-Norm-Rel			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVed-Bonn-Norm-Rel			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVed-AV18-PWBA-NR			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVed-Bonn-PWBA-NR			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVed-AV18-PWBA-RC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaVed-Bonn-PWBA-RC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaTed-AV18-Norm				-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaTed-Bonn-Norm				-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaTed-AV18-Norm-MEC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaTed-Bonn-Norm-MEC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaTed-AV18-Norm-MEC-IC		-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaTed-Bonn-Norm-MEC-IC		-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaTed-AV18-Norm-MEC-IC-Rel	-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaTed-Bonn-Norm-MEC-IC-Rel	-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaTed-AV18-Norm-Rel			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaTed-Bonn-Norm-Rel			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaTed-AV18-PWBA-NR			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaTed-Bonn-PWBA-NR			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaTed-AV18-PWBA-RC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H1-alphaTed-Bonn-PWBA-RC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdo-AV18-Norm				-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdo-Bonn-Norm				-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdo-AV18-Norm-MEC			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdo-Bonn-Norm-MEC			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdo-AV18-Norm-MEC-IC		-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdo-Bonn-Norm-MEC-IC		-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdo-AV18-Norm-MEC-IC-Rel	-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdo-Bonn-Norm-MEC-IC-Rel	-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdo-AV18-Norm-Rel			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdo-Bonn-Norm-Rel			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdo-AV18-PWBA-NR			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdo-Bonn-PWBA-NR			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdo-AV18-PWBA-RC			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdo-Bonn-PWBA-RC			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdol-AV18-Norm				-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdol-Bonn-Norm				-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdol-AV18-Norm-MEC			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdol-Bonn-Norm-MEC			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdol-AV18-Norm-MEC-IC		-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdol-Bonn-Norm-MEC-IC		-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdol-AV18-Norm-MEC-IC-Rel	-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdol-Bonn-Norm-MEC-IC-Rel	-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdol-AV18-Norm-Rel			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdol-Bonn-Norm-Rel			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdol-AV18-PWBA-NR			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdol-Bonn-PWBA-NR			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdol-AV18-PWBA-RC			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdol-Bonn-PWBA-RC			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdot-AV18-Norm				-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdot-Bonn-Norm				-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdot-AV18-Norm-MEC			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdot-Bonn-Norm-MEC			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdot-AV18-Norm-MEC-IC		-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdot-Bonn-Norm-MEC-IC		-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdot-AV18-Norm-MEC-IC-Rel	-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdot-Bonn-Norm-MEC-IC-Rel	-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdot-AV18-Norm-Rel			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdot-Bonn-Norm-Rel			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdot-AV18-PWBA-NR			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdot-Bonn-PWBA-NR			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdot-AV18-PWBA-RC			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H1-cs-dsdot-Bonn-PWBA-RC			-graph 6 -bxy 1:2 \
		-p /home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/Azz_proj_calc.par -noask 

xmgrace \
		-settype xy			-block	temp_H2-LC-AV18					-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H2-LC-CDBonn				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H2-VN-AV18					-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H2-VN-CDBonn				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H2-PW-AV18					-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H2-PW-CDBonn				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H2-PW-FSIOn-AV18			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H2-PW-FSIOn-CDBonn			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H2-PW-FSIOff-AV18			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H2-PW-FSIOff-CDBonn		-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H2-AV18-Norm				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H2-Bonn-Norm				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H2-AV18-Norm-MEC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H2-Bonn-Norm-MEC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H2-AV18-Norm-MEC-IC		-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H2-Bonn-Norm-MEC-IC		-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H2-AV18-Norm-MEC-IC-Rel	-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H2-Bonn-Norm-MEC-IC-Rel	-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H2-AV18-Norm-Rel			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H2-Bonn-Norm-Rel			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H2-AV18-PWBA-NR			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H2-Bonn-PWBA-NR			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H2-AV18-PWBA-RC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H2-Bonn-PWBA-RC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVd-AV18-Norm				-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVd-Bonn-Norm				-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVd-AV18-Norm-MEC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVd-Bonn-Norm-MEC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVd-AV18-Norm-MEC-IC		-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVd-Bonn-Norm-MEC-IC		-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVd-AV18-Norm-MEC-IC-Rel	-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVd-Bonn-Norm-MEC-IC-Rel	-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVd-AV18-Norm-Rel			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVd-Bonn-Norm-Rel			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVd-AV18-PWBA-NR			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVd-Bonn-PWBA-NR			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVd-AV18-PWBA-RC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVd-Bonn-PWBA-RC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVed-AV18-Norm				-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVed-Bonn-Norm				-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVed-AV18-Norm-MEC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVed-Bonn-Norm-MEC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVed-AV18-Norm-MEC-IC		-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVed-Bonn-Norm-MEC-IC		-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVed-AV18-Norm-MEC-IC-Rel	-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVed-Bonn-Norm-MEC-IC-Rel	-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVed-AV18-Norm-Rel			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVed-Bonn-Norm-Rel			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVed-AV18-PWBA-NR			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVed-Bonn-PWBA-NR			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVed-AV18-PWBA-RC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaVed-Bonn-PWBA-RC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaTed-AV18-Norm				-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaTed-Bonn-Norm				-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaTed-AV18-Norm-MEC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaTed-Bonn-Norm-MEC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaTed-AV18-Norm-MEC-IC		-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaTed-Bonn-Norm-MEC-IC		-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaTed-AV18-Norm-MEC-IC-Rel	-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaTed-Bonn-Norm-MEC-IC-Rel	-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaTed-AV18-Norm-Rel			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaTed-Bonn-Norm-Rel			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaTed-AV18-PWBA-NR			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaTed-Bonn-PWBA-NR			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaTed-AV18-PWBA-RC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H2-alphaTed-Bonn-PWBA-RC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdo-AV18-Norm				-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdo-Bonn-Norm				-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdo-AV18-Norm-MEC			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdo-Bonn-Norm-MEC			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdo-AV18-Norm-MEC-IC		-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdo-Bonn-Norm-MEC-IC		-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdo-AV18-Norm-MEC-IC-Rel	-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdo-Bonn-Norm-MEC-IC-Rel	-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdo-AV18-Norm-Rel			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdo-Bonn-Norm-Rel			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdo-AV18-PWBA-NR			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdo-Bonn-PWBA-NR			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdo-AV18-PWBA-RC			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdo-Bonn-PWBA-RC			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdol-AV18-Norm				-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdol-Bonn-Norm				-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdol-AV18-Norm-MEC			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdol-Bonn-Norm-MEC			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdol-AV18-Norm-MEC-IC		-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdol-Bonn-Norm-MEC-IC		-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdol-AV18-Norm-MEC-IC-Rel	-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdol-Bonn-Norm-MEC-IC-Rel	-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdol-AV18-Norm-Rel			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdol-Bonn-Norm-Rel			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdol-AV18-PWBA-NR			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdol-Bonn-PWBA-NR			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdol-AV18-PWBA-RC			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdol-Bonn-PWBA-RC			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdot-AV18-Norm				-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdot-Bonn-Norm				-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdot-AV18-Norm-MEC			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdot-Bonn-Norm-MEC			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdot-AV18-Norm-MEC-IC		-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdot-Bonn-Norm-MEC-IC		-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdot-AV18-Norm-MEC-IC-Rel	-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdot-Bonn-Norm-MEC-IC-Rel	-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdot-AV18-Norm-Rel			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdot-Bonn-Norm-Rel			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdot-AV18-PWBA-NR			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdot-Bonn-PWBA-NR			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdot-AV18-PWBA-RC			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H2-cs-dsdot-Bonn-PWBA-RC			-graph 6 -bxy 1:2 \
		-p /home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/Azz_proj_calc.par -noask 

xmgrace \
		-settype xy			-block	temp_H3-LC-AV18					-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H3-LC-CDBonn				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H3-VN-AV18					-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H3-VN-CDBonn				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H3-PW-AV18					-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H3-PW-CDBonn				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H3-PW-FSIOn-AV18			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H3-PW-FSIOn-CDBonn			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H3-PW-FSIOff-AV18			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H3-PW-FSIOff-CDBonn		-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H3-AV18-Norm				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H3-Bonn-Norm				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H3-AV18-Norm-MEC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H3-Bonn-Norm-MEC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H3-AV18-Norm-MEC-IC		-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H3-Bonn-Norm-MEC-IC		-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H3-AV18-Norm-MEC-IC-Rel	-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H3-Bonn-Norm-MEC-IC-Rel	-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H3-AV18-Norm-Rel			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H3-Bonn-Norm-Rel			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H3-AV18-PWBA-NR			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H3-Bonn-PWBA-NR			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H3-AV18-PWBA-RC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H3-Bonn-PWBA-RC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVd-AV18-Norm				-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVd-Bonn-Norm				-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVd-AV18-Norm-MEC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVd-Bonn-Norm-MEC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVd-AV18-Norm-MEC-IC		-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVd-Bonn-Norm-MEC-IC		-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVd-AV18-Norm-MEC-IC-Rel	-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVd-Bonn-Norm-MEC-IC-Rel	-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVd-AV18-Norm-Rel			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVd-Bonn-Norm-Rel			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVd-AV18-PWBA-NR			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVd-Bonn-PWBA-NR			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVd-AV18-PWBA-RC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVd-Bonn-PWBA-RC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVed-AV18-Norm				-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVed-Bonn-Norm				-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVed-AV18-Norm-MEC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVed-Bonn-Norm-MEC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVed-AV18-Norm-MEC-IC		-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVed-Bonn-Norm-MEC-IC		-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVed-AV18-Norm-MEC-IC-Rel	-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVed-Bonn-Norm-MEC-IC-Rel	-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVed-AV18-Norm-Rel			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVed-Bonn-Norm-Rel			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVed-AV18-PWBA-NR			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVed-Bonn-PWBA-NR			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVed-AV18-PWBA-RC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaVed-Bonn-PWBA-RC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaTed-AV18-Norm				-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaTed-Bonn-Norm				-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaTed-AV18-Norm-MEC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaTed-Bonn-Norm-MEC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaTed-AV18-Norm-MEC-IC		-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaTed-Bonn-Norm-MEC-IC		-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaTed-AV18-Norm-MEC-IC-Rel	-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaTed-Bonn-Norm-MEC-IC-Rel	-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaTed-AV18-Norm-Rel			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaTed-Bonn-Norm-Rel			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaTed-AV18-PWBA-NR			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaTed-Bonn-PWBA-NR			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaTed-AV18-PWBA-RC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H3-alphaTed-Bonn-PWBA-RC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdo-AV18-Norm				-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdo-Bonn-Norm				-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdo-AV18-Norm-MEC			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdo-Bonn-Norm-MEC			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdo-AV18-Norm-MEC-IC		-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdo-Bonn-Norm-MEC-IC		-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdo-AV18-Norm-MEC-IC-Rel	-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdo-Bonn-Norm-MEC-IC-Rel	-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdo-AV18-Norm-Rel			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdo-Bonn-Norm-Rel			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdo-AV18-PWBA-NR			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdo-Bonn-PWBA-NR			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdo-AV18-PWBA-RC			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdo-Bonn-PWBA-RC			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdol-AV18-Norm				-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdol-Bonn-Norm				-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdol-AV18-Norm-MEC			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdol-Bonn-Norm-MEC			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdol-AV18-Norm-MEC-IC		-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdol-Bonn-Norm-MEC-IC		-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdol-AV18-Norm-MEC-IC-Rel	-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdol-Bonn-Norm-MEC-IC-Rel	-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdol-AV18-Norm-Rel			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdol-Bonn-Norm-Rel			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdol-AV18-PWBA-NR			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdol-Bonn-PWBA-NR			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdol-AV18-PWBA-RC			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdol-Bonn-PWBA-RC			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdot-AV18-Norm				-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdot-Bonn-Norm				-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdot-AV18-Norm-MEC			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdot-Bonn-Norm-MEC			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdot-AV18-Norm-MEC-IC		-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdot-Bonn-Norm-MEC-IC		-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdot-AV18-Norm-MEC-IC-Rel	-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdot-Bonn-Norm-MEC-IC-Rel	-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdot-AV18-Norm-Rel			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdot-Bonn-Norm-Rel			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdot-AV18-PWBA-NR			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdot-Bonn-PWBA-NR			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdot-AV18-PWBA-RC			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_H3-cs-dsdot-Bonn-PWBA-RC			-graph 6 -bxy 1:2 \
		-p /home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/Azz_proj_calc.par -noask 

xmgrace \
		-settype xy			-block	temp_S1-LC-AV18					-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S1-LC-CDBonn				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S1-VN-AV18					-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S1-VN-CDBonn				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S1-PW-AV18					-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S1-PW-CDBonn				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S1-PW-FSIOn-AV18			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S1-PW-FSIOn-CDBonn			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S1-PW-FSIOff-AV18			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S1-PW-FSIOff-CDBonn		-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S1-AV18-Norm				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S1-Bonn-Norm				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S1-AV18-Norm-MEC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S1-Bonn-Norm-MEC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S1-AV18-Norm-MEC-IC		-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S1-Bonn-Norm-MEC-IC		-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S1-AV18-Norm-MEC-IC-Rel	-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S1-Bonn-Norm-MEC-IC-Rel	-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S1-AV18-Norm-Rel			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S1-Bonn-Norm-Rel			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S1-AV18-PWBA-NR			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S1-Bonn-PWBA-NR			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S1-AV18-PWBA-RC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S1-Bonn-PWBA-RC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVd-AV18-Norm				-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVd-Bonn-Norm				-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVd-AV18-Norm-MEC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVd-Bonn-Norm-MEC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVd-AV18-Norm-MEC-IC		-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVd-Bonn-Norm-MEC-IC		-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVd-AV18-Norm-MEC-IC-Rel	-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVd-Bonn-Norm-MEC-IC-Rel	-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVd-AV18-Norm-Rel			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVd-Bonn-Norm-Rel			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVd-AV18-PWBA-NR			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVd-Bonn-PWBA-NR			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVd-AV18-PWBA-RC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVd-Bonn-PWBA-RC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVed-AV18-Norm				-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVed-Bonn-Norm				-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVed-AV18-Norm-MEC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVed-Bonn-Norm-MEC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVed-AV18-Norm-MEC-IC		-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVed-Bonn-Norm-MEC-IC		-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVed-AV18-Norm-MEC-IC-Rel	-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVed-Bonn-Norm-MEC-IC-Rel	-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVed-AV18-Norm-Rel			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVed-Bonn-Norm-Rel			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVed-AV18-PWBA-NR			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVed-Bonn-PWBA-NR			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVed-AV18-PWBA-RC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaVed-Bonn-PWBA-RC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaTed-AV18-Norm				-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaTed-Bonn-Norm				-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaTed-AV18-Norm-MEC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaTed-Bonn-Norm-MEC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaTed-AV18-Norm-MEC-IC		-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaTed-Bonn-Norm-MEC-IC		-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaTed-AV18-Norm-MEC-IC-Rel	-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaTed-Bonn-Norm-MEC-IC-Rel	-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaTed-AV18-Norm-Rel			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaTed-Bonn-Norm-Rel			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaTed-AV18-PWBA-NR			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaTed-Bonn-PWBA-NR			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaTed-AV18-PWBA-RC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S1-alphaTed-Bonn-PWBA-RC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdo-AV18-Norm				-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdo-Bonn-Norm				-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdo-AV18-Norm-MEC			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdo-Bonn-Norm-MEC			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdo-AV18-Norm-MEC-IC		-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdo-Bonn-Norm-MEC-IC		-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdo-AV18-Norm-MEC-IC-Rel	-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdo-Bonn-Norm-MEC-IC-Rel	-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdo-AV18-Norm-Rel			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdo-Bonn-Norm-Rel			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdo-AV18-PWBA-NR			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdo-Bonn-PWBA-NR			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdo-AV18-PWBA-RC			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdo-Bonn-PWBA-RC			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdol-AV18-Norm				-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdol-Bonn-Norm				-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdol-AV18-Norm-MEC			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdol-Bonn-Norm-MEC			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdol-AV18-Norm-MEC-IC		-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdol-Bonn-Norm-MEC-IC		-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdol-AV18-Norm-MEC-IC-Rel	-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdol-Bonn-Norm-MEC-IC-Rel	-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdol-AV18-Norm-Rel			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdol-Bonn-Norm-Rel			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdol-AV18-PWBA-NR			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdol-Bonn-PWBA-NR			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdol-AV18-PWBA-RC			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdol-Bonn-PWBA-RC			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdot-AV18-Norm				-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdot-Bonn-Norm				-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdot-AV18-Norm-MEC			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdot-Bonn-Norm-MEC			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdot-AV18-Norm-MEC-IC		-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdot-Bonn-Norm-MEC-IC		-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdot-AV18-Norm-MEC-IC-Rel	-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdot-Bonn-Norm-MEC-IC-Rel	-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdot-AV18-Norm-Rel			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdot-Bonn-Norm-Rel			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdot-AV18-PWBA-NR			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdot-Bonn-PWBA-NR			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdot-AV18-PWBA-RC			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S1-cs-dsdot-Bonn-PWBA-RC			-graph 6 -bxy 1:2 \
		-p /home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/Azz_proj_calc.par -noask 

xmgrace \
		-settype xy			-block	temp_S2-LC-AV18					-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S2-LC-CDBonn				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S2-VN-AV18					-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S2-VN-CDBonn				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S2-PW-AV18					-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S2-PW-CDBonn				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S2-PW-FSIOn-AV18			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S2-PW-FSIOn-CDBonn			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S2-PW-FSIOff-AV18			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S2-PW-FSIOff-CDBonn		-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S2-AV18-Norm				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S2-Bonn-Norm				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S2-AV18-Norm-MEC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S2-Bonn-Norm-MEC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S2-AV18-Norm-MEC-IC		-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S2-Bonn-Norm-MEC-IC		-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S2-AV18-Norm-MEC-IC-Rel	-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S2-Bonn-Norm-MEC-IC-Rel	-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S2-AV18-Norm-Rel			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S2-Bonn-Norm-Rel			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S2-AV18-PWBA-NR			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S2-Bonn-PWBA-NR			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S2-AV18-PWBA-RC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S2-Bonn-PWBA-RC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVd-AV18-Norm				-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVd-Bonn-Norm				-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVd-AV18-Norm-MEC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVd-Bonn-Norm-MEC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVd-AV18-Norm-MEC-IC		-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVd-Bonn-Norm-MEC-IC		-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVd-AV18-Norm-MEC-IC-Rel	-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVd-Bonn-Norm-MEC-IC-Rel	-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVd-AV18-Norm-Rel			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVd-Bonn-Norm-Rel			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVd-AV18-PWBA-NR			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVd-Bonn-PWBA-NR			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVd-AV18-PWBA-RC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVd-Bonn-PWBA-RC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVed-AV18-Norm				-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVed-Bonn-Norm				-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVed-AV18-Norm-MEC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVed-Bonn-Norm-MEC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVed-AV18-Norm-MEC-IC		-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVed-Bonn-Norm-MEC-IC		-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVed-AV18-Norm-MEC-IC-Rel	-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVed-Bonn-Norm-MEC-IC-Rel	-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVed-AV18-Norm-Rel			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVed-Bonn-Norm-Rel			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVed-AV18-PWBA-NR			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVed-Bonn-PWBA-NR			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVed-AV18-PWBA-RC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaVed-Bonn-PWBA-RC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaTed-AV18-Norm				-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaTed-Bonn-Norm				-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaTed-AV18-Norm-MEC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaTed-Bonn-Norm-MEC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaTed-AV18-Norm-MEC-IC		-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaTed-Bonn-Norm-MEC-IC		-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaTed-AV18-Norm-MEC-IC-Rel	-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaTed-Bonn-Norm-MEC-IC-Rel	-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaTed-AV18-Norm-Rel			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaTed-Bonn-Norm-Rel			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaTed-AV18-PWBA-NR			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaTed-Bonn-PWBA-NR			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaTed-AV18-PWBA-RC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S2-alphaTed-Bonn-PWBA-RC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdo-AV18-Norm				-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdo-Bonn-Norm				-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdo-AV18-Norm-MEC			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdo-Bonn-Norm-MEC			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdo-AV18-Norm-MEC-IC		-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdo-Bonn-Norm-MEC-IC		-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdo-AV18-Norm-MEC-IC-Rel	-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdo-Bonn-Norm-MEC-IC-Rel	-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdo-AV18-Norm-Rel			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdo-Bonn-Norm-Rel			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdo-AV18-PWBA-NR			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdo-Bonn-PWBA-NR			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdo-AV18-PWBA-RC			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdo-Bonn-PWBA-RC			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdol-AV18-Norm				-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdol-Bonn-Norm				-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdol-AV18-Norm-MEC			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdol-Bonn-Norm-MEC			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdol-AV18-Norm-MEC-IC		-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdol-Bonn-Norm-MEC-IC		-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdol-AV18-Norm-MEC-IC-Rel	-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdol-Bonn-Norm-MEC-IC-Rel	-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdol-AV18-Norm-Rel			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdol-Bonn-Norm-Rel			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdol-AV18-PWBA-NR			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdol-Bonn-PWBA-NR			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdol-AV18-PWBA-RC			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdol-Bonn-PWBA-RC			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdot-AV18-Norm				-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdot-Bonn-Norm				-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdot-AV18-Norm-MEC			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdot-Bonn-Norm-MEC			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdot-AV18-Norm-MEC-IC		-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdot-Bonn-Norm-MEC-IC		-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdot-AV18-Norm-MEC-IC-Rel	-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdot-Bonn-Norm-MEC-IC-Rel	-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdot-AV18-Norm-Rel			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdot-Bonn-Norm-Rel			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdot-AV18-PWBA-NR			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdot-Bonn-PWBA-NR			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdot-AV18-PWBA-RC			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S2-cs-dsdot-Bonn-PWBA-RC			-graph 6 -bxy 1:2 \
		-p /home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/Azz_proj_calc.par -noask 

xmgrace \
		-settype xy			-block	temp_S3-LC-AV18					-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S3-LC-CDBonn				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S3-VN-AV18					-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S3-VN-CDBonn				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S3-PW-AV18					-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S3-PW-CDBonn				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S3-PW-FSIOn-AV18			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S3-PW-FSIOn-CDBonn			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S3-PW-FSIOff-AV18			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S3-PW-FSIOff-CDBonn		-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S3-AV18-Norm				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S3-Bonn-Norm				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S3-AV18-Norm-MEC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S3-Bonn-Norm-MEC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S3-AV18-Norm-MEC-IC		-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S3-Bonn-Norm-MEC-IC		-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S3-AV18-Norm-MEC-IC-Rel	-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S3-Bonn-Norm-MEC-IC-Rel	-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S3-AV18-Norm-Rel			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S3-Bonn-Norm-Rel			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S3-AV18-PWBA-NR			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S3-Bonn-PWBA-NR			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S3-AV18-PWBA-RC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S3-Bonn-PWBA-RC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVd-AV18-Norm				-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVd-Bonn-Norm				-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVd-AV18-Norm-MEC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVd-Bonn-Norm-MEC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVd-AV18-Norm-MEC-IC		-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVd-Bonn-Norm-MEC-IC		-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVd-AV18-Norm-MEC-IC-Rel	-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVd-Bonn-Norm-MEC-IC-Rel	-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVd-AV18-Norm-Rel			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVd-Bonn-Norm-Rel			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVd-AV18-PWBA-NR			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVd-Bonn-PWBA-NR			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVd-AV18-PWBA-RC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVd-Bonn-PWBA-RC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVed-AV18-Norm				-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVed-Bonn-Norm				-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVed-AV18-Norm-MEC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVed-Bonn-Norm-MEC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVed-AV18-Norm-MEC-IC		-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVed-Bonn-Norm-MEC-IC		-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVed-AV18-Norm-MEC-IC-Rel	-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVed-Bonn-Norm-MEC-IC-Rel	-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVed-AV18-Norm-Rel			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVed-Bonn-Norm-Rel			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVed-AV18-PWBA-NR			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVed-Bonn-PWBA-NR			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVed-AV18-PWBA-RC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaVed-Bonn-PWBA-RC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaTed-AV18-Norm				-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaTed-Bonn-Norm				-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaTed-AV18-Norm-MEC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaTed-Bonn-Norm-MEC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaTed-AV18-Norm-MEC-IC		-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaTed-Bonn-Norm-MEC-IC		-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaTed-AV18-Norm-MEC-IC-Rel	-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaTed-Bonn-Norm-MEC-IC-Rel	-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaTed-AV18-Norm-Rel			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaTed-Bonn-Norm-Rel			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaTed-AV18-PWBA-NR			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaTed-Bonn-PWBA-NR			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaTed-AV18-PWBA-RC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S3-alphaTed-Bonn-PWBA-RC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdo-AV18-Norm				-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdo-Bonn-Norm				-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdo-AV18-Norm-MEC			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdo-Bonn-Norm-MEC			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdo-AV18-Norm-MEC-IC		-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdo-Bonn-Norm-MEC-IC		-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdo-AV18-Norm-MEC-IC-Rel	-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdo-Bonn-Norm-MEC-IC-Rel	-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdo-AV18-Norm-Rel			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdo-Bonn-Norm-Rel			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdo-AV18-PWBA-NR			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdo-Bonn-PWBA-NR			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdo-AV18-PWBA-RC			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdo-Bonn-PWBA-RC			-graph 4 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdol-AV18-Norm				-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdol-Bonn-Norm				-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdol-AV18-Norm-MEC			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdol-Bonn-Norm-MEC			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdol-AV18-Norm-MEC-IC		-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdol-Bonn-Norm-MEC-IC		-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdol-AV18-Norm-MEC-IC-Rel	-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdol-Bonn-Norm-MEC-IC-Rel	-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdol-AV18-Norm-Rel			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdol-Bonn-Norm-Rel			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdol-AV18-PWBA-NR			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdol-Bonn-PWBA-NR			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdol-AV18-PWBA-RC			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdol-Bonn-PWBA-RC			-graph 5 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdot-AV18-Norm				-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdot-Bonn-Norm				-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdot-AV18-Norm-MEC			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdot-Bonn-Norm-MEC			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdot-AV18-Norm-MEC-IC		-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdot-Bonn-Norm-MEC-IC		-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdot-AV18-Norm-MEC-IC-Rel	-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdot-Bonn-Norm-MEC-IC-Rel	-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdot-AV18-Norm-Rel			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdot-Bonn-Norm-Rel			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdot-AV18-PWBA-NR			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdot-Bonn-PWBA-NR			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdot-AV18-PWBA-RC			-graph 6 -bxy 1:2 \
		-settype xy			-block	temp_S3-cs-dsdot-Bonn-PWBA-RC			-graph 6 -bxy 1:2 \
		-p /home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/Azz_proj_calc.par -noask 

xmgrace \
		-settype xy			-block	temp_comp_S1-LC-AV18					-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-LC-CDBonn				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-VN-AV18					-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-VN-CDBonn				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-PW-AV18					-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-PW-CDBonn				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-PW-FSIOn-AV18			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-PW-FSIOn-CDBonn			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-PW-FSIOff-AV18			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-PW-FSIOff-CDBonn		-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-AV18-Norm				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-Bonn-Norm				-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-AV18-Norm-MEC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-Bonn-Norm-MEC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-AV18-Norm-MEC-IC		-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-Bonn-Norm-MEC-IC		-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-AV18-Norm-MEC-IC-Rel	-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-Bonn-Norm-MEC-IC-Rel	-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-AV18-Norm-Rel			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-Bonn-Norm-Rel			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-AV18-PWBA-NR			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-Bonn-PWBA-NR			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-AV18-PWBA-RC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-Bonn-PWBA-RC			-graph 0 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVd-AV18-Norm				-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVd-Bonn-Norm				-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVd-AV18-Norm-MEC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVd-Bonn-Norm-MEC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVd-AV18-Norm-MEC-IC		-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVd-Bonn-Norm-MEC-IC		-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVd-AV18-Norm-MEC-IC-Rel	-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVd-Bonn-Norm-MEC-IC-Rel	-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVd-AV18-Norm-Rel			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVd-Bonn-Norm-Rel			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVd-AV18-PWBA-NR			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVd-Bonn-PWBA-NR			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVd-AV18-PWBA-RC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVd-Bonn-PWBA-RC			-graph 1 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVed-AV18-Norm				-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVed-Bonn-Norm				-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVed-AV18-Norm-MEC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVed-Bonn-Norm-MEC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVed-AV18-Norm-MEC-IC		-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVed-Bonn-Norm-MEC-IC		-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVed-AV18-Norm-MEC-IC-Rel	-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVed-Bonn-Norm-MEC-IC-Rel	-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVed-AV18-Norm-Rel			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVed-Bonn-Norm-Rel			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVed-AV18-PWBA-NR			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVed-Bonn-PWBA-NR			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVed-AV18-PWBA-RC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaVed-Bonn-PWBA-RC			-graph 2 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaTed-AV18-Norm				-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaTed-Bonn-Norm				-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaTed-AV18-Norm-MEC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaTed-Bonn-Norm-MEC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaTed-AV18-Norm-MEC-IC		-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaTed-Bonn-Norm-MEC-IC		-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaTed-AV18-Norm-MEC-IC-Rel	-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaTed-Bonn-Norm-MEC-IC-Rel	-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaTed-AV18-Norm-Rel			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaTed-Bonn-Norm-Rel			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaTed-AV18-PWBA-NR			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaTed-Bonn-PWBA-NR			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaTed-AV18-PWBA-RC			-graph 3 -bxy 1:2 \
		-settype xy			-block	temp_comp_S1-alphaTed-Bonn-PWBA-RC			-graph 3 -bxy 1:2 \
		-p /home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/Azz_proj_calc.par -noask 




rm -f temp*
