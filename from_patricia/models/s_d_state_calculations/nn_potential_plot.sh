#!/bin/sh

# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#
# nn_potential_plot.sh
#
# This script plots the nucleon-nucleon potential vs. momentum for a
# variety of models. The *.data files were obtained from Donal Day.
#
# Elena Long
# ellie@jlab.org
# 4/24/2014
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

# Bonn Potential
file0="/home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/mom_dist_bonn_mevc.data"
#  1 = momentum (k)
#  2 = psi^2_s
#  3 = psi^2_d
#  4 = psi^2_tot
awk '$1>0 && $1<2000 {print $1,$2}'  $file0 >> temp_bonn_s_sq
awk '$1>0 && $1<2000 {print $1,$3}'  $file0 >> temp_bonn_d_sq
awk '$1>0 && $1<2000 {print $1,$4}'  $file0 >> temp_bonn_tot_sq

# CD-Bonn Potential
file1="/home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/mom_dist_cdbonn_mevc.data"
#  1 = momentum (k)
#  2 = psi^2_s
#  3 = psi^2_d
#  4 = psi^2_tot
awk '$1>0 && $1<2000 {print $1,$2}'  $file1 >> temp_cdbonn_s_sq
awk '$1>0 && $1<2000 {print $1,$3}'  $file1 >> temp_cdbonn_d_sq
awk '$1>0 && $1<2000 {print $1,$4}'  $file1 >> temp_cdbonn_tot_sq

# Paris Potential
file2="/home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/mom_dist_paris_mevc.data"
#  1 = momentum (k)
#  2 = psi^2_s
#  3 = psi^2_d
#  4 = psi^2_tot
awk '$1>0 && $1<2000 {print $1,$2}'  $file2 >> temp_paris_s_sq
awk '$1>0 && $1<2000 {print $1,$3}'  $file2 >> temp_paris_d_sq
awk '$1>0 && $1<2000 {print $1,$4}'  $file2 >> temp_paris_tot_sq

# Argonne V18 Potential
#file3="/home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/mom_dist_v18_mevc.data"
#  1 = momentum (k)
#  2 = psi^2_s
#  3 = psi^2_d
#  4 = psi^2_tot
#awk '$1>0 && $1<2000 {print $1,$2}'  $file3 >> temp_av18_s_sq
#awk '$1>0 && $1<2000 {print $1,$3}'  $file3 >> temp_av18_d_sq
#awk '$1>0 && $1<2000 {print $1,$4}'  $file3 >> temp_av18_tot_sq
file3="/home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/dwav_av18_term.data"
awk '$1>0 && $1<2000 {print $1*197.327,$2*$2}'  $file3 >> temp_av18_s_sq
awk '$1>0 && $1<2000 {print $1*197.327,$3*$3}'  $file3 >> temp_av18_d_sq
awk '$1>0 && $1<2000 {print $1*197.327,$2*$2+$3*$3}'  $file3 >> temp_av18_tot_sq

# N3LO500 Potential (Chiral Perturbation)
file4="/home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/dwav_n3lo500_term.data"
#  1 = momentum (fm-1)
#  2 = 3s1 (fm**3/2)
#  3 = 2d1 (fm**3/2)
awk '$1>0 && $1<2000 {print $1*197.327,$2*$2}'  $file4 >> temp_nlo500_s_sq
awk '$1>0 && $1<2000 {print $1*197.327,$3*$3}'  $file4 >> temp_nlo500_d_sq
awk '$1>0 && $1<2000 {print $1*197.327,$2*$2+$3*$3}'  $file4 >> temp_nlo500_tot_sq

# N3LO600 Potential (Chiral Perturbation)
file5="/home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/dwav_n3lo600_term.data"
#  1 = momentum (fm-1)
#  2 = 3s1 (fm**3/2)
#  3 = 2d1 (fm**3/2)
awk '$1>0 && $1<2000 {print $1*197.327,$2*$2}'  $file5 >> temp_nlo600_s_sq
awk '$1>0 && $1<2000 {print $1*197.327,$3*$3}'  $file5 >> temp_nlo600_d_sq
awk '$1>0 && $1<2000 {print $1*197.327,$2*$2+$3*$3}'  $file5 >> temp_nlo600_tot_sq

# Nijmegen1 Potential 
file6="/home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/dwav_nimj1_term.data"
#  1 = momentum (fm-1)
#  2 = 3s1 (fm**3/2)
#  3 = 2d1 (fm**3/2)
awk '$1>0 && $1<2000 {print $1*197.327,$2*$2}'  $file6 >> temp_nimj1_s_sq
awk '$1>0 && $1<2000 {print $1*197.327,$3*$3}'  $file6 >> temp_nimj1_d_sq
awk '$1>0 && $1<2000 {print $1*197.327,$2*$2+$3*$3}'  $file6 >> temp_nimj1_tot_sq

# Nijmegen2 Potential 
file7="/home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/dwav_nimj2_term.data"
#  1 = momentum (fm-1)
#  2 = 3s1 (fm**3/2)
#  3 = 2d1 (fm**3/2)
awk '$1>0 && $1<2000 {print $1*197.327,$2*$2}'  $file7 >> temp_nimj2_s_sq
awk '$1>0 && $1<2000 {print $1*197.327,$3*$3}'  $file7 >> temp_nimj2_d_sq
awk '$1>0 && $1<2000 {print $1*197.327,$2*$2+$3*$3}'  $file7 >> temp_nimj2_tot_sq

# Nijmegen3 Potential 
file8="/home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/dwav_nimj3_term.data"
#  1 = momentum (fm-1)
#  2 = 3s1 (fm**3/2)
#  3 = 2d1 (fm**3/2)
awk '$1>0 && $1<2000 {print $1*197.327,$2*$2}'  $file8 >> temp_nimj3_s_sq
awk '$1>0 && $1<2000 {print $1*197.327,$3*$3}'  $file8 >> temp_nimj3_d_sq
awk '$1>0 && $1<2000 {print $1*197.327,$2*$2+$3*$3}'  $file8 >> temp_nimj3_tot_sq



# --------------------------------------------------

# Bonn Potential
file10="/home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/mom_dist_bonn_mevc_uw.data"
#  1 = momentum (k)
#  2 = psi_s
#  3 = psi_d
#  4 = psi_tot
awk '$1>0 && $1<2000 {print $1,$2}'  $file10 >> temp_bonn_s
awk '$1>0 && $1<2000 {print $1,$3}'  $file10 >> temp_bonn_d
awk '$1>0 && $1<2000 {print $1,$2+$3}'  $file10 >> temp_bonn_tot

# CD-Bonn Potential
file11="/home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/mom_dist_cdbonn_mevc_uw.data"
#file11="/home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/mom_dist_v18_mevc.data"
#file11="/home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/av18_web.data"
#  1 = momentum (k)
#  2 = psi_s
#  3 = psi_d
#  4 = psi_tot
awk '$1>0 && $1<2000 {print $1,$2}'  $file11 >> temp_cdbonn_s
awk '$1>0 && $1<2000 {print $1,$3}'  $file11 >> temp_cdbonn_d
awk '$1>0 && $1<2000 {print $1,$2+$3}'  $file11 >> temp_cdbonn_tot

# Paris Potential
#file12="/home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/mom_dist_paris_mevc_uw.data"
file12="/home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/mom_dist_v18_mevc_uw.data"
#  1 = momentum (k)
#  2 = psi_s
#  3 = psi_d
#  4 = psi_tot
awk '$1>0 && $1<2000 {print $1,$2}'  $file12 >> temp_paris_s
awk '$1>0 && $1<2000 {print $1,$3}'  $file12 >> temp_paris_d
awk '$1>0 && $1<2000 {print $1,$2+$3}'  $file12 >> temp_paris_tot

# Argonne V18 Potential
#file13="/home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/mom_dist_v18_mevc_uw.data"
#  1 = momentum (k)
#  2 = psi_s
#  3 = psi_d
#  4 = psi_tot
#awk '$1>0 && $1<2000 {print $1,$2}'  $file13 >> temp_av18_s
#awk '$1>0 && $1<2000 {print $1,$3}'  $file13 >> temp_av18_d
#awk '$1>0 && $1<2000 {print $1,$2+$3}'  $file13 >> temp_av18_tot
file13="/home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/dwav_av18_term.data"
awk '$1>0 && $1<2000 {print $1*197.327,$2*0.00036}'  $file13 >> temp_av18_s
awk '$1>0 && $1<2000 {print $1*197.327,$3*0.00036}'  $file13 >> temp_av18_d
awk '$1>0 && $1<2000 {print $1*197.237,$2*0.00036+$3*0.00036}'  $file13 >> temp_av18_tot

# N3LO500 Potential (Chiral Perturbation)
file14="/home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/dwav_n3lo500_term.data"
#  1 = momentum (fm-1)
#  2 = 3s1 (fm**3/2)
#  3 = 2d1 (fm**3/2)
awk '$1>0 && $1<2000 {print $1*197.327,$2}'  $file14 >> temp_nlo500_s
awk '$1>0 && $1<2000 {print $1*197.327,$3}'  $file14 >> temp_nlo500_d
awk '$1>0 && $1<2000 {print $1*197.327,$2+$3}'  $file14 >> temp_nlo500_tot

# N3LO600 Potential (Chiral Perturbation)
file15="/home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/dwav_n3lo600_term.data"
#  1 = momentum (fm-1)
#  2 = 3s1 (fm**3/2)
#  3 = 2d1 (fm**3/2)
awk '$1>0 && $1<2000 {print $1*197.327,$2}'  $file15 >> temp_nlo600_s
awk '$1>0 && $1<2000 {print $1*197.327,$3}'  $file15 >> temp_nlo600_d
awk '$1>0 && $1<2000 {print $1*197.327,$2+$3}'  $file15 >> temp_nlo600_tot

# Nijmegen1 Potential 
file16="/home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/dwav_nimj1_term.data"
#  1 = momentum (fm-1)
#  2 = 3s1 (fm**3/2)
#  3 = 2d1 (fm**3/2)
awk '$1>0 && $1<2000 {print $1*197.327,$2}'  $file16 >> temp_nimj1_s
awk '$1>0 && $1<2000 {print $1*197.327,$3}'  $file16 >> temp_nimj1_d
awk '$1>0 && $1<2000 {print $1*197.327,$2+$3}'  $file16 >> temp_nimj1_tot

# Nijmegen2 Potential 
file17="/home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/dwav_nimj2_term.data"
#  1 = momentum (fm-1)
#  2 = 3s1 (fm**3/2)
#  3 = 2d1 (fm**3/2)
awk '$1>0 && $1<2000 {print $1*197.327,$2}'  $file17 >> temp_nimj2_s
awk '$1>0 && $1<2000 {print $1*197.327,$3}'  $file17 >> temp_nimj2_d
awk '$1>0 && $1<2000 {print $1*197.327,$2+$3}'  $file17 >> temp_nimj2_tot

# Nijmegen3 Potential 
file18="/home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/dwav_nimj3_term.data"
#  1 = momentum (fm-1)
#  2 = 3s1 (fm**3/2)
#  3 = 2d1 (fm**3/2)
awk '$1>0 && $1<2000 {print $1*197.327,$2}'  $file18 >> temp_nimj3_s
awk '$1>0 && $1<2000 {print $1*197.327,$3}'  $file18 >> temp_nimj3_d
awk '$1>0 && $1<2000 {print $1*197.327,$2+$3}'  $file18 >> temp_nimj3_tot





#gracebat -hdevice PNG -printfile cs_check.png \
#xmgrace\
#	-settype xy		-block temp_sigma_d_pol			-log y 	-graph 0 -bxy 1:2\
#	-settype xy		-block temp_sigma_d_unpol		-log y 	-graph 0 -bxy 1:2\
#	-settype xy		-block temp_sigma_n				-log y	-graph 0 -bxy 1:2\
#	-settype xy		-block temp_sigma_he			-log y	-graph 0 -bxy 1:2\
#	-settype xy		-block temp_misak_d_x			-log y	-graph 0 -bxy 1:2\
#	-settype xy		-block temp_misak_n_x			-log y	-graph 0 -bxy 1:2\
#	-settype xydy	-block temp_sigma_d_exp_x		-log y	-graph 0 -bxy 1:2:3\
#	-settype xy		-block temp_src_n						-graph 1 -bxy 1:2\
#	-settype xy		-block temp_src_he						-graph 1 -bxy 1:2\
#	-settype xy		-block temp_src_c						-graph 1 -bxy 1:2\
#	-p /home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/cs_check_src.par -noask

#gracebat -hdevice PNG -printfile cs_check.png \
xmgrace\
	-settype xy		-block temp_bonn_s_sq		-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_bonn_d_sq		-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_bonn_tot_sq		-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_cdbonn_s_sq		-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_cdbonn_d_sq		-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_cdbonn_tot_sq	-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_paris_s_sq		-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_paris_d_sq		-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_paris_tot_sq	-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_av18_s_sq		-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_av18_d_sq		-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_av18_tot_sq		-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_nlo500_s_sq		-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_nlo500_d_sq		-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_nlo500_tot_sq	-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_nlo600_s_sq		-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_nlo600_d_sq		-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_nlo600_tot_sq	-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_nimj1_s_sq		-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_nimj1_d_sq		-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_nimj1_tot_sq	-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_nimj2_s_sq		-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_nimj2_d_sq		-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_nimj2_tot_sq	-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_nimj3_s_sq		-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_nimj3_d_sq		-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_nimj3_tot_sq	-log y		-graph 0 -bxy 1:2\
	-settype xy		-block temp_bonn_tot_sq		-log y		-graph 1 -bxy 1:2\
	-settype xy		-block temp_cdbonn_tot_sq	-log y		-graph 1 -bxy 1:2\
	-settype xy		-block temp_paris_tot_sq	-log y		-graph 1 -bxy 1:2\
	-settype xy		-block temp_av18_tot_sq		-log y		-graph 1 -bxy 1:2\
	-settype xy		-block temp_nlo500_tot_sq	-log y		-graph 1 -bxy 1:2\
	-settype xy		-block temp_nlo600_tot_sq	-log y		-graph 1 -bxy 1:2\
	-settype xy		-block temp_nimj1_tot_sq	-log y		-graph 1 -bxy 1:2\
	-settype xy		-block temp_nimj2_tot_sq	-log y		-graph 1 -bxy 1:2\
	-settype xy		-block temp_nimj3_tot_sq	-log y		-graph 1 -bxy 1:2\
	-settype xy		-block temp_bonn_s_sq		-log y		-graph 2 -bxy 1:2\
	-settype xy		-block temp_cdbonn_s_sq		-log y		-graph 2 -bxy 1:2\
	-settype xy		-block temp_paris_s_sq		-log y		-graph 2 -bxy 1:2\
	-settype xy		-block temp_av18_s_sq		-log y		-graph 2 -bxy 1:2\
	-settype xy		-block temp_nlo500_s_sq		-log y		-graph 2 -bxy 1:2\
	-settype xy		-block temp_nlo600_s_sq		-log y		-graph 2 -bxy 1:2\
	-settype xy		-block temp_nimj1_s_sq		-log y		-graph 2 -bxy 1:2\
	-settype xy		-block temp_nimj2_s_sq		-log y		-graph 2 -bxy 1:2\
	-settype xy		-block temp_nimj3_s_sq		-log y		-graph 2 -bxy 1:2\
	-settype xy		-block temp_bonn_d_sq		-log y		-graph 3 -bxy 1:2\
	-settype xy		-block temp_cdbonn_d_sq		-log y		-graph 3 -bxy 1:2\
	-settype xy		-block temp_paris_d_sq		-log y		-graph 3 -bxy 1:2\
	-settype xy		-block temp_av18_d_sq		-log y		-graph 3 -bxy 1:2\
	-settype xy		-block temp_nlo500_d_sq		-log y		-graph 3 -bxy 1:2\
	-settype xy		-block temp_nlo600_d_sq		-log y		-graph 3 -bxy 1:2\
	-settype xy		-block temp_nimj1_d_sq		-log y		-graph 3 -bxy 1:2\
	-settype xy		-block temp_nimj2_d_sq		-log y		-graph 3 -bxy 1:2\
	-settype xy		-block temp_nimj3_d_sq		-log y		-graph 3 -bxy 1:2\
	-p /home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/nn_potential_plot.par -noask

xmgrace\
	-settype xy		-block temp_bonn_s						-graph 0 -bxy 1:2\
	-settype xy		-block temp_bonn_d						-graph 0 -bxy 1:2\
	-settype xy		-block temp_bonn_tot					-graph 0 -bxy 1:2\
	-settype xy		-block temp_cdbonn_s					-graph 0 -bxy 1:2\
	-settype xy		-block temp_cdbonn_d					-graph 0 -bxy 1:2\
	-settype xy		-block temp_cdbonn_tot					-graph 0 -bxy 1:2\
	-settype xy		-block temp_paris_s						-graph 0 -bxy 1:2\
	-settype xy		-block temp_paris_d						-graph 0 -bxy 1:2\
	-settype xy		-block temp_paris_tot					-graph 0 -bxy 1:2\
	-settype xy		-block temp_av18_s						-graph 0 -bxy 1:2\
	-settype xy		-block temp_av18_d						-graph 0 -bxy 1:2\
	-settype xy		-block temp_av18_tot					-graph 0 -bxy 1:2\
	-settype xy		-block temp_nlo500_s					-graph 0 -bxy 1:2\
	-settype xy		-block temp_nlo500_d					-graph 0 -bxy 1:2\
	-settype xy		-block temp_nlo500_tot					-graph 0 -bxy 1:2\
	-settype xy		-block temp_nlo600_s					-graph 0 -bxy 1:2\
	-settype xy		-block temp_nlo600_d					-graph 0 -bxy 1:2\
	-settype xy		-block temp_nlo600_tot					-graph 0 -bxy 1:2\
	-settype xy		-block temp_nimj1_s						-graph 0 -bxy 1:2\
	-settype xy		-block temp_nimj1_d						-graph 0 -bxy 1:2\
	-settype xy		-block temp_nimj1_tot					-graph 0 -bxy 1:2\
	-settype xy		-block temp_nimj2_s						-graph 0 -bxy 1:2\
	-settype xy		-block temp_nimj2_d						-graph 0 -bxy 1:2\
	-settype xy		-block temp_nimj2_tot					-graph 0 -bxy 1:2\
	-settype xy		-block temp_nimj3_s						-graph 0 -bxy 1:2\
	-settype xy		-block temp_nimj3_d						-graph 0 -bxy 1:2\
	-settype xy		-block temp_nimj3_tot					-graph 0 -bxy 1:2\
	-settype xy		-block temp_bonn_tot					-graph 1 -bxy 1:2\
	-settype xy		-block temp_cdbonn_tot					-graph 1 -bxy 1:2\
	-settype xy		-block temp_paris_tot					-graph 1 -bxy 1:2\
	-settype xy		-block temp_av18_tot					-graph 1 -bxy 1:2\
	-settype xy		-block temp_nlo500_tot					-graph 1 -bxy 1:2\
	-settype xy		-block temp_nlo600_tot					-graph 1 -bxy 1:2\
	-settype xy		-block temp_nimj1_tot					-graph 1 -bxy 1:2\
	-settype xy		-block temp_nimj2_tot					-graph 1 -bxy 1:2\
	-settype xy		-block temp_nimj3_tot					-graph 1 -bxy 1:2\
	-settype xy		-block temp_bonn_s						-graph 2 -bxy 1:2\
	-settype xy		-block temp_cdbonn_s					-graph 2 -bxy 1:2\
	-settype xy		-block temp_paris_s						-graph 2 -bxy 1:2\
	-settype xy		-block temp_av18_s						-graph 2 -bxy 1:2\
	-settype xy		-block temp_nlo500_s					-graph 2 -bxy 1:2\
	-settype xy		-block temp_nlo600_s					-graph 2 -bxy 1:2\
	-settype xy		-block temp_nimj1_s						-graph 2 -bxy 1:2\
	-settype xy		-block temp_nimj2_s						-graph 2 -bxy 1:2\
	-settype xy		-block temp_nimj3_s						-graph 2 -bxy 1:2\
	-settype xy		-block temp_bonn_d						-graph 3 -bxy 1:2\
	-settype xy		-block temp_cdbonn_d					-graph 3 -bxy 1:2\
	-settype xy		-block temp_paris_d						-graph 3 -bxy 1:2\
	-settype xy		-block temp_av18_d						-graph 3 -bxy 1:2\
	-settype xy		-block temp_nlo500_d					-graph 3 -bxy 1:2\
	-settype xy		-block temp_nlo600_d					-graph 3 -bxy 1:2\
	-settype xy		-block temp_nimj1_d						-graph 3 -bxy 1:2\
	-settype xy		-block temp_nimj2_d						-graph 3 -bxy 1:2\
	-settype xy		-block temp_nimj3_d						-graph 3 -bxy 1:2\
	-p /home/ellie/physics/b1/b1_rates/from_patricia/models/s_d_state_calculations/nn_potential_plot2.par -noask



#xmgrace\
#	-settype xy		-block temp_sigma_d_unpol_nu	-log y 	-graph 0 -bxy 1:2\
#	-settype xy		-block temp_misak_d_nu			-log y 	-graph 0 -bxy 1:2\
#	-settype xydy	-block temp_sigma_d_exp_nu		-log y	-graph 0 -bxy 1:2:3\
#	-settype xy		-block temp_sigma_d_unpol_nu	-log y 	-graph 1 -bxy 1:2\
#	-settype xy		-block temp_misak_d_nu			-log y 	-graph 1 -bxy 1:2\
#	-settype xydy	-block temp_sigma_d_exp_nu		-log y	-graph 1 -bxy 1:2:3\
#	-p /home/ellie/physics/b1/b1_rates/from_patricia/rates/scripts/cs_check_nu.par -noask

#display cs_check.png

rm temp*

