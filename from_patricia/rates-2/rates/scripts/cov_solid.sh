
file0="../output/xs.out"
awk '$1==4 && $2==1 {print $5,$4}' $file0 > hms_cov_1
awk '$1==4 && $2==2 {print $5,$4}' $file0 > hms_cov_2
awk '$1==4 && $2==3 {print $5,$4}' $file0 > hms_cov_3
awk '$1==4 && $2==4 {print $5,$4}' $file0 > hms_cov_4
awk '$1==4 && $2==5 {print $5,$4}' $file0 > hms_cov_5
awk '$1==4 && $2==6 {print $5,$4}' $file0 > hms_cov_6
awk '$1==4 && $2==7 {print $5,$4}' $file0 > hms_cov_7
awk '$1==4 && $2==8 {print $5,$4}' $file0 > hms_cov_8
awk '$1==4 && $2==9 {print $5,$4}' $file0 > hms_cov_9
awk '$1==4 && $2==10 {print $5,$4}' $file0 > hms_cov_10
awk '$1==4 && $2==11 {print $5,$4}' $file0 > hms_cov_11
awk '$1==4 && $2==12 {print $5,$4}' $file0 > hms_cov_12

file1="../output/lines.out"

xmgrace -free -settype xy -block hms_cov_1  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_2  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_3  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_4  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_5  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_6  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_7  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_8  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_9  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_10  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_11  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_12  -graph 0 -bxy 1:2 \
              -settype xy -block $file1     -graph 0 -bxy 1:2 \
              -settype xy -block $file1     -graph 0 -bxy 1:3 \
              -settype xy -block $file1     -graph 0 -bxy 1:4 \
              -settype xy -block $file1     -graph 0 -bxy 1:5 \
              -settype xy -block $file1     -graph 0 -bxy 1:6 \
              -p cov_solid.par -noask
gracebat -hdevice EPS -printfile cov_solid.eps \
 -settype xy -block hms_cov_1  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_2  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_3  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_4  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_5  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_6  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_7  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_8  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_9  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_10  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_11  -graph 0 -bxy 1:2 \
              -settype xy -block hms_cov_12  -graph 0 -bxy 1:2 \
              -settype xy -block $file1     -graph 0 -bxy 1:2 \
              -settype xy -block $file1     -graph 0 -bxy 1:3 \
              -settype xy -block $file1     -graph 0 -bxy 1:4 \
              -settype xy -block $file1     -graph 0 -bxy 1:5 \
              -settype xy -block $file1     -graph 0 -bxy 1:6 \
              -p cov_solid.par -noask

rm -f hms_cov_*