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
import bisect
import time
import statistics
from bisect import bisect_left
from bisect import bisect_right




def find_le(a,x):
	'Find rightmost value less than or equal to x'
	i = bisect_right(a,x)
	if i:
		return i-1
	raise ValueError

def find_ge(a,x):
	'Find leftmost value greater than x'
	i = bisect_left(a,x)
	if i != len(a):
		return i
	raise ValueError

def find_closest(a,x,b,i):
	lt = find_le(a,x)
	gt = find_ge(a,x)
	ltdiff = abs(x-b[lt][0])
	gtdiff = abs(x-b[gt][0])
	if (ltdiff < gtdiff):
		return b[lt][i]
	else:
		return b[gt][i]
	raise ValueError

def get_R_k(a,k,b,i):
	lt		= find_le(a,k)
	gt		= find_ge(a,k)
	klt		= b[lt][0]
	kgt		= b[gt][0]
	ult		= b[lt][2]
	ugt		= b[gt][2]
	wlt		= b[lt][3]
	wgt		= b[gt][3]
	u		= ((ult-ugt)/(klt-kgt))*(k-kgt)+ugt
	w		= ((wlt-wgt)/(klt-kgt))*(k-kgt)+wgt
	R_k		= (2**(0.5)*u*w+w*w/2)/(u*u+w*w)
#	print "get_R_k:",b[lt][1],b[gt][1],R_k
	return R_k
	raise ValueError

	
def index(a, x):
	'Locate the leftmost value exactly equal to x'
	i = bisect_left(a, x)
	if i != len(a) and a[i] == x:
		return i
	raise ValueError

start_time = time.time()
if (os.path.exists("./azz_calc/av18_azz.dat")): os.remove("./azz_calc/av18_azz.dat")
if (os.path.exists("./azz_calc/av18_azz_x.dat")): os.remove("./azz_calc/av18_azz_x.dat")
if (os.path.exists("./azz_calc/fs_azz.dat")): os.remove("./azz_calc/fs_azz.dat")
if (os.path.exists("./azz_calc/fs_azz_x.dat")): os.remove("./azz_calc/fs_azz_x.dat")
if (os.path.exists("./azz_calc/cdbonn_azz.dat")): os.remove("./azz_calc/cdbonn_azz.dat")
if (os.path.exists("./azz_calc/cdbonn_azz_x.dat")): os.remove("./azz_calc/cdbonn_azz_x.dat")
if (os.path.exists("./azz_calc/n3lo500_azz.dat")): os.remove("./azz_calc/n3lo500_azz.dat")
if (os.path.exists("./azz_calc/n3lo500_azz_x.dat")): os.remove("./azz_calc/n3lo500_azz_x.dat")
if (os.path.exists("./azz_calc/n3lo600_azz.dat")): os.remove("./azz_calc/n3lo600_azz.dat")
if (os.path.exists("./azz_calc/n3lo600_azz_x.dat")): os.remove("./azz_calc/n3lo600_azz_x.dat")
if (os.path.exists("./azz_calc/nimj1_azz.dat")): os.remove("./azz_calc/nimj1_azz.dat")
if (os.path.exists("./azz_calc/nimj1_azz_x.dat")): os.remove("./azz_calc/nimj1_azz_x.dat")
if (os.path.exists("./azz_calc/nimj2_azz.dat")): os.remove("./azz_calc/nimj2_azz.dat")
if (os.path.exists("./azz_calc/nimj2_azz_x.dat")): os.remove("./azz_calc/nimj2_azz_x.dat")
if (os.path.exists("./azz_calc/nimj3_azz.dat")): os.remove("./azz_calc/nimj3_azz.dat")
if (os.path.exists("./azz_calc/nimj3_azz_x.dat")): os.remove("./azz_calc/nimj3_azz_x.dat")

av18_wf			= open("./col_wfs/dwav_av18_term.data", "r")
av18_azz		= open("./azz_calc/av18_azz.dat", "wb")
av18_azz_x		= open("./azz_calc/av18_azz_x.dat", "wb")
fs_wf			= open("./col_wfs/frankfurt_strikman.data", "r")
fs_azz			= open("./azz_calc/fs_azz.dat", "wb")
fs_azz_x		= open("./azz_calc/fs_azz_x.dat", "wb")
cdbonn_wf		= open("./col_wfs/dwav_cdb_term.data", "r")
cdbonn_azz		= open("./azz_calc/cdbonn_azz.dat", "wb")
cdbonn_azz_x	= open("./azz_calc/cdbonn_azz_x.dat", "wb")
n3lo500_wf		= open("./col_wfs/dwav_n3lo500_term.data", "r")
n3lo500_azz		= open("./azz_calc/n3lo500_azz.dat", "wb")
n3lo500_azz_x	= open("./azz_calc/n3lo500_azz_x.dat", "wb")
n3lo600_wf		= open("./col_wfs/dwav_n3lo600_term.data", "r")
n3lo600_azz		= open("./azz_calc/n3lo600_azz.dat", "wb")
n3lo600_azz_x	= open("./azz_calc/n3lo600_azz_x.dat", "wb")
nimj1_wf		= open("./col_wfs/dwav_nimj1_term.data", "r")
nimj1_azz		= open("./azz_calc/nimj1_azz.dat", "wb")
nimj1_azz_x		= open("./azz_calc/nimj1_azz_x.dat", "wb")
nimj2_wf		= open("./col_wfs/dwav_nimj2_term.data", "r")
nimj2_azz		= open("./azz_calc/nimj2_azz.dat", "wb")
nimj2_azz_x		= open("./azz_calc/nimj2_azz_x.dat", "wb")
nimj3_wf		= open("./col_wfs/dwav_nimj3_term.data", "r")
nimj3_azz		= open("./azz_calc/nimj3_azz.dat", "wb")
nimj3_azz_x		= open("./azz_calc/nimj3_azz_x.dat", "wb")

input_file = av18_wf
output_file = av18_azz

m_d			= 1.876
m_n			= 0.939
theta		= 90
theta_min	= 0
theta_max	= 180
theta_bins	= 10
phi			= 180
phi_min		= 0
phi_max		= 360
p_list		= []
R_klist		= []
alpha_list	= []
azz_alpha	= []
azz_stat	= []
azz_x		= []

xalpha	= []
for i in range (1,2000):
	x		= i/1000.0
	q2		= 1.5 # (GeV/c)^2
	q0		= q2/(2.0*m_n*x) # GeV
	q3		= (q2+q2**2/(4*m_n**2*x**2))**(0.5) # GeV
	qm		= q0 - q3
	w		= (4*m_n**2+4*q0*m_n-q2)**(0.5)
	alpha	= 2 - ((qm+2*m_n)/(2*m_n))*(1+((w**2-4*m_n**2)**(0.5))/w)
	alpha = float("%.2f" % round(alpha,2))
	xalpha.append(alpha)
#	azz_x.append([x,0,0,0,0,0])

for wf in range(1,9):
#for wf in range(2,3):
	new_start_time = time.time()
	if (wf == 1):
		print "\nWorking on F&S"
		input_file = fs_wf
		output_file = fs_azz
		output_file1 = fs_azz_x
 	elif (wf == 2):
		print "\nWorking on AV18"
		input_file = av18_wf
		output_file = av18_azz
		output_file1 = av18_azz_x
 	elif (wf == 3):
		print "\nWorking on CDBonn"
		input_file = cdbonn_wf
		output_file = cdbonn_azz
		output_file1 = cdbonn_azz_x
 	elif (wf == 4):
		print "\nWorking on n3lo500"
		input_file = n3lo500_wf
		output_file = n3lo500_azz
		output_file1 = n3lo500_azz_x
 	elif (wf == 5):
		print "\nWorking on n3lo600"
		input_file = n3lo600_wf
		output_file = n3lo600_azz
		output_file1 = n3lo600_azz_x
 	elif (wf == 6):
		print "\nWorking on Nimj1"
		input_file = nimj1_wf
		output_file = nimj1_azz
		output_file1 = nimj1_azz_x
 	elif (wf == 7):
		print "\nWorking on Nimj2"
		input_file = nimj2_wf
		output_file = nimj2_azz
		output_file1 = nimj2_azz_x
 	elif (wf == 8):
		print "\nWorking on Nimj3"
		input_file = nimj3_wf
		output_file = nimj3_azz
		output_file1 = nimj3_azz_x
	linenum	= int(0)
	p_list[:]		= []
	R_klist[:]		= []
	alpha_list[:]	= []
	azz_alpha[:]	= []
	azz_stat[:]	= []
	azz_x[:]	= []
	for line in input_file:
		linenum = linenum+1
		columns	= line.split()
		p_fm 	= float(columns[0])
		p_gev	= p_fm*0.197327
		p		= p_gev
		u		= float(columns[1])
		w		= float(columns[2])
		if (wf>1): w = -w
		R_p		= (2**(0.5)*u*w+w*w/2)/(u*u+w*w)
		p_list.append(p)
		R_klist.append([p,R_p,u,w])
	for i in range(1,len(R_klist)):
		p		= R_klist[i][0]
		R_p		= R_klist[i][1]
		alpha 	= 0.0
		azz 	= 0.0
		r_t0 	= 0.0
		r_vm 	= 0.0
		r_vp 	= 0.0
		if (i>1): 
			pbef	= (R_klist[i-1][0] - R_klist[i][0])/2.0+R_klist[i-1][0]
		elif (i==1):
			pbef	= 0
		if (i==len(R_klist)): 
			paft	= R_klist[i][0]
		elif (i<len(R_klist)):
			paft	= (R_klist[i-1][0] - R_klist[i][0])/2.0+R_klist[i][0]
		p_bin	= paft-pbef
		if (p>0):
#		if (p>0 and p<0.7):
#		if (p>0 and p<0.01):
#		if (p>0 and p<1.2):
#		if (p<1.2 and (linenum%4)==0):
#		if ((wf>1 and (p>0.25 and p<0.26)) or(wf==1 and (p>0.20 and p<0.21))):
#		if (p>0.20 and p<0.21):
#		if (p>0.25 and p<0.26):
#		if (p>0.29 and p<0.30):
#		if (p>0.34 and p<0.35):
#		if (p>0.48 and p<0.49):
#		if ((wf>1 and (p>0.30 and p<0.31)) or(wf==1 and (p>0.25 and p<0.26))):
#		if ((wf>1 and (p>0.34 and p<0.35)) or(wf==1 and (p>0.29 and p<0.30))):
#		if ((wf>1 and (p>0.48 and p<0.49)) or(wf==1 and (p>0.49 and p<0.50))):
#			print "wf	p		R_p"
#			print wf,p,R_p
#			theta_min	= 180
#			theta_max	= 180
			theta_max = 180*theta_bins
			for theta_calc in range(theta_min,theta_max+1):
				theta = 1.0*theta_calc/theta_bins
				azz			= 0.0
#				p1		= p*math.sin(theta*3.14159/180)*math.sin(phi*3.14159/180)
#				p2		= p*math.sin(theta*3.14159/180)*math.cos(phi*3.14159/180)
#				pt		= (p1**2 + p2**2)**(0.5)
				pt		= p*math.sin(theta*3.14159/180)
				p3		= p*math.cos(theta*3.14159/180)
#				alpha	= (m_d-(m_n**2+p**2)**(0.5)-p3)/m_n
#				print alpha, theta, phi
				alpha	= (2*((m_n**2+p**2)**(0.5)-p3))/m_d
				try:
					kt		= pt
#					print  p,((m_n**2+kt**2)/(alpha*(2-alpha))),m_n**2
					k		= ((m_n**2+kt**2)/(alpha*(2-alpha))-m_n**2)**(0.5)
					R_k		= get_R_k(p_list,k,R_klist,1)
#					print  wf,theta,k,find_closest(p_list,k,R_klist,0),R_k
					k_sq	=  (m_n**2+kt**2)/(alpha*(2-alpha))-m_n**2
#					k3		= (k_sq-kt**2)**(0.5)
					k3_sq	= (k_sq-kt**2)
				except Exception:
					continue
#					k		= 0
#					k_sq	= 0.0001
#					k3_sq	= 0
#					kt		= 0
				
#				vvvvvvv Relativistic vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
				r_vp	= 1 + ((((3/2)*(kt**2))/(k_sq))-1)*R_k
				r_vm	= 1 + ((((3/2)*(kt**2))/(k_sq))-1)*R_k
				r_t0	= 1 + ((3*(k3_sq)/(k_sq))-1)*R_k
#				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
				
#				vvvvvvv Non-Relativistic vvvvvvvvvvvvvvvvvvvvvvvvvv
#				r_vp	= 1 + ((((3/2)*(pt**2))/(p**2))-1)*R_p
#				r_vm	= 1 + ((((3/2)*(pt**2))/(p**2))-1)*R_p
#				r_t0	= 1 + ((3*(p3**2)/(p**2))-1)*R_p
#				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
				
#				azz		= 2.0/3.0*(r_t0 - r_vp)
#				azz		= (r_vp - r_t0)
				azz		= (r_vp - r_t0)*(1.0/theta_bins)*p_bin
#				azz		= (r_vp - r_t0)/((theta_max-theta_min)*theta_bins)
#				azz		= azz + (r_vp - r_t0)/(theta_max-theta_min)
				alpha = float("%.2f" % round(alpha,2))
#				print alpha
				if (alpha<1.47):
					try:
						azz_alpha[index(alpha_list,alpha)][1] = azz_alpha[index(alpha_list,alpha)][1] + 1
						azz_alpha[index(alpha_list,alpha)][2] = azz_alpha[index(alpha_list,alpha)][2] + azz
						azz_alpha[index(alpha_list,alpha)][3] = azz_alpha[index(alpha_list,alpha)][3] + r_vp
						azz_alpha[index(alpha_list,alpha)][4] = azz_alpha[index(alpha_list,alpha)][4] + r_vm
						azz_alpha[index(alpha_list,alpha)][5] = azz_alpha[index(alpha_list,alpha)][5] + r_t0
						azz_stat[index(alpha_list,alpha)][0]  = alpha
						azz_stat[index(alpha_list,alpha)][1].append(azz)
					except Exception:
						pos		= bisect.bisect(alpha_list,alpha)
						bisect.insort(alpha_list,alpha)
#						bisect.insort(azz_alpha,[alpha,1,azz,r_vp,r_vm,r_t0])
						bisect.insort(azz_alpha,[alpha,1,azz,r_vp,r_vm,r_t0,0])
						bisect.insort(azz_stat,[alpha,[azz]])
#				print len(azz_alpha),len(alpha_list)	
#				print pos,alpha
#				print >> output_file, k, azz, r_t0, r_vm, r_vp
#				print >> output_file, theta, azz, r_t0, r_vm, r_vp
#			print >> output_file, p, azz, r_t0, r_vm, r_vp
	# ADD ALPHA/X STUFF HERE
	for i in range (0,len(azz_alpha)):
		alpha	= azz_alpha[i][0]
#		azz		= azz_alpha[i][2]/azz_alpha[i][1]
#		r_vp	= azz_alpha[i][3]/azz_alpha[i][1]
#		r_vm	= azz_alpha[i][4]/azz_alpha[i][1]
#		r_t0	= azz_alpha[i][5]/azz_alpha[i][1]
		azz		= azz_alpha[i][2]
		r_vp	= azz_alpha[i][3]
		r_vm	= azz_alpha[i][4]
		r_t0	= azz_alpha[i][5]
		e_azz	= 1/(azz_alpha[i][1])**(0.5)
#		e_azz	= statistics.stdev(azz_stat[i][1])
		ave_azz	= statistics.mean(azz_stat[i][1])
#		if (alpha < 1.47): print >> output_file, alpha, azz, r_t0, r_vm, r_vp, azz_alpha[i][1]
		try:
			x		= index(xalpha,alpha)/1000.0
			pos		= bisect.insort(azz_x,[x,azz,r_vp,r_vm,r_t0,e_azz,ave_azz])
			azz_alpha[i][6] = x
#			print >> output_file, alpha, azz, r_t0, r_vm, r_vp, azz_alpha[i][1], x
			print >> output_file, alpha, azz, r_t0, r_vm, r_vp, e_azz, x
		except Exception:
			warning = "alpha > 1.47 Not Allowed"
	for i in range(0,len(azz_x)):
#		the_azz = -2.0/3.0*azz_x[i][1]
#		print >> output_file, azz_x[i][0], azz_x[i][1], azz_x[i][4], azz_x[i][3], azz_x[i][2]
#		print >> output_file1, azz_x[i][0], -2.0/3*azz_x[i][1], azz_x[i][4], azz_x[i][3], azz_x[i][2]
		print >> output_file1, azz_x[i][0], -2.0/3*azz_x[i][1], azz_x[i][4], azz_x[i][3], 2.0/3*azz_x[i][5], -2.0/3*azz_x[i][6]
	end_time = time.time()
	print("     Total elapsed time so far:    %.2f seconds" % (end_time - start_time))
	print("                                   (%.2f minutes)" % (float((end_time - start_time))/60.0))
	print("     Elapsed time in this section: %.2f seconds" % (end_time - new_start_time))
	print("                                   (%.2f minutes)" % (float((end_time - start_time))/60.0))
#	print azz_stat

print "Theta Bins:",180*theta_bins,"\n"

#print "Warning:",warning,"\n"

#print xalpha



av18_wf.close()
av18_azz.close()
av18_azz_x.close()
fs_wf.close()
fs_azz.close()
fs_azz_x.close()
cdbonn_wf.close()
cdbonn_azz.close()
cdbonn_azz_x.close()
n3lo500_wf.close()
n3lo500_azz.close()
n3lo500_azz_x.close()
n3lo600_wf.close()
n3lo600_azz.close()
n3lo600_azz_x.close()
nimj1_wf.close()
nimj1_azz.close()
nimj1_azz_x.close()
nimj2_wf.close()
nimj2_azz.close()
nimj2_azz_x.close()
nimj3_wf.close()
nimj3_azz.close()
nimj3_azz_x.close()


end_time = time.time()
print("Elapsed time was %.2f seconds" % (end_time - start_time))
print("                 (%.2f minutes)\n" % (float((end_time - start_time))/60.0))
