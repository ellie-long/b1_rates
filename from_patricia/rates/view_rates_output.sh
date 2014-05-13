#!/bin/sh

# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#
# q2_scan.sh
#
# If this is working properly, it should
# run the ptrates.f code for multiple
# values of Q2 and output the image files
# to /home/ellie/Desktop/b1_plots
#
# Elena Long
# ellie@jlab.org
# 9/13/2013
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

i=1
#while [ $i -le 4 ]
while [ $i -le 2 ]
do
	cat ./rates_output2.out
#	i=$(( $i + 1 ))
    sleep 5
done



