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

START=$(date +%s)

file0="./ptrates.f"

i=1
#while [ $i -le 4 ]
while [ $i -le 2 ]
do
	x=0
	while [ $x -le 5 ]
	do
		y=0
		while [ $y -lt 10 ]
		do
#			lineNo=`awk '$0 ~ str{print NR}{b=$0}' str="      DATA qqval1/    ..., ..., ..., ..., .../" $file0`
			lineNo=`awk '$0 ~ str{print NR}{b=$0}' str="      DATA qqval1/   ...., 99, 99, 99, 99/" $file0`
			sed -i -e "${lineNo}s/\ \ ..\..,/\ \ 99.9,/g" $file0
#			sed -i -e "${lineNo}s/\ .\..\//\ 9.9\//g" $file0
#			lineNo=`awk '$0 ~ str{print NR}{b=$0}' str="      DATA qqval2/    ..., ..., ..., ..., .../" $file0`
			lineNo=`awk '$0 ~ str{print NR}{b=$0}' str="      DATA qqval2/   ...., 99, 99, 99, 99/" $file0`
			sed -i -e "${lineNo}s/\ \ ..\..,/\ \ 99.9,/g" $file0
#			sed -i -e "${lineNo}s/\ .\..\//\ 9.9\//g" $file0
# vvvvvvvvvvvvvvvvvv for replacing HMS points vvvvvvvvvvvvvvvvvvv
			if [ "$i" -eq 1 ]; then
#				lineNo=`awk '$0 ~ str{print NR}{b=$0}' str="      DATA qqval1/    ..., ..., ..., ..., .../" $file0`
				lineNo=`awk '$0 ~ str{print NR}{b=$0}' str="      DATA qqval1/   ...., 99, 99, 99, 99/" $file0`
#				echo "Replacing line #$lineNo..."
#				sed -i -e "${lineNo}s/.\..,/$x.$y,/g" $file0
#				sed -i -e "${lineNo}s/\ .\..\//\ $x.$y\//g" $file0
				sed -i -e "${lineNo}s/\ \ ..\..,/\ \ \ $x.$y,/g" $file0
				outputFolder="/home/ellie/Desktop/b1_plots/x_08_to_19/HMS_q2_scan"
			fi
# vvvvvvvvvvvvvvvvvv for replacing SHMS points vvvvvvvvvvvvvvvvvvv
			if [ "$i" -eq 2 ]; then
#				lineNo=`awk '$0 ~ str{print NR}{b=$0}' str="      DATA qqval2/   ...., ..., ..., ..., .../" $file0`
				lineNo=`awk '$0 ~ str{print NR}{b=$0}' str="      DATA qqval2/   ...., 99, 99, 99, 99/" $file0`
#				echo "Replacing line #$lineNo..."
#				sed -i -e "${lineNo}s/...,/$x.$y,/g" $file0
#				sed -i -e "${lineNo}s/\ ...\//\ $x.$y\//g" $file0
				sed -i -e "${lineNo}s/\ \ ..\..,/\ \ \ $x.$y,/g" $file0
				outputFolder="/home/ellie/Desktop/b1_plots/x_08_to_19/SHMS_q2_scan"
			fi





# vvvvvvvvvvvvvvvvvv for replacing SHMS, lowest x point vvvvvvvvvvvvvvvvvvv
#			if [ "$i" -eq 1 ]; then
#				lineNo=`awk '$0 ~ str{print NR}{b=$0}' str="      DATA qqval2/   ...,  ..., ..., 99, 99/" $file0`
#				echo "Replacing line #$lineNo..."
#				sed -i -e "${lineNo}s/\ \ \ ...,\ \ /\ \ \ $x.$y,\ \ /" $file0
#				outputFolder="/home/ellie/Desktop/b1_plots/x_050_075_100_125/SHMS_050_q2_scan"
#			fi
# vvvvvvvvvvvvvvvvvv for replacing SHMS, middle x point vvvvvvvvvvvvvvvvvvv
#			if [ "$i" -eq 2 ]; then
#				lineNo=`awk '$0 ~ str{print NR}{b=$0}' str="      DATA qqval2/   ...,  ..., ..., 99, 99/" $file0`
#				echo "Replacing line #$lineNo..."
#				sed -i -e "${lineNo}s/,\ \ ...,\ /,\ \ $x.$y,\ /" $file0
#				outputFolder="/home/ellie/Desktop/b1_plots/x_050_075_100_125/SHMS_075_q2_scan"
#			fi
# vvvvvvvvvvvvvvvvvv for replacing SHMS, highest x point vvvvvvvvvvvvvvvvvvv
#			if [ "$i" -eq 3 ]; then
#				lineNo=`awk '$0 ~ str{print NR}{b=$0}' str="      DATA qqval2/   ...,  ..., ..., 99, 99/" $file0`
#				echo "Replacing line #$lineNo..."
#				sed -i -e "${lineNo}s/,\ ...,\ 99,\ 99/,\ $x.$y,\ 99,\ 99/" $file0
#				outputFolder="/home/ellie/Desktop/b1_plots/x_050_075_100_125/SHMS_100_q2_scan"
#			fi
## vvvvvvvvvvvvvvvvvv for replacing HMS, highest x point vvvvvvvvvvvvvvvvvvv
#			if [ "$i" -eq 4 ]; then
#				lineNo=`awk '$0 ~ str{print NR}{b=$0}' str="      DATA qqval1/   99, 99, 99, 99, .../" $file0`
#				echo "Replacing line #$lineNo..."
#				sed -i -e "${lineNo}s/\ ...\//\ $x.$y\//" $file0
#				outputFolder="/home/ellie/Desktop/b1_plots/x_050_075_100_125/HMS_125_q2_scan"
#			fi


			rm fort.*
			rm ./ptrates
			gfortran -ffixed-line-length-none -o ptrates ptrates.f F1F209.f sub_b1d.f sub_qe_b1d.f > rates_output.out 2>&1
			rm *.o >> rates_output.out 2>&1
			./ptrates >> rates_output.out 2>&1
	
			./scripts/rates_b1_png.sh >> rates_output.out 2>&1

			mv b1_rates_hms_shms.png $outputFolder/q2_${x}${y}_b1_rates_hms_shms.png
			END=$(date +%s)
			DIFF=$(( $END - $START ))
			echo "i=$i, Q2=$x.$y, Running time: $DIFF seconds"
			y=$(( $y + 1 ))
		done
		x=$(( $x + 1 ))

	done
	i=$(( $i + 1 ))
done


END=$(date +%s)
DIFF=$(( $END - $START ))
echo "It took $DIFF seconds"
