#!/bin/sh

file1="../output/b1model_kumano.dat"
awk '$1==1 {print $2,$5}' $file1 > deltatq_nosea_cteq
awk '$1==1 {print $2,$8}' $file1 > deltatq_sea_cteq
awk '$1==1 {print $2,$9}' $file1 > deltatqbar_sea_cteq
awk '$1==2 {print $2,$5}' $file1 > deltatq_nosea_mrst
awk '$1==2 {print $2,$8}' $file1 > deltatq_sea_mrst
awk '$1==2 {print $2,$9}' $file1 > deltatqbar_sea_mrst
awk '$1==3 {print $2,$5}' $file1 > deltatq_nosea_mstw
awk '$1==3 {print $2,$8}' $file1 > deltatq_sea_mstw
awk '$1==3 {print $2,$9}' $file1 > deltatqbar_sea_mstw

xmgrace -free -settype xy -block deltatq_nosea_cteq  -graph 0 -bxy 1:2 \
              -settype xy -block deltatq_sea_cteq    -graph 0 -bxy 1:2 \
              -settype xy -block deltatqbar_sea_cteq -graph 0 -bxy 1:2 \
              -p deltatq.par -noask
gracebat -hdevice EPS -printfile deltatq_kumano_cteq.eps \
              -settype xy -block deltatq_nosea_cteq  -graph 0 -bxy 1:2 \
              -settype xy -block deltatq_sea_cteq    -graph 0 -bxy 1:2 \
              -settype xy -block deltatqbar_sea_cteq -graph 0 -bxy 1:2 \
              -p deltatq.par -noask

xmgrace -free -settype xy -block deltatq_nosea_mrst  -graph 0 -bxy 1:2 \
              -settype xy -block deltatq_sea_mrst    -graph 0 -bxy 1:2 \
              -settype xy -block deltatqbar_sea_mrst -graph 0 -bxy 1:2 \
              -p deltatq.par -noask
gracebat -hdevice EPS -printfile deltatq_kumano_mrst.eps \
              -settype xy -block deltatq_nosea_mrst  -graph 0 -bxy 1:2 \
              -settype xy -block deltatq_sea_mrst    -graph 0 -bxy 1:2 \
              -settype xy -block deltatqbar_sea_mrst -graph 0 -bxy 1:2 \
              -p deltatq.par -noask

xmgrace -free -settype xy -block deltatq_nosea_mstw  -graph 0 -bxy 1:2 \
              -settype xy -block deltatq_sea_mstw    -graph 0 -bxy 1:2 \
              -settype xy -block deltatqbar_sea_mstw -graph 0 -bxy 1:2 \
              -p deltatq.par -noask
gracebat -hdevice EPS -printfile deltatq_kumano_mstw.eps \
              -settype xy -block deltatq_nosea_mstw  -graph 0 -bxy 1:2 \
              -settype xy -block deltatq_sea_mstw    -graph 0 -bxy 1:2 \
              -settype xy -block deltatqbar_sea_mstw -graph 0 -bxy 1:2 \
              -p deltatq.par -noask

xmgrace -free -settype xy -block deltatq_nosea_mstw  -graph 0 -bxy 1:2 \
              -settype xy -block deltatq_sea_mstw    -graph 0 -bxy 1:2 \
              -settype xy -block deltatqbar_sea_mstw -graph 0 -bxy 1:2 \
              -p deltatq_lin.par -noask
gracebat -hdevice EPS -printfile deltatq_kumano_mstw_lin.eps \
              -settype xy -block deltatq_nosea_mstw  -graph 0 -bxy 1:2 \
              -settype xy -block deltatq_sea_mstw    -graph 0 -bxy 1:2 \
              -settype xy -block deltatqbar_sea_mstw -graph 0 -bxy 1:2 \
              -p deltatq_lin.par -noask


rm -f deltatq*_cteq
rm -f deltatq*_mrst
rm -f deltatq*_mstw

