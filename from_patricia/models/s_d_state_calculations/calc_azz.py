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

m_d			= 1.876
m_n			= 0.939
theta		= 90
theta_min	= 0
theta_max	= 180
phi			= 180
phi_min		= 0
phi_max		= 360
for wf in range(1,9):
#for wf in range(2,3):
	if (wf == 1):
		print "\nWorking on F&S"
		input_file = fs_wf
		output_file = fs_azz
 	elif (wf == 2):
		print "\nWorking on AV18"
		input_file = av18_wf
		output_file = av18_azz
 	elif (wf == 3):
		print "\nWorking on CDBonn"
		input_file = cdbonn_wf
		output_file = cdbonn_azz
 	elif (wf == 4):
		print "\nWorking on n3lo500"
		input_file = n3lo500_wf
		output_file = n3lo500_azz
 	elif (wf == 5):
		print "\nWorking on n3lo600"
		input_file = n3lo600_wf
		output_file = n3lo600_azz
 	elif (wf == 6):
		print "\nWorking on Nimj1"
		input_file = nimj1_wf
		output_file = nimj1_azz
 	elif (wf == 7):
		print "\nWorking on Nimj2"
		input_file = nimj2_wf
		output_file = nimj2_azz
 	elif (wf == 8):
		print "\nWorking on Nimj3"
		input_file = nimj3_wf
		output_file = nimj3_azz
	linenum	= 0
	for line in input_file:
		linenum = linenum+1
		columns	= line.split()
		k_fm 	= float(columns[0])
		k_gev	= k_fm*0.197327
		k		= k_gev
		u		= float(columns[1])
		w		= float(columns[2])
		if (wf>1): w = -w
		R		= (2**(0.5)*u*w+w*w/2)/(u*u+w*w)
		azz 	= 0
		r_t0 	= 0
		r_vm 	= 0
		r_vp 	= 0
		if (k<1.1):
#		if (k<1.2 and (linenum%4)==0):
#		if ((wf>1 and (k>0.30 and k<0.31)) or(wf==1 and (k>0.25 and k<0.26))):
			print wf,k,R
#			theta_min	= 0
#			theta_max	= 360
			for theta in range(theta_min,theta_max+1):
#				azz			= 0
#				phi_min		= 0
#				phi_max		= 0
				for phi in range(phi_min,phi_max+1):
#					if ((theta%10) == 0): print wf,k,phi,theta
					k1		= k*math.sin(theta*3.14159/180)*math.sin(phi*3.14159/180)
#					k1		= k*math.sin(theta*3.14159/180)*0
#					k1		= k*math.sin(theta*3.14159/180)
					k2		= k*math.sin(theta*3.14159/180)*math.cos(phi*3.14159/180)
					k1		= (k1**2 + k2**2)**(0.5)
					k2		= 0
#					k2		= k*math.sin(theta*3.14159/180)*1
#					k2		= 0
#					k3		= k*math.sin(theta*3.14159/180)*math.sin(phi*3.14159/180)
					k3		= k*math.cos(theta*3.14159/180)
#					k1		= 0
#					k1		= k**2/m_d
#					k2		= 0
#					k3		= k
#					k3		= k*math.cos(theta*3.14159/180)
#					x		= (((m_d**2+k**2)**(0.5))+k3)/(2*((m_d**2+k**2)**(0.5)))
#					x		= k/0.938
					alpha	= (m_d-(m_n**2+k**2)**(0.5)-k3)/m_n
					x		= (m_d-(m_n**2+k**2)**(0.5)+k3)/m_n
					r_vp	= 1 + ((((3/2)*k1**2 - (3/2)*k2**2)/(k**2))-1)*R
					r_vm	= 1 + ((((3/2)*k1**2 - (3/2)*k2**2)/(k**2))-1)*R
					r_t0	= 1 + ((3*k3**2/(k**2))-1)*R
#					azz		= 1 - ((3/(k_gev**2))*(k3**2 - k1**2 + k2**2) + 1)*R
#					azz		= 1 - ((3/(k_gev**2))*(k3**2) + 1)*R
#					azz		= ((3/(k_gev**2))*(k1**2/2-k3**2))*R
#					azz		= r_t0 - r_vp - r_vm
#					azz		= r_t0 - r_vp
					azz		= azz + (r_vp - r_t0)/((theta_max-theta_min)*(phi_max-phi_min))
#					azz		= azz + (r_vp - r_t0)/(theta_max-theta_min)
#					azz		= azz + (r_vp - r_t0)/(phi_max-phi_min)
#					azz		= (r_vp - r_t0)
#				print >> output_file, theta, azz, r_t0, r_vm, r_vp
#		azz	= azz/(theta_max-theta_min)
			print >> output_file, k, azz, r_t0, r_vm, r_vp


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

