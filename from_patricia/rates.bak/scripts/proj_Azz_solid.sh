#!/bin/sh

file0="../../models/SCRIPTS/table2.dat"
awk '$1!="#" {print $1,-1.5*$3,1.5*$4}' $file0 > Azz_stat
awk '$1!="#" {print $1,-1.5*$3,1.5*sqrt($4*$4+$5*$5)}' $file0 > Azz_tot

file1="../../models/output/b1model_kumano.dat"
awk '$1==1 {print $2,-1.5*$11}' $file1 > model_nosea_cteq
awk '$1==1 {print $2,-1.5*$12}' $file1 > model_sea_cteq
awk '$1==2 {print $2,-1.5*$11}' $file1 > model_nosea_mrst
awk '$1==2 {print $2,-1.5*$12}' $file1 > model_sea_mrst
awk '$1==3 {print $2,-1.5*$11}' $file1 > model_nosea_mstw
awk '$1==3 {print $2,-1.5*$12}' $file1 > model_sea_mstw

file2="../../models/output/b1model_miller.dat"
awk '$1==3 && $2<=0.6 {print $2,-1.5*$5}' $file2 > model_miller

file3="../output/rates.out"
#awk '$1==1 {print $3,-1.5*$6,1.5*$7/1.414}' $file3 > hms_stat
#awk '$1==2 {print $3,-1.5*$6,1.5*$7/1.414}' $file3 > shms_stat
awk '$1==4 {print $3,0.0,1.5*$7}' $file3 > shms_stat
awk '$1==4 {print $3,$15}' $file3 > syst

xmgrace -free -settype xydy -block Azz_stat         -graph 0 -bxy 1:2:3 \
              -settype xydy -block Azz_tot          -graph 0 -bxy 1:2:3 \
              -settype xy   -block model_nosea_mstw -graph 0 -bxy 1:2 \
              -settype xy   -block model_sea_mstw   -graph 0 -bxy 1:2 \
              -settype xy   -block model_miller     -graph 0 -bxy 1:2 \
              -settype xy   -block syst             -graph 0 -bxy 1:2 \
              -settype xydy -block shms_stat        -graph 0 -bxy 1:2:3 \
              -p azz_proj.par -noask
gracebat -hdevice EPS -printfile Azz_proj.eps \
              -settype xydy -block Azz_stat         -graph 0 -bxy 1:2:3 \
              -settype xydy -block Azz_tot          -graph 0 -bxy 1:2:3 \
              -settype xy   -block model_nosea_mstw -graph 0 -bxy 1:2 \
              -settype xy   -block model_sea_mstw   -graph 0 -bxy 1:2 \
              -settype xy   -block model_miller     -graph 0 -bxy 1:2 \
              -settype xy   -block syst             -graph 0 -bxy 1:2 \
              -settype xydy -block shms_stat        -graph 0 -bxy 1:2:3 \
              -p azz_proj.par -noask

xmgrace -free -settype xydy -block Azz_stat         -graph 0 -bxy 1:2:3 \
              -settype xydy -block Azz_tot          -graph 0 -bxy 1:2:3 \
              -settype xy   -block model_nosea_mstw -graph 0 -bxy 1:2 \
              -settype xy   -block model_sea_mstw   -graph 0 -bxy 1:2 \
              -settype xy   -block model_miller     -graph 0 -bxy 1:2 \
              -settype xy   -block syst             -graph 0 -bxy 1:2 \
              -settype xydy -block shms_stat        -graph 0 -bxy 1:2:3 \
              -p azz_proj_lin.par -noask
gracebat -hdevice EPS -printfile Azz_proj_lin.eps \
              -settype xydy -block Azz_stat         -graph 0 -bxy 1:2:3 \
              -settype xydy -block Azz_tot          -graph 0 -bxy 1:2:3 \
              -settype xy   -block model_nosea_mstw -graph 0 -bxy 1:2 \
              -settype xy   -block model_sea_mstw   -graph 0 -bxy 1:2 \
              -settype xy   -block model_miller     -graph 0 -bxy 1:2 \
              -settype xy   -block syst             -graph 0 -bxy 1:2 \
              -settype xydy -block shms_stat        -graph 0 -bxy 1:2:3 \
              -p azz_proj_lin.par -noask

rm -f Azz_stat
rm -f Azz_tot
rm -f model_nosea_*
rm -f model_sea_*
rm -f model_miller
rm -f hms_stat shms_stat
rm -f syst