#!/bin/sh

file0="./table2.dat"
awk '$1!="#" {print $1,$1*$6,$1*$7}' $file0 > xb1_stat
awk '$1!="#" {print $1,$1*$6,$1*sqrt($7*$7+$8*$8)}' $file0 > xb1_tot

file1="../output/b1model_kumano.dat"
awk '$1==1 {print $2,$6}' $file1 > model_nosea_cteq
awk '$1==1 {print $2,$10}' $file1 > model_sea_cteq
awk '$1==2 {print $2,$6}' $file1 > model_nosea_mrst
awk '$1==2 {print $2,$10}' $file1 > model_sea_mrst
awk '$1==3 {print $2,$6}' $file1 > model_nosea_mstw
awk '$1==3 {print $2,$10}' $file1 > model_sea_mstw

file2="../Miller_newtable/miller_nov11_2010.dat"
awk '$1!=0.9 {print $2,$2*$3}' $file2 > model_miller

file3="../output/b1model_miller.dat"
awk '$1==3 && $2<=0.6 {print $2,$4}' $file3 > model_miller_old

file4="../output/b1model_sargsian.dat"
awk '$1==1 && $2>=0.15 {print $2,$4}' $file4 > model_sargsian_vn
awk '$1==1 && $2>=0.15 {print $2,$6}' $file4 > model_sargsian_lc

file5="../output/b1model_bacchetta.dat"
awk '$1==1 && $2!=0.0{print $2,$4}' $file5 > model_bacchetta_low
awk '$1==1 && $2!=0.0{print $2,$5}' $file5 > model_bacchetta_up

xmgrace -free -settype xydy -block xb1_stat         -graph 0 -bxy 1:2:3 \
              -settype xy   -block model_miller_old -graph 0 -bxy 1:2 \
              -settype xy   -block model_miller     -graph 0 -bxy 1:2 \
              -settype xy   -block model_nosea_mstw -graph 0 -bxy 1:2 \
              -settype xy   -block model_sea_mstw   -graph 0 -bxy 1:2 \
              -settype xydy -block xb1_stat         -graph 0 -bxy 1:2:3 \
              -settype xydy -block xb1_tot          -graph 0 -bxy 1:2:3 \
              -settype xy   -block model_sargsian_vn    -graph 0 -bxy 1:2 \
              -settype xy   -block model_sargsian_lc    -graph 0 -bxy 1:2 \
              -settype xy   -block model_bacchetta_low  -graph 0 -bxy 1:2 \
              -settype xy   -block model_bacchetta_up   -graph 0 -bxy 1:2 \
              -p xb1_allmodels.par -noask
gracebat -hdevice EPS -printfile xb1_mstw_newmiller.eps \
              -settype xydy -block xb1_stat         -graph 0 -bxy 1:2:3 \
              -settype xy   -block model_miller_old -graph 0 -bxy 1:2 \
              -settype xy   -block model_miller     -graph 0 -bxy 1:2 \
              -settype xy   -block model_nosea_mstw -graph 0 -bxy 1:2 \
              -settype xy   -block model_sea_mstw   -graph 0 -bxy 1:2 \
              -settype xydy -block xb1_stat         -graph 0 -bxy 1:2:3 \
              -settype xydy -block xb1_tot          -graph 0 -bxy 1:2:3 \
              -settype xy   -block model_sargsian_vn    -graph 0 -bxy 1:2 \
              -settype xy   -block model_sargsian_lc    -graph 0 -bxy 1:2 \
              -settype xy   -block model_bacchetta_low  -graph 0 -bxy 1:2 \
              -settype xy   -block model_bacchetta_up   -graph 0 -bxy 1:2 \
              -p xb1_allmodels.par -noask

xmgrace -free -settype xydy -block xb1_stat         -graph 0 -bxy 1:2:3 \
              -settype xy   -block model_miller_old -graph 0 -bxy 1:2 \
              -settype xy   -block model_miller     -graph 0 -bxy 1:2 \
              -settype xy   -block model_nosea_mstw -graph 0 -bxy 1:2 \
              -settype xy   -block model_sea_mstw   -graph 0 -bxy 1:2 \
              -settype xydy -block xb1_stat         -graph 0 -bxy 1:2:3 \
              -settype xydy -block xb1_tot          -graph 0 -bxy 1:2:3 \
              -settype xy   -block model_sargsian_vn    -graph 0 -bxy 1:2 \
              -settype xy   -block model_sargsian_lc    -graph 0 -bxy 1:2 \
              -settype xy   -block model_bacchetta_low  -graph 0 -bxy 1:2 \
              -settype xy   -block model_bacchetta_up   -graph 0 -bxy 1:2 \
              -p xb1_allmodels_lin.par -noask
gracebat -hdevice EPS -printfile xb1_mstw_newmiller_lin.eps \
              -settype xydy -block xb1_stat         -graph 0 -bxy 1:2:3 \
              -settype xy   -block model_miller_old -graph 0 -bxy 1:2 \
              -settype xy   -block model_miller     -graph 0 -bxy 1:2 \
              -settype xy   -block model_nosea_mstw -graph 0 -bxy 1:2 \
              -settype xy   -block model_sea_mstw   -graph 0 -bxy 1:2 \
              -settype xydy -block xb1_stat         -graph 0 -bxy 1:2:3 \
              -settype xydy -block xb1_tot          -graph 0 -bxy 1:2:3 \
              -settype xy   -block model_sargsian_vn    -graph 0 -bxy 1:2 \
              -settype xy   -block model_sargsian_lc    -graph 0 -bxy 1:2 \
              -settype xy   -block model_bacchetta_low  -graph 0 -bxy 1:2 \
              -settype xy   -block model_bacchetta_up   -graph 0 -bxy 1:2 \
              -p xb1_allmodels_lin.par -noask

rm -f xb1_stat
rm -f xb1_tot
rm -f model_nosea_*
rm -f model_sea_*
rm -f model_miller