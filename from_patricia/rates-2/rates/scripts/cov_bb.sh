
file0="../output/xs.out"
awk '$1==5 {print $5,$4}' $file0 > bb_cov

xmgrace -free -settype xy -block bb_cov  -graph 0 -bxy 1:2 \
              -p cov.par -noask
gracebat -hdevice EPS -printfile bb.eps \
              -settype xy -block bb_cov  -graph 0 -bxy 1:2 \
              -p cov.par -noask

rm -f bb_cov

####
awk '$1==5 && $2==1 {print $5,$4}' $file0 > bb_cov_1
awk '$1==5 && $2==2 {print $5,$4}' $file0 > bb_cov_2
awk '$1==5 && $2==3 {print $5,$4}' $file0 > bb_cov_3

file1="../output/lines.out"

xmgrace -free -settype xy -block bb_cov_1  -graph 0 -bxy 1:2 \
              -settype xy -block bb_cov_2  -graph 0 -bxy 1:2 \
              -settype xy -block bb_cov_3  -graph 0 -bxy 1:2 \
              -settype xy -block bb_cov_3  -graph 0 -bxy 1:2 \
              -settype xy -block bb_cov_3  -graph 0 -bxy 1:2 \
              -settype xy -block bb_cov_3  -graph 0 -bxy 1:2 \
              -settype xy -block bb_cov_3  -graph 0 -bxy 1:2 \
              -settype xy -block bb_cov_3  -graph 0 -bxy 1:2 \
              -settype xy -block $file1     -graph 0 -bxy 1:2 \
              -settype xy -block $file1     -graph 0 -bxy 1:3 \
              -settype xy -block $file1     -graph 0 -bxy 1:4 \
              -settype xy -block $file1     -graph 0 -bxy 1:5 \
              -settype xy -block $file1     -graph 0 -bxy 1:6 \
              -p cov_split.par -noask
gracebat -hdevice EPS -printfile cov_bb_split.eps \
              -settype xy -block bb_cov_1  -graph 0 -bxy 1:2 \
              -settype xy -block bb_cov_2  -graph 0 -bxy 1:2 \
              -settype xy -block bb_cov_3  -graph 0 -bxy 1:2 \
              -settype xy -block bb_cov_3  -graph 0 -bxy 1:2 \
              -settype xy -block bb_cov_3  -graph 0 -bxy 1:2 \
              -settype xy -block bb_cov_3  -graph 0 -bxy 1:2 \
              -settype xy -block bb_cov_3  -graph 0 -bxy 1:2 \
              -settype xy -block bb_cov_3  -graph 0 -bxy 1:2 \
              -settype xy -block $file1     -graph 0 -bxy 1:2 \
              -settype xy -block $file1     -graph 0 -bxy 1:3 \
              -settype xy -block $file1     -graph 0 -bxy 1:4 \
              -settype xy -block $file1     -graph 0 -bxy 1:5 \
              -settype xy -block $file1     -graph 0 -bxy 1:6 \
              -p cov_split.par -noask



rm -f bb_cov_*
