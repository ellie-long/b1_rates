# Check that Fortran, C++ and Mathematica versions of example code give
# identical output.  If all is good, there should be no output from this
# script.  (Note that in some isolated cases, the last significant digit
# of the Fortran/C++ output might differ from that in the Mathematica
# output due to numerical rounding errors in the Fortran/C++ case.)
# Comments to Graeme Watt <Graeme.Watt@cern.ch>.
diff3 xbbar_vs_x.dat xbbar_vs_x_cpp.dat xbbar_vs_x_math.dat
diff3 xcbar_vs_x.dat xcbar_vs_x_cpp.dat xcbar_vs_x_math.dat
diff3 xsbar_vs_x.dat xsbar_vs_x_cpp.dat xsbar_vs_x_math.dat
diff3 xubar_vs_x.dat xubar_vs_x_cpp.dat xubar_vs_x_math.dat
diff3 xdbar_vs_x.dat xdbar_vs_x_cpp.dat xdbar_vs_x_math.dat
diff3 xglu_vs_x.dat xglu_vs_x_cpp.dat xglu_vs_x_math.dat
diff3 xdn_vs_x.dat xdn_vs_x_cpp.dat xdn_vs_x_math.dat
diff3 xup_vs_x.dat xup_vs_x_cpp.dat xup_vs_x_math.dat
diff3 xstr_vs_x.dat xstr_vs_x_cpp.dat xstr_vs_x_math.dat
diff3 xchm_vs_x.dat xchm_vs_x_cpp.dat xchm_vs_x_math.dat
diff3 xbot_vs_x.dat xbot_vs_x_cpp.dat xbot_vs_x_math.dat
diff3 xbbar_vs_q2.dat xbbar_vs_q2_cpp.dat xbbar_vs_q2_math.dat
diff3 xcbar_vs_q2.dat xcbar_vs_q2_cpp.dat xcbar_vs_q2_math.dat
diff3 xsbar_vs_q2.dat xsbar_vs_q2_cpp.dat xsbar_vs_q2_math.dat
diff3 xubar_vs_q2.dat xubar_vs_q2_cpp.dat xubar_vs_q2_math.dat
diff3 xdbar_vs_q2.dat xdbar_vs_q2_cpp.dat xdbar_vs_q2_math.dat
diff3 xglu_vs_q2.dat xglu_vs_q2_cpp.dat xglu_vs_q2_math.dat
diff3 xdn_vs_q2.dat xdn_vs_q2_cpp.dat xdn_vs_q2_math.dat
diff3 xup_vs_q2.dat xup_vs_q2_cpp.dat xup_vs_q2_math.dat
diff3 xstr_vs_q2.dat xstr_vs_q2_cpp.dat xstr_vs_q2_math.dat
diff3 xchm_vs_q2.dat xchm_vs_q2_cpp.dat xchm_vs_q2_math.dat
diff3 xbot_vs_q2.dat xbot_vs_q2_cpp.dat xbot_vs_q2_math.dat
echo "If no other output than this message, script was successful!"
