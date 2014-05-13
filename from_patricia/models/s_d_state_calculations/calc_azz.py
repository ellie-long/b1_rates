#!/usr/bin/python
#
# **********************************************************
# calc_azz.py
#
# This script will pull in the S- and D-state wavefunctions
# of the deuteron and output Azz with respect to x for each
# wavefunction.
#
# Elena Long
# ellie@jlab.org
# 5/13/2014
#
# **********************************************************

import os
import os.path
import math

if (os.path.exists("./azz_calc/av18_azz.dat")): os.remove("./azz_calc/av18_azz.dat")
if (os.path.exists("./azz_calc/fs_azz.dat")): os.remove("./azz_calc/fs_azz.dat")
if (os.path.exists("./azz_calc/cdbonn_azz.dat")): os.remove("./azz_calc/cdbonn_azz.dat")
if (os.path.exists("./azz_calc/n3lo500_azz.dat")): os.remove("./azz_calc/n3lo500_azz.dat")
if (os.path.exists("./azz_calc/n3lo600_azz.dat")): os.remove("./azz_calc/n3lo600_azz.dat")
if (os.path.exists("./azz_calc/nimj1_azz.dat")): os.remove("./azz_calc/nimj1_azz.dat")
if (os.path.exists("./azz_calc/nimj2_azz.dat")): os.remove("./azz_calc/nimj2_azz.dat")
if (os.path.exists("./azz_calc/nimj3_azz.dat")): os.remove("./azz_calc/nimj3_azz.dat")

av18_wf		= open("./col_wfs/dwav_av18_term.data", "r")
av18_azz	= open("./azz_calc/av18_azz.dat", "wb")
fs_wf		= open("./col_wfs/frankfurt_strikman.data", "r")
fs_azz		= open("./azz_calc/fs_azz.dat", "wb")
cdbonn_wf	= open("./col_wfs/dwav_cdb_term.data", "r")
cdbonn_azz	= open("./azz_calc/cdbonn_azz.dat", "wb")
n3lo500_wf	= open("./col_wfs/dwav_n3lo500_term.data", "r")
n3lo500_azz	= open("./azz_calc/n3lo500_azz.dat", "wb")
n3lo600_wf	= open("./col_wfs/dwav_n3lo600_term.data", "r")
n3lo600_azz	= open("./azz_calc/n3lo600_azz.dat", "wb")
nimj1_wf	= open("./col_wfs/dwav_nimj1_term.data", "r")
nimj1_azz	= open("./azz_calc/nimj1_azz.dat", "wb")
nimj2_wf	= open("./col_wfs/dwav_nimj2_term.data", "r")
nimj2_azz	= open("./azz_calc/nimj2_azz.dat", "wb")
nimj3_wf	= open("./col_wfs/dwav_nimj3_term.data", "r")
nimj3_azz	= open("./azz_calc/nimj3_azz.dat", "wb")

input_file = av18_wf
output_file = av18_azz

theta = 180
for wf in range(1,9):
	if (wf == 1):
		print "Working on F&S"
		input_file = fs_wf
		output_file = fs_azz
 	elif (wf == 2):
		print "Working on AV18"
		input_file = av18_wf
		output_file = av18_azz
 	elif (wf == 3):
		print "Working on CDBonn"
		input_file = cdbonn_wf
		output_file = cdbonn_azz
 	elif (wf == 4):
		print "Working on n3lo500"
		input_file = n3lo500_wf
		output_file = n3lo500_azz
 	elif (wf == 5):
		print "Working on n3lo600"
		input_file = n3lo600_wf
		output_file = n3lo600_azz
 	elif (wf == 6):
		print "Working on Nimj1"
		input_file = nimj1_wf
		output_file = nimj1_azz
 	elif (wf == 7):
		print "Working on Nimj2"
		input_file = nimj2_wf
		output_file = nimj2_azz
 	elif (wf == 8):
		print "Working on Nimj3"
		input_file = nimj3_wf
		output_file = nimj3_azz
	for line in input_file:
		columns = line.split()
		k_fm  = float(columns[0])
		k_gev = k_fm*0.197327
		u	= float(columns[1])
		w	= float(columns[2])
		if (wf>1): w = -w
		R	= (2**(0.5)*u*w+w*w/2)/(u*u+w*w)
#		k1	= k_gev
		k1	= k_gev**2/1.876
		k2	= k_gev
#		k3	= k_gev
		k3	= k_gev*math.cos(theta*3.14159/180)
#		azz	= 1 - ((3/(k_gev**2))*(k3**2 - k1**2 + k2**2) + 1)*R
#		azz	= 1 - ((3/(k_gev**2))*(k3**2) + 1)*R
		azz	= ((3/(k_gev**2))*(k1**2/2-k3**2))*R
		print >> output_file, k_gev, azz


av18_wf.close()
av18_azz.close()
fs_wf.close()
fs_azz.close()
cdbonn_wf.close()
cdbonn_azz.close()
n3lo500_wf.close()
n3lo500_azz.close()
n3lo600_wf.close()
n3lo600_azz.close()
nimj1_wf.close()
nimj1_azz.close()
nimj2_wf.close()
nimj2_azz.close()
nimj3_wf.close()
nimj3_azz.close()

