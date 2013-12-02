#!/bin/sh

# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#
# f1map.sh
#
# This shell script plots the structure functions F1 and F2 in the
# inelastic and quasi-elastic ranges based on the outputs of ../map_f1.
#
#
# Elena Long
# ellie@jlab.org
# 4/26/2013
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

file0="../output/f1_map.txt"
awk '$1==0.100 {print $2,$4}' $file0 > temp_010_f1in
awk '$1==0.100 {print $2,$5}' $file0 > temp_010_f1qe
awk '$1==0.110 {print $2,$4}' $file0 > temp_011_f1in
awk '$1==0.110 {print $2,$5}' $file0 > temp_011_f1qe
awk '$1==0.120 {print $2,$4}' $file0 > temp_012_f1in
awk '$1==0.120 {print $2,$5}' $file0 > temp_012_f1qe
awk '$1==0.130 {print $2,$4}' $file0 > temp_013_f1in
awk '$1==0.130 {print $2,$5}' $file0 > temp_013_f1qe
awk '$1==0.140 {print $2,$4}' $file0 > temp_014_f1in
awk '$1==0.140 {print $2,$5}' $file0 > temp_014_f1qe
awk '$1==0.150 {print $2,$4}' $file0 > temp_015_f1in
awk '$1==0.150 {print $2,$5}' $file0 > temp_015_f1qe
awk '$1==0.160 {print $2,$4}' $file0 > temp_016_f1in
awk '$1==0.160 {print $2,$5}' $file0 > temp_016_f1qe
awk '$1==0.170 {print $2,$4}' $file0 > temp_017_f1in
awk '$1==0.170 {print $2,$5}' $file0 > temp_017_f1qe
awk '$1==0.180 {print $2,$4}' $file0 > temp_018_f1in
awk '$1==0.180 {print $2,$5}' $file0 > temp_018_f1qe
awk '$1==0.190 {print $2,$4}' $file0 > temp_019_f1in
awk '$1==0.190 {print $2,$5}' $file0 > temp_019_f1qe
awk '$1==0.200 {print $2,$4}' $file0 > temp_020_f1in
awk '$1==0.200 {print $2,$5}' $file0 > temp_020_f1qe
awk '$1==0.210 {print $2,$4}' $file0 > temp_021_f1in
awk '$1==0.210 {print $2,$5}' $file0 > temp_021_f1qe
awk '$1==0.220 {print $2,$4}' $file0 > temp_022_f1in
awk '$1==0.220 {print $2,$5}' $file0 > temp_022_f1qe
awk '$1==0.230 {print $2,$4}' $file0 > temp_023_f1in
awk '$1==0.230 {print $2,$5}' $file0 > temp_023_f1qe
awk '$1==0.240 {print $2,$4}' $file0 > temp_024_f1in
awk '$1==0.240 {print $2,$5}' $file0 > temp_024_f1qe
awk '$1==0.250 {print $2,$4}' $file0 > temp_025_f1in
awk '$1==0.250 {print $2,$5}' $file0 > temp_025_f1qe
awk '$1==0.260 {print $2,$4}' $file0 > temp_026_f1in
awk '$1==0.260 {print $2,$5}' $file0 > temp_026_f1qe
awk '$1==0.270 {print $2,$4}' $file0 > temp_027_f1in
awk '$1==0.270 {print $2,$5}' $file0 > temp_027_f1qe
awk '$1==0.280 {print $2,$4}' $file0 > temp_028_f1in
awk '$1==0.280 {print $2,$5}' $file0 > temp_028_f1qe
awk '$1==0.290 {print $2,$4}' $file0 > temp_029_f1in
awk '$1==0.290 {print $2,$5}' $file0 > temp_029_f1qe
awk '$1==0.300 {print $2,$4}' $file0 > temp_030_f1in
awk '$1==0.300 {print $2,$5}' $file0 > temp_030_f1qe
awk '$1==0.310 {print $2,$4}' $file0 > temp_031_f1in
awk '$1==0.310 {print $2,$5}' $file0 > temp_031_f1qe
awk '$1==0.320 {print $2,$4}' $file0 > temp_032_f1in
awk '$1==0.320 {print $2,$5}' $file0 > temp_032_f1qe
awk '$1==0.330 {print $2,$4}' $file0 > temp_033_f1in
awk '$1==0.330 {print $2,$5}' $file0 > temp_033_f1qe
awk '$1==0.340 {print $2,$4}' $file0 > temp_034_f1in
awk '$1==0.340 {print $2,$5}' $file0 > temp_034_f1qe
awk '$1==0.350 {print $2,$4}' $file0 > temp_035_f1in
awk '$1==0.350 {print $2,$5}' $file0 > temp_035_f1qe
awk '$1==0.360 {print $2,$4}' $file0 > temp_036_f1in
awk '$1==0.360 {print $2,$5}' $file0 > temp_036_f1qe
awk '$1==0.370 {print $2,$4}' $file0 > temp_037_f1in
awk '$1==0.370 {print $2,$5}' $file0 > temp_037_f1qe
awk '$1==0.380 {print $2,$4}' $file0 > temp_038_f1in
awk '$1==0.380 {print $2,$5}' $file0 > temp_038_f1qe
awk '$1==0.390 {print $2,$4}' $file0 > temp_039_f1in
awk '$1==0.390 {print $2,$5}' $file0 > temp_039_f1qe
awk '$1==0.400 {print $2,$4}' $file0 > temp_040_f1in
awk '$1==0.400 {print $2,$5}' $file0 > temp_040_f1qe
awk '$1==0.410 {print $2,$4}' $file0 > temp_041_f1in
awk '$1==0.410 {print $2,$5}' $file0 > temp_041_f1qe
awk '$1==0.420 {print $2,$4}' $file0 > temp_042_f1in
awk '$1==0.420 {print $2,$5}' $file0 > temp_042_f1qe
awk '$1==0.430 {print $2,$4}' $file0 > temp_043_f1in
awk '$1==0.430 {print $2,$5}' $file0 > temp_043_f1qe
awk '$1==0.440 {print $2,$4}' $file0 > temp_044_f1in
awk '$1==0.440 {print $2,$5}' $file0 > temp_044_f1qe
awk '$1==0.450 {print $2,$4}' $file0 > temp_045_f1in
awk '$1==0.450 {print $2,$5}' $file0 > temp_045_f1qe
awk '$1==0.460 {print $2,$4}' $file0 > temp_046_f1in
awk '$1==0.460 {print $2,$5}' $file0 > temp_046_f1qe
awk '$1==0.470 {print $2,$4}' $file0 > temp_047_f1in
awk '$1==0.470 {print $2,$5}' $file0 > temp_047_f1qe
awk '$1==0.480 {print $2,$4}' $file0 > temp_048_f1in
awk '$1==0.480 {print $2,$5}' $file0 > temp_048_f1qe
awk '$1==0.490 {print $2,$4}' $file0 > temp_049_f1in
awk '$1==0.490 {print $2,$5}' $file0 > temp_049_f1qe
awk '$1==0.500 {print $2,$4}' $file0 > temp_050_f1in
awk '$1==0.500 {print $2,$5}' $file0 > temp_050_f1qe
awk '$1==0.510 {print $2,$4}' $file0 > temp_051_f1in
awk '$1==0.510 {print $2,$5}' $file0 > temp_051_f1qe
awk '$1==0.520 {print $2,$4}' $file0 > temp_052_f1in
awk '$1==0.520 {print $2,$5}' $file0 > temp_052_f1qe
awk '$1==0.530 {print $2,$4}' $file0 > temp_053_f1in
awk '$1==0.530 {print $2,$5}' $file0 > temp_053_f1qe
awk '$1==0.540 {print $2,$4}' $file0 > temp_054_f1in
awk '$1==0.540 {print $2,$5}' $file0 > temp_054_f1qe
awk '$1==0.550 {print $2,$4}' $file0 > temp_055_f1in
awk '$1==0.550 {print $2,$5}' $file0 > temp_055_f1qe
awk '$1==0.560 {print $2,$4}' $file0 > temp_056_f1in
awk '$1==0.560 {print $2,$5}' $file0 > temp_056_f1qe
awk '$1==0.570 {print $2,$4}' $file0 > temp_057_f1in
awk '$1==0.570 {print $2,$5}' $file0 > temp_057_f1qe
awk '$1==0.580 {print $2,$4}' $file0 > temp_058_f1in
awk '$1==0.580 {print $2,$5}' $file0 > temp_058_f1qe
awk '$1==0.590 {print $2,$4}' $file0 > temp_059_f1in
awk '$1==0.590 {print $2,$5}' $file0 > temp_059_f1qe
awk '$1==0.600 {print $2,$4}' $file0 > temp_060_f1in
awk '$1==0.600 {print $2,$5}' $file0 > temp_060_f1qe
awk '$1==0.610 {print $2,$4}' $file0 > temp_061_f1in
awk '$1==0.610 {print $2,$5}' $file0 > temp_061_f1qe
awk '$1==0.620 {print $2,$4}' $file0 > temp_062_f1in
awk '$1==0.620 {print $2,$5}' $file0 > temp_062_f1qe
awk '$1==0.630 {print $2,$4}' $file0 > temp_063_f1in
awk '$1==0.630 {print $2,$5}' $file0 > temp_063_f1qe
awk '$1==0.640 {print $2,$4}' $file0 > temp_064_f1in
awk '$1==0.640 {print $2,$5}' $file0 > temp_064_f1qe
awk '$1==0.650 {print $2,$4}' $file0 > temp_065_f1in
awk '$1==0.650 {print $2,$5}' $file0 > temp_065_f1qe
awk '$1==0.660 {print $2,$4}' $file0 > temp_066_f1in
awk '$1==0.660 {print $2,$5}' $file0 > temp_066_f1qe
awk '$1==0.670 {print $2,$4}' $file0 > temp_067_f1in
awk '$1==0.670 {print $2,$5}' $file0 > temp_067_f1qe
awk '$1==0.680 {print $2,$4}' $file0 > temp_068_f1in
awk '$1==0.680 {print $2,$5}' $file0 > temp_068_f1qe
awk '$1==0.690 {print $2,$4}' $file0 > temp_069_f1in
awk '$1==0.690 {print $2,$5}' $file0 > temp_069_f1qe
awk '$1==0.700 {print $2,$4}' $file0 > temp_070_f1in
awk '$1==0.700 {print $2,$5}' $file0 > temp_070_f1qe
awk '$1==0.710 {print $2,$4}' $file0 > temp_071_f1in
awk '$1==0.710 {print $2,$5}' $file0 > temp_071_f1qe
awk '$1==0.720 {print $2,$4}' $file0 > temp_072_f1in
awk '$1==0.720 {print $2,$5}' $file0 > temp_072_f1qe
awk '$1==0.730 {print $2,$4}' $file0 > temp_073_f1in
awk '$1==0.730 {print $2,$5}' $file0 > temp_073_f1qe
awk '$1==0.740 {print $2,$4}' $file0 > temp_074_f1in
awk '$1==0.740 {print $2,$5}' $file0 > temp_074_f1qe
awk '$1==0.750 {print $2,$4}' $file0 > temp_075_f1in
awk '$1==0.750 {print $2,$5}' $file0 > temp_075_f1qe
awk '$1==0.760 {print $2,$4}' $file0 > temp_076_f1in
awk '$1==0.760 {print $2,$5}' $file0 > temp_076_f1qe
awk '$1==0.770 {print $2,$4}' $file0 > temp_077_f1in
awk '$1==0.770 {print $2,$5}' $file0 > temp_077_f1qe
awk '$1==0.780 {print $2,$4}' $file0 > temp_078_f1in
awk '$1==0.780 {print $2,$5}' $file0 > temp_078_f1qe
awk '$1==0.790 {print $2,$4}' $file0 > temp_079_f1in
awk '$1==0.790 {print $2,$5}' $file0 > temp_079_f1qe
awk '$1==0.800 {print $2,$4}' $file0 > temp_080_f1in
awk '$1==0.800 {print $2,$5}' $file0 > temp_080_f1qe
awk '$1==0.810 {print $2,$4}' $file0 > temp_081_f1in
awk '$1==0.810 {print $2,$5}' $file0 > temp_081_f1qe
awk '$1==0.820 {print $2,$4}' $file0 > temp_082_f1in
awk '$1==0.820 {print $2,$5}' $file0 > temp_082_f1qe
awk '$1==0.830 {print $2,$4}' $file0 > temp_083_f1in
awk '$1==0.830 {print $2,$5}' $file0 > temp_083_f1qe
awk '$1==0.840 {print $2,$4}' $file0 > temp_084_f1in
awk '$1==0.840 {print $2,$5}' $file0 > temp_084_f1qe
awk '$1==0.850 {print $2,$4}' $file0 > temp_085_f1in
awk '$1==0.850 {print $2,$5}' $file0 > temp_085_f1qe
awk '$1==0.860 {print $2,$4}' $file0 > temp_086_f1in
awk '$1==0.860 {print $2,$5}' $file0 > temp_086_f1qe
awk '$1==0.870 {print $2,$4}' $file0 > temp_087_f1in
awk '$1==0.870 {print $2,$5}' $file0 > temp_087_f1qe
awk '$1==0.880 {print $2,$4}' $file0 > temp_088_f1in
awk '$1==0.880 {print $2,$5}' $file0 > temp_088_f1qe
awk '$1==0.890 {print $2,$4}' $file0 > temp_089_f1in
awk '$1==0.890 {print $2,$5}' $file0 > temp_089_f1qe
awk '$1==0.900 {print $2,$4}' $file0 > temp_090_f1in
awk '$1==0.900 {print $2,$5}' $file0 > temp_090_f1qe
awk '$1==0.910 {print $2,$4}' $file0 > temp_091_f1in
awk '$1==0.910 {print $2,$5}' $file0 > temp_091_f1qe
awk '$1==0.920 {print $2,$4}' $file0 > temp_092_f1in
awk '$1==0.920 {print $2,$5}' $file0 > temp_092_f1qe
awk '$1==0.930 {print $2,$4}' $file0 > temp_093_f1in
awk '$1==0.930 {print $2,$5}' $file0 > temp_093_f1qe
awk '$1==0.940 {print $2,$4}' $file0 > temp_094_f1in
awk '$1==0.940 {print $2,$5}' $file0 > temp_094_f1qe
awk '$1==0.950 {print $2,$4}' $file0 > temp_095_f1in
awk '$1==0.950 {print $2,$5}' $file0 > temp_095_f1qe
awk '$1==0.960 {print $2,$4}' $file0 > temp_096_f1in
awk '$1==0.960 {print $2,$5}' $file0 > temp_096_f1qe
awk '$1==0.970 {print $2,$4}' $file0 > temp_097_f1in
awk '$1==0.970 {print $2,$5}' $file0 > temp_097_f1qe
awk '$1==0.980 {print $2,$4}' $file0 > temp_098_f1in
awk '$1==0.980 {print $2,$5}' $file0 > temp_098_f1qe
awk '$1==0.990 {print $2,$4}' $file0 > temp_099_f1in
awk '$1==0.990 {print $2,$5}' $file0 > temp_099_f1qe
awk '$1==1.000 {print $2,$4}' $file0 > temp_100_f1in
awk '$1==1.000 {print $2,$5}' $file0 > temp_100_f1qe
awk '$1==1.010 {print $2,$4}' $file0 > temp_101_f1in
awk '$1==1.010 {print $2,$5}' $file0 > temp_101_f1qe
awk '$1==1.020 {print $2,$4}' $file0 > temp_102_f1in
awk '$1==1.020 {print $2,$5}' $file0 > temp_102_f1qe
awk '$1==1.030 {print $2,$4}' $file0 > temp_103_f1in
awk '$1==1.030 {print $2,$5}' $file0 > temp_103_f1qe
awk '$1==1.040 {print $2,$4}' $file0 > temp_104_f1in
awk '$1==1.040 {print $2,$5}' $file0 > temp_104_f1qe
awk '$1==1.050 {print $2,$4}' $file0 > temp_105_f1in
awk '$1==1.050 {print $2,$5}' $file0 > temp_105_f1qe
awk '$1==1.060 {print $2,$4}' $file0 > temp_106_f1in
awk '$1==1.060 {print $2,$5}' $file0 > temp_106_f1qe
awk '$1==1.070 {print $2,$4}' $file0 > temp_107_f1in
awk '$1==1.070 {print $2,$5}' $file0 > temp_107_f1qe
awk '$1==1.080 {print $2,$4}' $file0 > temp_108_f1in
awk '$1==1.080 {print $2,$5}' $file0 > temp_108_f1qe
awk '$1==1.090 {print $2,$4}' $file0 > temp_109_f1in
awk '$1==1.090 {print $2,$5}' $file0 > temp_109_f1qe
awk '$1==1.100 {print $2,$4}' $file0 > temp_110_f1in
awk '$1==1.100 {print $2,$5}' $file0 > temp_110_f1qe
awk '$1==1.110 {print $2,$4}' $file0 > temp_111_f1in
awk '$1==1.110 {print $2,$5}' $file0 > temp_111_f1qe
awk '$1==1.120 {print $2,$4}' $file0 > temp_112_f1in
awk '$1==1.120 {print $2,$5}' $file0 > temp_112_f1qe
awk '$1==1.130 {print $2,$4}' $file0 > temp_113_f1in
awk '$1==1.130 {print $2,$5}' $file0 > temp_113_f1qe
awk '$1==1.140 {print $2,$4}' $file0 > temp_114_f1in
awk '$1==1.140 {print $2,$5}' $file0 > temp_114_f1qe
awk '$1==1.150 {print $2,$4}' $file0 > temp_115_f1in
awk '$1==1.150 {print $2,$5}' $file0 > temp_115_f1qe
awk '$1==1.160 {print $2,$4}' $file0 > temp_116_f1in
awk '$1==1.160 {print $2,$5}' $file0 > temp_116_f1qe
awk '$1==1.170 {print $2,$4}' $file0 > temp_117_f1in
awk '$1==1.170 {print $2,$5}' $file0 > temp_117_f1qe
awk '$1==1.180 {print $2,$4}' $file0 > temp_118_f1in
awk '$1==1.180 {print $2,$5}' $file0 > temp_118_f1qe
awk '$1==1.190 {print $2,$4}' $file0 > temp_119_f1in
awk '$1==1.190 {print $2,$5}' $file0 > temp_119_f1qe
awk '$1==1.200 {print $2,$4}' $file0 > temp_120_f1in
awk '$1==1.200 {print $2,$5}' $file0 > temp_120_f1qe
awk '$1==1.210 {print $2,$4}' $file0 > temp_121_f1in
awk '$1==1.210 {print $2,$5}' $file0 > temp_121_f1qe
awk '$1==1.220 {print $2,$4}' $file0 > temp_122_f1in
awk '$1==1.220 {print $2,$5}' $file0 > temp_122_f1qe
awk '$1==1.230 {print $2,$4}' $file0 > temp_123_f1in
awk '$1==1.230 {print $2,$5}' $file0 > temp_123_f1qe
awk '$1==1.240 {print $2,$4}' $file0 > temp_124_f1in
awk '$1==1.240 {print $2,$5}' $file0 > temp_124_f1qe
awk '$1==1.250 {print $2,$4}' $file0 > temp_125_f1in
awk '$1==1.250 {print $2,$5}' $file0 > temp_125_f1qe
awk '$1==1.260 {print $2,$4}' $file0 > temp_126_f1in
awk '$1==1.260 {print $2,$5}' $file0 > temp_126_f1qe
awk '$1==1.270 {print $2,$4}' $file0 > temp_127_f1in
awk '$1==1.270 {print $2,$5}' $file0 > temp_127_f1qe
awk '$1==1.280 {print $2,$4}' $file0 > temp_128_f1in
awk '$1==1.280 {print $2,$5}' $file0 > temp_128_f1qe
awk '$1==1.290 {print $2,$4}' $file0 > temp_129_f1in
awk '$1==1.290 {print $2,$5}' $file0 > temp_129_f1qe
awk '$1==1.300 {print $2,$4}' $file0 > temp_130_f1in
awk '$1==1.300 {print $2,$5}' $file0 > temp_130_f1qe
awk '$1==1.310 {print $2,$4}' $file0 > temp_131_f1in
awk '$1==1.310 {print $2,$5}' $file0 > temp_131_f1qe
awk '$1==1.320 {print $2,$4}' $file0 > temp_132_f1in
awk '$1==1.320 {print $2,$5}' $file0 > temp_132_f1qe
awk '$1==1.330 {print $2,$4}' $file0 > temp_133_f1in
awk '$1==1.330 {print $2,$5}' $file0 > temp_133_f1qe
awk '$1==1.340 {print $2,$4}' $file0 > temp_134_f1in
awk '$1==1.340 {print $2,$5}' $file0 > temp_134_f1qe
awk '$1==1.350 {print $2,$4}' $file0 > temp_135_f1in
awk '$1==1.350 {print $2,$5}' $file0 > temp_135_f1qe
awk '$1==1.360 {print $2,$4}' $file0 > temp_136_f1in
awk '$1==1.360 {print $2,$5}' $file0 > temp_136_f1qe
awk '$1==1.370 {print $2,$4}' $file0 > temp_137_f1in
awk '$1==1.370 {print $2,$5}' $file0 > temp_137_f1qe
awk '$1==1.380 {print $2,$4}' $file0 > temp_138_f1in
awk '$1==1.380 {print $2,$5}' $file0 > temp_138_f1qe
awk '$1==1.390 {print $2,$4}' $file0 > temp_139_f1in
awk '$1==1.390 {print $2,$5}' $file0 > temp_139_f1qe
awk '$1==1.400 {print $2,$4}' $file0 > temp_140_f1in
awk '$1==1.400 {print $2,$5}' $file0 > temp_140_f1qe
awk '$1==1.410 {print $2,$4}' $file0 > temp_141_f1in
awk '$1==1.410 {print $2,$5}' $file0 > temp_141_f1qe
awk '$1==1.420 {print $2,$4}' $file0 > temp_142_f1in
awk '$1==1.420 {print $2,$5}' $file0 > temp_142_f1qe
awk '$1==1.430 {print $2,$4}' $file0 > temp_143_f1in
awk '$1==1.430 {print $2,$5}' $file0 > temp_143_f1qe
awk '$1==1.440 {print $2,$4}' $file0 > temp_144_f1in
awk '$1==1.440 {print $2,$5}' $file0 > temp_144_f1qe
awk '$1==1.450 {print $2,$4}' $file0 > temp_145_f1in
awk '$1==1.450 {print $2,$5}' $file0 > temp_145_f1qe
awk '$1==1.460 {print $2,$4}' $file0 > temp_146_f1in
awk '$1==1.460 {print $2,$5}' $file0 > temp_146_f1qe
awk '$1==1.470 {print $2,$4}' $file0 > temp_147_f1in
awk '$1==1.470 {print $2,$5}' $file0 > temp_147_f1qe
awk '$1==1.480 {print $2,$4}' $file0 > temp_148_f1in
awk '$1==1.480 {print $2,$5}' $file0 > temp_148_f1qe
awk '$1==1.490 {print $2,$4}' $file0 > temp_149_f1in
awk '$1==1.490 {print $2,$5}' $file0 > temp_149_f1qe
awk '$1==1.500 {print $2,$4}' $file0 > temp_150_f1in
awk '$1==1.500 {print $2,$5}' $file0 > temp_150_f1qe










gracebat -hdevice PNG -printfile f1map/x_010_f1_map.png \
		-settype xy		-block temp_010_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_010_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_011_f1_map.png \
		-settype xy		-block temp_011_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_011_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_012_f1_map.png \
		-settype xy		-block temp_012_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_012_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_013_f1_map.png \
		-settype xy		-block temp_013_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_013_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_014_f1_map.png \
		-settype xy		-block temp_014_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_014_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_015_f1_map.png \
		-settype xy		-block temp_015_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_015_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_016_f1_map.png \
		-settype xy		-block temp_016_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_016_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_017_f1_map.png \
		-settype xy		-block temp_017_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_017_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_018_f1_map.png \
		-settype xy		-block temp_018_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_018_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_019_f1_map.png \
		-settype xy		-block temp_019_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_019_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask


gracebat -hdevice PNG -printfile f1map/x_020_f1_map.png \
		-settype xy		-block temp_020_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_020_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_021_f1_map.png \
		-settype xy		-block temp_021_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_021_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_022_f1_map.png \
		-settype xy		-block temp_022_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_022_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_023_f1_map.png \
		-settype xy		-block temp_023_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_023_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_024_f1_map.png \
		-settype xy		-block temp_024_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_024_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_025_f1_map.png \
		-settype xy		-block temp_025_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_025_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_026_f1_map.png \
		-settype xy		-block temp_026_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_026_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_027_f1_map.png \
		-settype xy		-block temp_027_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_027_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_028_f1_map.png \
		-settype xy		-block temp_028_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_028_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_029_f1_map.png \
		-settype xy		-block temp_029_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_029_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_030_f1_map.png \
		-settype xy		-block temp_030_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_030_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_031_f1_map.png \
		-settype xy		-block temp_031_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_031_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_032_f1_map.png \
		-settype xy		-block temp_032_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_032_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_033_f1_map.png \
		-settype xy		-block temp_033_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_033_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_034_f1_map.png \
		-settype xy		-block temp_034_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_034_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_035_f1_map.png \
		-settype xy		-block temp_035_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_035_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_036_f1_map.png \
		-settype xy		-block temp_036_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_036_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_037_f1_map.png \
		-settype xy		-block temp_037_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_037_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_038_f1_map.png \
		-settype xy		-block temp_038_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_038_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_039_f1_map.png \
		-settype xy		-block temp_039_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_039_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_040_f1_map.png \
		-settype xy		-block temp_040_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_040_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_041_f1_map.png \
		-settype xy		-block temp_041_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_041_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_042_f1_map.png \
		-settype xy		-block temp_042_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_042_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_043_f1_map.png \
		-settype xy		-block temp_043_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_043_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_044_f1_map.png \
		-settype xy		-block temp_044_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_044_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_045_f1_map.png \
		-settype xy		-block temp_045_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_045_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_046_f1_map.png \
		-settype xy		-block temp_046_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_046_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_047_f1_map.png \
		-settype xy		-block temp_047_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_047_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_048_f1_map.png \
		-settype xy		-block temp_048_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_048_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_049_f1_map.png \
		-settype xy		-block temp_049_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_049_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_050_f1_map.png \
		-settype xy		-block temp_050_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_050_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_051_f1_map.png \
		-settype xy		-block temp_051_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_051_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_052_f1_map.png \
		-settype xy		-block temp_052_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_052_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_053_f1_map.png \
		-settype xy		-block temp_053_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_053_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_054_f1_map.png \
		-settype xy		-block temp_054_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_054_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_055_f1_map.png \
		-settype xy		-block temp_055_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_055_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_056_f1_map.png \
		-settype xy		-block temp_056_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_056_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_057_f1_map.png \
		-settype xy		-block temp_057_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_057_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_058_f1_map.png \
		-settype xy		-block temp_058_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_058_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_059_f1_map.png \
		-settype xy		-block temp_059_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_059_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_060_f1_map.png \
		-settype xy		-block temp_060_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_060_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_061_f1_map.png \
		-settype xy		-block temp_061_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_061_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_062_f1_map.png \
		-settype xy		-block temp_062_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_062_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_063_f1_map.png \
		-settype xy		-block temp_063_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_063_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_064_f1_map.png \
		-settype xy		-block temp_064_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_064_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_065_f1_map.png \
		-settype xy		-block temp_065_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_065_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_066_f1_map.png \
		-settype xy		-block temp_066_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_066_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_067_f1_map.png \
		-settype xy		-block temp_067_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_067_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_068_f1_map.png \
		-settype xy		-block temp_068_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_068_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_069_f1_map.png \
		-settype xy		-block temp_069_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_069_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_070_f1_map.png \
		-settype xy		-block temp_070_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_070_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_071_f1_map.png \
		-settype xy		-block temp_071_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_071_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_072_f1_map.png \
		-settype xy		-block temp_072_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_072_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_073_f1_map.png \
		-settype xy		-block temp_073_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_073_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_074_f1_map.png \
		-settype xy		-block temp_074_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_074_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_075_f1_map.png \
		-settype xy		-block temp_075_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_075_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_076_f1_map.png \
		-settype xy		-block temp_076_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_076_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_077_f1_map.png \
		-settype xy		-block temp_077_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_077_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_078_f1_map.png \
		-settype xy		-block temp_078_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_078_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_079_f1_map.png \
		-settype xy		-block temp_079_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_079_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_080_f1_map.png \
		-settype xy		-block temp_080_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_080_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_081_f1_map.png \
		-settype xy		-block temp_081_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_081_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_082_f1_map.png \
		-settype xy		-block temp_082_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_082_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_083_f1_map.png \
		-settype xy		-block temp_083_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_083_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_084_f1_map.png \
		-settype xy		-block temp_084_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_084_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_085_f1_map.png \
		-settype xy		-block temp_085_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_085_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_086_f1_map.png \
		-settype xy		-block temp_086_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_086_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_087_f1_map.png \
		-settype xy		-block temp_087_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_087_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_088_f1_map.png \
		-settype xy		-block temp_088_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_088_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_089_f1_map.png \
		-settype xy		-block temp_089_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_089_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_090_f1_map.png \
		-settype xy		-block temp_090_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_090_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_091_f1_map.png \
		-settype xy		-block temp_091_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_091_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_092_f1_map.png \
		-settype xy		-block temp_092_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_092_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_093_f1_map.png \
		-settype xy		-block temp_093_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_093_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_094_f1_map.png \
		-settype xy		-block temp_094_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_094_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_095_f1_map.png \
		-settype xy		-block temp_095_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_095_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_096_f1_map.png \
		-settype xy		-block temp_096_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_096_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_097_f1_map.png \
		-settype xy		-block temp_097_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_097_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_098_f1_map.png \
		-settype xy		-block temp_098_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_098_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_099_f1_map.png \
		-settype xy		-block temp_099_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_099_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_100_f1_map.png \
		-settype xy		-block temp_100_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_100_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_101_f1_map.png \
		-settype xy		-block temp_101_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_101_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_102_f1_map.png \
		-settype xy		-block temp_102_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_102_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_103_f1_map.png \
		-settype xy		-block temp_103_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_103_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_104_f1_map.png \
		-settype xy		-block temp_104_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_104_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_105_f1_map.png \
		-settype xy		-block temp_105_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_105_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_106_f1_map.png \
		-settype xy		-block temp_106_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_106_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_107_f1_map.png \
		-settype xy		-block temp_107_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_107_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_108_f1_map.png \
		-settype xy		-block temp_108_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_108_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_109_f1_map.png \
		-settype xy		-block temp_109_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_109_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask


gracebat -hdevice PNG -printfile f1map/x_110_f1_map.png \
		-settype xy		-block temp_110_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_110_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_111_f1_map.png \
		-settype xy		-block temp_111_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_111_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_112_f1_map.png \
		-settype xy		-block temp_112_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_112_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_113_f1_map.png \
		-settype xy		-block temp_113_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_113_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_114_f1_map.png \
		-settype xy		-block temp_114_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_114_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_115_f1_map.png \
		-settype xy		-block temp_115_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_115_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_116_f1_map.png \
		-settype xy		-block temp_116_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_116_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_117_f1_map.png \
		-settype xy		-block temp_117_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_117_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_118_f1_map.png \
		-settype xy		-block temp_118_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_118_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_119_f1_map.png \
		-settype xy		-block temp_119_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_119_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask


gracebat -hdevice PNG -printfile f1map/x_120_f1_map.png \
		-settype xy		-block temp_120_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_120_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_121_f1_map.png \
		-settype xy		-block temp_121_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_121_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_122_f1_map.png \
		-settype xy		-block temp_122_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_122_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_123_f1_map.png \
		-settype xy		-block temp_123_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_123_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_124_f1_map.png \
		-settype xy		-block temp_124_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_124_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_125_f1_map.png \
		-settype xy		-block temp_125_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_125_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_126_f1_map.png \
		-settype xy		-block temp_126_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_126_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_127_f1_map.png \
		-settype xy		-block temp_127_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_127_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_128_f1_map.png \
		-settype xy		-block temp_128_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_128_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_129_f1_map.png \
		-settype xy		-block temp_129_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_129_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_130_f1_map.png \
		-settype xy		-block temp_130_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_130_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_131_f1_map.png \
		-settype xy		-block temp_131_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_131_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_132_f1_map.png \
		-settype xy		-block temp_132_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_132_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_133_f1_map.png \
		-settype xy		-block temp_133_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_133_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_134_f1_map.png \
		-settype xy		-block temp_134_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_134_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_135_f1_map.png \
		-settype xy		-block temp_135_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_135_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_136_f1_map.png \
		-settype xy		-block temp_136_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_136_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_137_f1_map.png \
		-settype xy		-block temp_137_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_137_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_138_f1_map.png \
		-settype xy		-block temp_138_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_138_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_139_f1_map.png \
		-settype xy		-block temp_139_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_139_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_140_f1_map.png \
		-settype xy		-block temp_140_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_140_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_141_f1_map.png \
		-settype xy		-block temp_141_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_141_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_142_f1_map.png \
		-settype xy		-block temp_142_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_142_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_143_f1_map.png \
		-settype xy		-block temp_143_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_143_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_144_f1_map.png \
		-settype xy		-block temp_144_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_144_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_145_f1_map.png \
		-settype xy		-block temp_145_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_145_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_146_f1_map.png \
		-settype xy		-block temp_146_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_146_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_147_f1_map.png \
		-settype xy		-block temp_147_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_147_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_148_f1_map.png \
		-settype xy		-block temp_148_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_148_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_149_f1_map.png \
		-settype xy		-block temp_149_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_149_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask

gracebat -hdevice PNG -printfile f1map/x_150_f1_map.png \
		-settype xy		-block temp_150_f1in		-graph 0 -bxy 1:2 \
		-settype xy		-block temp_150_f1qe		-graph 0 -bxy 1:2 \
		-p map_for_f1.par -noask






rm -f temp*
