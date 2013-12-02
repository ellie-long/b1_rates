#!/bin/sh

file0="../../models/SCRIPTS/table2.dat"
awk '$1!="#" {print $1,$6,$7}' $file0 > xb1_stat
awk '$1!="#" {print $1,$6,sqrt($7*$7+$8*$8)}' $file0 > xb1_tot

file1="../../models/output/b1model_kumano.dat"
awk '$1==1 && $2!=0.0{print $2,$6/$2}' $file1 > model_nosea_cteq
awk '$1==1 && $2!=0.0 {print $2,$10/$2}' $file1 > model_sea_cteq
awk '$1==2 && $2!=0.0 {print $2,$6/$2}' $file1 > model_nosea_mrst
awk '$1==2 && $2!=0.0 {print $2,$10/$2}' $file1 > model_sea_mrst
awk '$1==3 && $2!=0.0 {print $2,$6/$2}' $file1 > model_nosea_mstw
awk '$1==3 && $2!=0.0 {print $2,$10/$2}' $file1 > model_sea_mstw

file2="../../models/Miller_newtable/miller_nov11_2010.dat"
awk '$1!=0.9 {print $2,$3}' $file2 > model_miller

file4="../output/prop_table.out"
awk '$1==1 {print $2,$10,$11}' $file4 > hms_stat
awk '$1==2 {print $2,$10,$11}' $file4 > shms_stat

#file3="../output/rates.out"
#awk '$1==2 {print $3,$16}' $file3 > syst
awk '{print $2,$14}' $file4 > syst

xmgrace -free -settype xydy -block xb1_stat         -graph 0 -bxy 1:2:3 \
              -settype xydy -block xb1_tot          -graph 0 -bxy 1:2:3 \
              -settype xy   -block model_miller     -graph 0 -bxy 1:2 \
              -settype xy   -block model_nosea_mstw -graph 0 -bxy 1:2 \
              -settype xy   -block model_sea_mstw   -graph 0 -bxy 1:2 \
              -settype xydy -block xb1_stat         -graph 0 -bxy 1:2:3 \
              -settype xydy -block xb1_tot          -graph 0 -bxy 1:2:3 \
              -settype xy   -block syst             -graph 0 -bxy 1:2 \
              -settype xydy -block hms_stat        -graph 0 -bxy 1:2:3 \
              -settype xydy -block shms_stat        -graph 0 -bxy 1:2:3 \
              -p b1_proj_lin.par -noask
gracebat -hdevice EPS -printfile b1_proj_newmiller_lin.eps \
              -settype xydy -block xb1_stat         -graph 0 -bxy 1:2:3 \
              -settype xydy -block xb1_tot          -graph 0 -bxy 1:2:3 \
              -settype xy   -block model_miller     -graph 0 -bxy 1:2 \
              -settype xy   -block model_nosea_mstw -graph 0 -bxy 1:2 \
              -settype xy   -block model_sea_mstw   -graph 0 -bxy 1:2 \
              -settype xydy -block xb1_stat         -graph 0 -bxy 1:2:3 \
              -settype xydy -block xb1_tot          -graph 0 -bxy 1:2:3 \
              -settype xy   -block syst             -graph 0 -bxy 1:2 \
              -settype xydy -block hms_stat        -graph 0 -bxy 1:2:3 \
              -settype xydy -block shms_stat        -graph 0 -bxy 1:2:3 \
              -p b1_proj_lin.par -noask

xmgrace -free -settype xydy -block xb1_stat         -graph 0 -bxy 1:2:3 \
              -settype xydy -block xb1_tot          -graph 0 -bxy 1:2:3 \
              -settype xy   -block model_miller     -graph 0 -bxy 1:2 \
              -settype xy   -block model_nosea_mstw -graph 0 -bxy 1:2 \
              -settype xy   -block model_sea_mstw   -graph 0 -bxy 1:2 \
              -settype xydy -block xb1_stat         -graph 0 -bxy 1:2:3 \
              -settype xydy -block xb1_tot          -graph 0 -bxy 1:2:3 \
              -settype xy   -block syst             -graph 0 -bxy 1:2 \
              -settype xydy -block hms_stat        -graph 0 -bxy 1:2:3 \
              -settype xydy -block shms_stat        -graph 0 -bxy 1:2:3 \
              -p b1_proj_lin_xrange.par -noask
gracebat -hdevice EPS -printfile b1_proj_newmiller_lin_xrange.eps \
              -settype xydy -block xb1_stat         -graph 0 -bxy 1:2:3 \
              -settype xydy -block xb1_tot          -graph 0 -bxy 1:2:3 \
              -settype xy   -block model_miller     -graph 0 -bxy 1:2 \
              -settype xy   -block model_nosea_mstw -graph 0 -bxy 1:2 \
              -settype xy   -block model_sea_mstw   -graph 0 -bxy 1:2 \
              -settype xydy -block xb1_stat         -graph 0 -bxy 1:2:3 \
              -settype xydy -block xb1_tot          -graph 0 -bxy 1:2:3 \
              -settype xy   -block syst             -graph 0 -bxy 1:2 \
              -settype xydy -block hms_stat        -graph 0 -bxy 1:2:3 \
              -settype xydy -block shms_stat        -graph 0 -bxy 1:2:3 \
              -p b1_proj_lin_xrange.par -noask



rm -f xb1_stat
rm -f xb1_tot
rm -f model_nosea_*
rm -f model_sea_*
rm -f model_miller
rm -f hms_stat shms_stat
rm -f syst