#!/bin/csh
uname -a | cat > out.log
more /proc/cpuinfo | cat >> out.log
more /proc/meminfo | cat >> out.log

source /home/zwzhao/set_solidGEMC_farm

gemc \
-gcard=gemc.gcard \
-DBHOST=$GEMC_HOST \
-HIT_PROCESS_LIST=solid \
-USE_PHYSICSL=QGSP_BERT_HP  \
-HALL_MATERIAL=Air \
-RECORD_PASSBY=1 \
-FIELD_DIR=$GEMC_field \
-HALL_FIELD=solenoid_CLEO \
-BEAM_P="e-, 11*GeV, 0*deg, 0*deg" \
-BEAM_V="(0, 0, -400)cm" \
-SPREAD_V="(0.1, 0)cm" \
-N=1e6 \
-OUTPUT="evio,out.evio" \
-USE_QT=0 | cat >> out.log

# common area
setenv ROOTSYS $JLAB_SOFTWARE/root/5.32
setenv PATH ${ROOTSYS}/bin:${PATH}
setenv LD_LIBRARY_PATH ${ROOTSYS}/lib/root:${LD_LIBRARY_PATH}

gemc_evio2root out.evio out.root | cat >> out.log
root -b -q copytree.C
mv -f out_fluxT.root out.root



