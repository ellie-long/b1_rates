#!/bin/sh

# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#
# cov.sh
#
# This script (put together by Patricia Solvignon) plots the projected
# kinematics coverage based on ../output/xs.out
#
# In the first plot, if iSpec = 1 or 2 (HMS or SHMS) and x is in the
# first x bin, then it will output x and Q^2 into 8 coverage bins
# (hms_cov_# and shms_cov_#).
#
# In the second plot, it looks like it's doing the same thing but only
# for iSpec = 5 or 6 (BigBite or Super BigBite). I'm not sure why the
# coverage files are labeled hms and shms, though.
#
# Elena Long
# ellie@jlab.org
# 4/2/2013
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

# Plot total coverage of Q^2 vs x
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
file0="../output/xs.out"
# In file0, the columns are defined by:
# $1 = Spectrometer Type
#		1 = HMS
#		2 = SHMS
# 		3 = HRS
#		4 = SOLID
#		5 = BigBite
#		6 = Super BigBite
# $2 = x Bin
# $5 = x_Bjorken
# $4 = Q^2

# The line below prepares temporary text files in "x,y" format that
# will be used by xmgrace to make a plot
awk '$1==1 {print $5,$4}' $file0 > hms_cov
awk '$1==2 {print $5,$4}' $file0 > shms_cov

# xmgrace plots Q^2 vs x_Bjorken
xmgrace -free -settype xy -block hms_cov  -graph 0 -bxy 1:2 \
              -settype xy -block shms_cov -graph 0 -bxy 1:2 \
              -p cov.par -noask
# gracebat turns the Q^2 vs x_Bjorken plot into an *.eps file
gracebat -hdevice EPS -printfile cov.eps \
              -settype xy -block hms_cov  -graph 0 -bxy 1:2 \
              -settype xy -block shms_cov -graph 0 -bxy 1:2 \
              -p cov.par -noask

# In the next line, hms_cov and shms_cov are deleted. Comment this
# line out if you want to see what's inside.
rm -f hms_cov shms_cov
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

# Make two plots of Q^2 vs x: One for HMS, one for SHMS
# Curves for y=0.85, y=0.1, W = 2 GeV, and W=Delta(1232) are included
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
# file0 is used to define 8 different kinematic coverage sections
# Originally, all of the bins are identical so it just plotted
# the same thing 8 times
awk '$1==1 && $2==1 {print $5,$4}' $file0 > hms_cov_1
awk '$1==1 && $2==2 {print $5,$4}' $file0 > hms_cov_2
awk '$1==1 && $2==3 {print $5,$4}' $file0 > hms_cov_3
awk '$1==1 && $2==4 {print $5,$4}' $file0 > hms_cov_4
awk '$1==1 && $2==5 {print $5,$4}' $file0 > hms_cov_5
awk '$1==1 && $2==1 {print $5,$4}' $file0 > hms_cov_6
awk '$1==1 && $2==1 {print $5,$4}' $file0 > hms_cov_7
awk '$1==1 && $2==1 {print $5,$4}' $file0 > hms_cov_8

awk '$1==2 && $2==1 {print $5,$4}' $file0 > shms_cov_1
awk '$1==2 && $2==2 {print $5,$4}' $file0 > shms_cov_2
awk '$1==2 && $2==3 {print $5,$4}' $file0 > shms_cov_3
awk '$1==2 && $2==4 {print $5,$4}' $file0 > shms_cov_4
awk '$1==2 && $2==5 {print $5,$4}' $file0 > shms_cov_5
awk '$1==2 && $2==1 {print $5,$4}' $file0 > shms_cov_6
awk '$1==2 && $2==1 {print $5,$4}' $file0 > shms_cov_7
awk '$1==2 && $2==1 {print $5,$4}' $file0 > shms_cov_8


file1="../output/lines.out"

xmgrace -free -settype xy -block hms_cov_1  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_2  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_3  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_4  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_5  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_6  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_7  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_8  -graph 0 -bxy 1:2 \
              -settype xy -block $file1     -graph 0 -bxy 1:2 \
              -settype xy -block $file1     -graph 0 -bxy 1:3 \
              -settype xy -block $file1     -graph 0 -bxy 1:4 \
              -settype xy -block $file1     -graph 0 -bxy 1:5 \
              -settype xy -block $file1     -graph 0 -bxy 1:6 \
              -settype xy -block shms_cov_1 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_2 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_3 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_4 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_5 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_6 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_7 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_8 -graph 1 -bxy 1:2 \
              -settype xy -block $file1     -graph 1 -bxy 1:2 \
              -settype xy -block $file1     -graph 1 -bxy 1:3 \
              -settype xy -block $file1     -graph 1 -bxy 1:4 \
              -settype xy -block $file1     -graph 1 -bxy 1:5 \
              -settype xy -block $file1     -graph 1 -bxy 1:6 \
              -p cov_split_A.par -noask
gracebat -hdevice EPS -printfile cov_split_hallC.eps \
              -settype xy -block hms_cov_1  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_2  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_3  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_4  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_5  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_6  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_7  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_8  -graph 0 -bxy 1:2 \
              -settype xy -block $file1     -graph 0 -bxy 1:2 \
              -settype xy -block $file1     -graph 0 -bxy 1:3 \
              -settype xy -block $file1     -graph 0 -bxy 1:4 \
              -settype xy -block $file1     -graph 0 -bxy 1:5 \
              -settype xy -block $file1     -graph 0 -bxy 1:6 \
              -settype xy -block shms_cov_1 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_2 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_3 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_4 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_5 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_6 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_7 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_8 -graph 1 -bxy 1:2 \
              -settype xy -block $file1     -graph 1 -bxy 1:2 \
              -settype xy -block $file1     -graph 1 -bxy 1:3 \
              -settype xy -block $file1     -graph 1 -bxy 1:4 \
              -settype xy -block $file1     -graph 1 -bxy 1:5 \
              -settype xy -block $file1     -graph 1 -bxy 1:6 \
              -p cov_split_A.par -noask
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


# Make two plots of Q^2 vs x: One for BigBite (mislabeled as HMS), 
# one for Super BigBite (mislabeled as SHMS)
# Curves for y=0.85, y=0.1, W = 2 GeV, and W=Delta(1232) are included
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
awk '$1==5 && $2==1 {print $5,$4}' $file0 > hms_cov_1
awk '$1==5 && $2==1 {print $5,$4}' $file0 > hms_cov_2
awk '$1==5 && $2==1 {print $5,$4}' $file0 > hms_cov_3
awk '$1==5 && $2==1 {print $5,$4}' $file0 > hms_cov_4
awk '$1==5 && $2==1 {print $5,$4}' $file0 > hms_cov_5
awk '$1==5 && $2==1 {print $5,$4}' $file0 > hms_cov_6
awk '$1==5 && $2==1 {print $5,$4}' $file0 > hms_cov_7
awk '$1==5 && $2==1 {print $5,$4}' $file0 > hms_cov_8

awk '$1==6 && $2==1 {print $5,$4}' $file0 > shms_cov_1
awk '$1==6 && $2==1 {print $5,$4}' $file0 > shms_cov_2
awk '$1==6 && $2==1 {print $5,$4}' $file0 > shms_cov_3
awk '$1==6 && $2==1 {print $5,$4}' $file0 > shms_cov_4
awk '$1==6 && $2==1 {print $5,$4}' $file0 > shms_cov_5
awk '$1==6 && $2==1 {print $5,$4}' $file0 > shms_cov_6
awk '$1==6 && $2==1 {print $5,$4}' $file0 > shms_cov_7
awk '$1==6 && $2==1 {print $5,$4}' $file0 > shms_cov_8

file1="../output/lines.out"

xmgrace -free -settype xy -block hms_cov_1  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_2  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_3  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_4  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_5  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_6  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_7  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_8  -graph 0 -bxy 1:2 \
              -settype xy -block $file1     -graph 0 -bxy 1:2 \
              -settype xy -block $file1     -graph 0 -bxy 1:3 \
              -settype xy -block $file1     -graph 0 -bxy 1:4 \
              -settype xy -block $file1     -graph 0 -bxy 1:5 \
              -settype xy -block $file1     -graph 0 -bxy 1:6 \
              -settype xy -block shms_cov_1 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_2 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_3 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_4 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_5 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_6 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_7 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_8 -graph 1 -bxy 1:2 \
              -settype xy -block $file1     -graph 1 -bxy 1:2 \
              -settype xy -block $file1     -graph 1 -bxy 1:3 \
              -settype xy -block $file1     -graph 1 -bxy 1:4 \
              -settype xy -block $file1     -graph 1 -bxy 1:5 \
              -settype xy -block $file1     -graph 1 -bxy 1:6 \
              -p cov_split_A.par -noask
gracebat -hdevice EPS -printfile cov_split_hallA.eps \
              -settype xy -block hms_cov_1  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_2  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_3  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_4  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_5  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_6  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_7  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_8  -graph 0 -bxy 1:2 \
              -settype xy -block $file1     -graph 0 -bxy 1:2 \
              -settype xy -block $file1     -graph 0 -bxy 1:3 \
              -settype xy -block $file1     -graph 0 -bxy 1:4 \
              -settype xy -block $file1     -graph 0 -bxy 1:5 \
              -settype xy -block $file1     -graph 0 -bxy 1:6 \
              -settype xy -block shms_cov_1 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_2 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_3 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_4 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_5 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_6 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_7 -graph 1 -bxy 1:2 \
              -settype xy -block shms_cov_8 -graph 1 -bxy 1:2 \
              -settype xy -block $file1     -graph 1 -bxy 1:2 \
              -settype xy -block $file1     -graph 1 -bxy 1:3 \
              -settype xy -block $file1     -graph 1 -bxy 1:4 \
              -settype xy -block $file1     -graph 1 -bxy 1:5 \
              -settype xy -block $file1     -graph 1 -bxy 1:6 \
              -p cov_split_A.par -noask
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

# The line below removes all of the temporary files created to make
# the plots
rm -f hms_cov_* shms_cov_*
