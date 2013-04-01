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

xmgrace -free -settype xydy -block xb1_stat         -graph 0 -bxy 1:2:3 \
              -settype xydy -block xb1_tot          -graph 0 -bxy 1:2:3 \
              -settype xy   -block model_nosea_cteq -graph 0 -bxy 1:2 \
              -settype xy   -block model_sea_cteq   -graph 0 -bxy 1:2 \
              -p xb1.par -noask
gracebat -hdevice EPS -printfile xb1_kumano_cteq.eps \
              -settype xydy -block xb1_stat         -graph 0 -bxy 1:2:3 \
              -settype xydy -block xb1_tot          -graph 0 -bxy 1:2:3 \
              -settype xy   -block model_nosea_cteq -graph 0 -bxy 1:2 \
              -settype xy   -block model_sea_cteq   -graph 0 -bxy 1:2 \
              -p xb1.par -noask

xmgrace -free -settype xydy -block xb1_stat         -graph 0 -bxy 1:2:3 \
              -settype xydy -block xb1_tot          -graph 0 -bxy 1:2:3 \
              -settype xy   -block model_nosea_mrst -graph 0 -bxy 1:2 \
              -settype xy   -block model_sea_mrst   -graph 0 -bxy 1:2 \
              -p xb1.par -noask
gracebat -hdevice EPS -printfile xb1_kumano_mrst.eps \
              -settype xydy -block xb1_stat         -graph 0 -bxy 1:2:3 \
              -settype xydy -block xb1_tot          -graph 0 -bxy 1:2:3 \
              -settype xy   -block model_nosea_mrst -graph 0 -bxy 1:2 \
              -settype xy   -block model_sea_mrst   -graph 0 -bxy 1:2 \
              -p xb1.par -noask

xmgrace -free -settype xydy -block xb1_stat         -graph 0 -bxy 1:2:3 \
              -settype xydy -block xb1_tot          -graph 0 -bxy 1:2:3 \
              -settype xy   -block model_nosea_mstw -graph 0 -bxy 1:2 \
              -settype xy   -block model_sea_mstw   -graph 0 -bxy 1:2 \
              -p xb1.par -noask
gracebat -hdevice EPS -printfile xb1_kumano_mstw.eps \
              -settype xydy -block xb1_stat         -graph 0 -bxy 1:2:3 \
              -settype xydy -block xb1_tot          -graph 0 -bxy 1:2:3 \
              -settype xy   -block model_nosea_mstw -graph 0 -bxy 1:2 \
              -settype xy   -block model_sea_mstw   -graph 0 -bxy 1:2 \
              -p xb1.par -noask

xmgrace -free -settype xydy -block xb1_stat         -graph 0 -bxy 1:2:3 \
              -settype xydy -block xb1_tot          -graph 0 -bxy 1:2:3 \
              -settype xy   -block model_nosea_mstw -graph 0 -bxy 1:2 \
              -settype xy   -block model_sea_mstw   -graph 0 -bxy 1:2 \
              -p xb1_lin.par -noask
gracebat -hdevice EPS -printfile xb1_kumano_mstw_lin.eps \
              -settype xydy -block xb1_stat         -graph 0 -bxy 1:2:3 \
              -settype xydy -block xb1_tot          -graph 0 -bxy 1:2:3 \
              -settype xy   -block model_nosea_mstw -graph 0 -bxy 1:2 \
              -settype xy   -block model_sea_mstw   -graph 0 -bxy 1:2 \
              -p xb1_lin.par -noask

rm -f xb1_stat
rm -f xb1_tot
rm -f model_nosea_*
rm -f model_sea_*
