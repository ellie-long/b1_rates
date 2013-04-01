
C     ==============
      PROGRAM QUPROG
C     ==============

      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      COMMON/GAUS96/XI(96),WI(96),XX(97),NTERMS
      COMMON/INPUT/alambda,flavor,qsct,qsdt,iord,mode
      COMMON/GRID/IQ0,IQC,IQB,NXGRI,NQGRI
      COMMON/QNOUGHT/Q0,ZM2,AMSR,chmq,chmq2,chmq24
      COMMON/CONTROL/READIN,HEAVY,NACT,IVFN
      COMMON/PARVAL/STVAL(45),PASVAL(45)
      COMMON/PARCOV/C(11),DUPP(11,11),DDOWN(11,11)
      COMMON/NORMS/UN,DN,GN,UBDBN
      dimension PVAL(45)
      LOGICAL DOERRS,READIN,HEAVY,VFN
      INTEGER NACT,IVFN,IORD,mode
      INTEGER IQ0,IQC,IQB,NXGRI,NQGRI
      INTEGER NFREE,NDIMS,NSYSF
      INTEGER I,J,II,K,L,IK
c-- for zm set heavy=.false. and vfn=.false.
c--for ff set heavy=.true. and vfn=.false.
c--for tr set heavy=.false, and vfn=.true.
c--set readin=.false.
c--set doerrs=.true. only if you want full errors- it takes
c--22*times as long!

      DATA DOERRS,READIN,HEAVY,VFN
     +     /.TRUE.,.FALSE.,.TRUE.,.FALSE./

       PARAMETER (NFREE=11)
C--NFREE IS THE NUMBER OF FREE PARAMETERS, NDIMS IS THE TOTAL NUMBER
C--MOST OF THESE ARE ZERO-AND ARE UNUSED- SEE STVAL ARRAY
      PARAMETER (NDIMS=45)

      INTEGER IFREE(NFREE)
C-- THIS SPECIFIES WHICH OF THE PARAMETERS ARE FREE      
      DATA IFREE/2,4,6,8,9,10,11,12,13,14,16/


      DATA ZM/91.187/
      DATA THETAW/0.2315/

      DIMENSION PWGT(20),
     .          RES(NFREE),RESIJ(NFREE,NFREE),RES2(NFREE),
     .          RESKL(0:160,0:160),RGSKL(0:160,0:160),
     .          RDSKL(0:160,0:160),RSSKL(0:160,0:160),
     .          ERRU(0:160,0:160),ERRG(0:160,0:160),
     .          ERRD(0:160,0:160),ERRS(0:160,0:160)
       DIMENSION DUNOR(NDIMS),DDNOR(NDIMS),DGNOR(NDIMS)
     .          ,DAMSR(NDIMS),UNSS(NDIMS),DNSS(NDIMS)
     .          ,GNSS(NDIMS),UNSSS(NDIMS),DNSSS(NDIMS)
     .          ,GNSSS(NDIMS),UNOR(2),DNOR(2)
     .          ,AMSS(NDIMS),AMSSS(NDIMS),GNOR(2)

       DIMENSION      UCENT(0:160,0:160),
     .          UUP(2,0:160,0:160),DUDPAR(NDIMS,0:160,0:160),
     .          DUP(2,0:160,0:160),DDDPAR(NDIMS,0:160,0:160),
     .          DCENT(0:160,0:160),ERRC(0:160,0:160),
     .          DUPDUM(0:160,0:160),DDNDUM(0:160,0:160),
     .          UUPDUM(0:160,0:160),UDNDUM(0:160,0:160),
     .          RCSKL(0:160,0:160),ERRL(0:160,0:160)
     .          ,RFSKL(0:160,0:160),RLSS(NFREE,0:160,0:160),
     .          ERRF(0:160,0:160),RLSKL(0:160,0:160)
       DIMENSION SIGCEN(0:160,0:160),SIG(2,0:160,0:160),
     .          DCCPAR(NDIMS,0:160,0:160),RCCKL(0:160,0:160),
     .          ERCC(0:160,0:160),
     .          SIGUP(0:160,0:160),SIGDN(0:160,0:160)
       DIMENSION SIGPNEN(0:160,0:160),SIGPN(2,0:160,0:160),
     .          DPNCPAR(NDIMS,0:160,0:160),RPNCKL(0:160,0:160),
     .          ERPNC(0:160,0:160),
     .          SIGPNUP(0:160,0:160),SIGPNDN(0:160,0:160)
       DIMENSION SIGPCEN(0:160,0:160),SIGP(2,0:160,0:160),
     .          DPCCPAR(NDIMS,0:160,0:160),RPCCKL(0:160,0:160),
     .          ERPCC(0:160,0:160),
     .          SIGPUP(0:160,0:160),SIGPDN(0:160,0:160)
       DIMENSION SIGNEN(0:160,0:160),SIGN(2,0:160,0:160),
     .          DNCPAR(NDIMS,0:160,0:160),RNCKL(0:160,0:160),
     .          ERNC(0:160,0:160),
     .          SIGNUP(0:160,0:160),SIGNDN(0:160,0:160)
       DIMENSION XF3PNEN(0:160,0:160),XF3NP(2,0:160,0:160),
     .          XF3PPNR(NDIMS,0:160,0:160),RF3PNL(0:160,0:160),
     .          ERPF3N(0:160,0:160),
     .          XF3NPUP(0:160,0:160),XF3NPDN(0:160,0:160)
       DIMENSION F2NPEN(0:160,0:160),F2NP(2,0:160,0:160),
     .          F2NPPAR(NDIMS,0:160,0:160),RF2NPKL(0:160,0:160),
     .          ERF2NP(0:160,0:160),
     .          F2NPUP(0:160,0:160),F2NPDN(0:160,0:160)
       DIMENSION FLNCPN(0:160,0:160),FLNP(2,0:160,0:160),
     .          FLNPPAR(NDIMS,0:160,0:160),RFLNPKL(0:160,0:160),
     .          ERFLNP(0:160,0:160),
     .          FLNPUP(0:160,0:160),FLNPDN(0:160,0:160)
       DIMENSION UBCEN(0:160,0:160),UBUP(2,0:160,0:160),
     .          DUBPAR(NDIMS,0:160,0:160),RUBKL(0:160,0:160),
     .          ERUB(0:160,0:160),
     .          UBUPDUM(0:160,0:160),UBDNDUM(0:160,0:160)
       DIMENSION DBCEN(0:160,0:160),DBUP(2,0:160,0:160),
     .          DDBPAR(NDIMS,0:160,0:160),RDBKL(0:160,0:160),
     .          ERDB(0:160,0:160),
     .          DBUPDUM(0:160,0:160),DBDNDUM(0:160,0:160)
       DIMENSION STCEN(0:160,0:160),STUP(2,0:160,0:160),
     .          DSTPAR(NDIMS,0:160,0:160),RSTKL(0:160,0:160),
     .          ERST(0:160,0:160),
     .          STUPDUM(0:160,0:160),STDNDUM(0:160,0:160)
       DIMENSION CHCEN(0:160,0:160),CHUP(2,0:160,0:160),
     .          DCHPAR(NDIMS,0:160,0:160),RCHKL(0:160,0:160),
     .          ERCH(0:160,0:160),
     .          CHUPDUM(0:160,0:160),CHDNDUM(0:160,0:160)
       DIMENSION BTCEN(0:160,0:160),BTUP(2,0:160,0:160),
     .          DBTPAR(NDIMS,0:160,0:160),RBTKL(0:160,0:160),
     .          ERBT(0:160,0:160),
     .          BTUPDUM(0:160,0:160),BTDNDUM(0:160,0:160)
       DIMENSION DUCEN(0:160,0:160),DUUP(2,0:160,0:160),
     .          DDUPAR(NDIMS,0:160,0:160),RDUKL(0:160,0:160),
     .          ERDU(0:160,0:160),
     .          DUUPDUM(0:160,0:160),DUDNDUM(0:160,0:160)

       DIMENSION      F2CENT(0:160,0:160),GCENT(0:160,0:160),
     .          F2UP(2,0:160,0:160),F2DPAR(NDIMS,0:160,0:160),
     .          F2CUP(2,0:160,0:160),F2CPAR(NDIMS,0:160,0:160),
     .          GUP(2,0:160,0:160),DGDPAR(NDIMS,0:160,0:160), 
     .          FLUP(2,0:160,0:160),FLDPAR(NDIMS,0:160,0:160),
     .          SUP(2,0:160,0:160),DSDPAR(NDIMS,0:160,0:160),
     .          TMPVAL(NDIMS),FLCENT(0:160,0:160),
     .          SCENT(0:160,0:160),F2CCEN(0:160,0:160),
     .          FLUPDUM(0:160,0:160),FLDNDUM(0:160,0:160),
     .          GUPDUM(0:160,0:160),GDNDUM(0:160,0:160),
     .          F2UPDUM(0:160,0:160),F2DNDUM(0:160,0:160),
     .          F2CUPDU(0:160,0:160),F2CDNDU(0:160,0:160),
     .          SUPDUM(0:160,0:160),SDNDUM(0:160,0:160)

      DATA STVAL/0.5000,4.0065,0.0000,5.0402,0.5000,5.3359,0.0000,
     .           6.2124,0.6022,-0.2356,8.8592,6.7673,-0.2044,
     .           6.1582,0.0000,0.2652,0.118,
     .           0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
     .           0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
     .           0.0,0.0,0.0,
     .           0.0,0.0,0.0/


c--try 3 way logic ffn/zm-vfn/rt-vfn
      IF(HEAVY)THEN
      IVFN=1
      ELSE
      IVFN=0
      ENDIF
      IF(VFN)THEN
      IVFN=IVFN+2
      ELSE
      IVFN=IVFN
      ENDIF
C IVFN=0 IS ZM-VFN, 1 IS FFN,2 IS RT-VFN, 3 IS NOT ALLOWED  
      write(*,*)'IVFN=',IVFN
      IF(IVFN.EQ.3)THEN
      WRITE(*,*)'IVFN=3 SO STOP',IVFN
      STOP
      ENDIF    

c--roberts/THORNE initialisation and qcdnum initialisations

      CALL INITIAL



c--read central fit PDF params
      if(ivfn.eq.0)then
      open(unit=05,file='parcen_zm.dat',status='old')
      elseif(ivfn.eq.1)then
      open(unit=05,file='parcen_ff.dat',status='old')
      elseif(ivfn.eq.2)then
      open(unit=05,file='parcen_tr.dat',status='old')
      endif
       read(05,57)(c(i), i=1,nfree)
c      read from parcen.dat
 57   FORMAT(11(E12.4,1X))

c--and convert it to THE pval array
c i.e fill in the other necessary fixed params 

        DO I=1,NDIMS
        PVAL(I)=STVAL(I)
        ENDDO
         DO IK=1,NFREE
         I=IFREE(IK)
         PVAL(I)=C(IK)
         ENDDO
      DO I=1,NDIMS
      PASVAL(I)=PVAL(I)
        WRITE (*,*) 'PARAM, VAL = ',I,PASVAL(I)
      ENDDO

c--first compute using only the  central values of the main fit 
C--   do evolution over whole grid

      CALL GRCUTS(-1D0,-1D0,-1D0,-1D0)
      CALL EVOLVE(PVAL)
        alambda=15.400*PVAL(17)-1.5095
        if(alambda.le.0.01)alambda=0.01
      write(*,*)'alambda',alambda
      WRITE (*,*) 'UN,DN,GN',UN,DN,GN

c--you can now calculate quantities for any x,q2 value
C--SET UP A LOOP OVER Q2
c             DO I=0,160
c             IF(I.LE.72)THEN
c              Q2=10**(5D0/120D0*I)-7D-1
c            ELSE
c            Q2=10**(2D0/88D0*(I-72)+3D0)
c            ENDIF
c this commented grid is very fine and thus time consuming- do checking on
c--coarse grid

             DO I=0,60
             Q2=10**(5D0/60D0*I)

C--if you want to look at the NC cross-sections at high q2 you have to call
c--q2combs to set up the A and B ceofficients which contain the Z propagator 
c--and elctroweak parameters.They are q2 dependent.


             CALL Q2COMBS(Q2)

C-- NOW SET UP A LOOP OVER X
C              DO J=0,160
C            IF(J.LE.80)THEN
C            X=10**(6D0/120D0*J-6D0)
C            ELSE
C             X=10**(2D0/80D0*(J-80)-201D-2)
C            ENDIF
c--THAT WAS THE FINE GRID-HERE IS THE COARSE

             DO J=0,60
             X=10**(6D0/60D0*J-601D-2)

c----------------------------------------------------------------------------
c--finally call the resullts routine
C--THIS ROUTINE gives ALL QUANTITIES OF INTEREST for the current pval array
      CALL RESULTS(Q2,X,F2,FL,F2C,F2NC,FLNC,XF3NC
     +             ,UQ,DQ,GQ,SQ,UB,DB,ST,CH,BT,DU
     +             ,SIGNCEM,SIGCCEM,SIGNCEP,SIGCCEP)
c-----------------------------------------------------------------------------

c-- F2, FL are F2, FL for ep by gamma exchange, F2C is F2 charm
c--F2NC,FLNC,XF3Nc are the ep structure functions for gamma and Z0
c--UQ,DQ,GQ,SQ are uvalence,dvalence, gluon and total sea PDfs
c--UB,DB,ST,CH,BT,DU are ubar,dbar,sbar,cbar,bbar,and d/u
C-SIGNCEM,SIGCCEM,SIGNCEP,SIGCCEP are the reduced cross-sections for
C-neutral current e-, Charged current e-, Neutral current e+, 
c-Charged current e+, respectivelu
C-------------------------------------------------------------------------

c---save these results for each i,j for the central PVAL array
             F2CENT(I,J)=F2
             FLCENT(I,J)=FL
             F2CCEN(I,J)=F2C
             XF3PNEN(I,J)=XF3NC
             F2NPEN(I,J)=F2NC
             FLNCPN(I,J)=FLNC
             UCENT(I,J)=UQ
             DCENT(I,J)=DQ
             GCENT(I,J)=GQ
             SCENT(I,J)=SQ
             UBCEN(I,J)=UB
             DBCEN(I,J)=DB
             STCEN(I,J)=ST
             CHCEN(I,J)=CH
             BTCEN(I,J)=BT
             DUCEN(I,J)=DU
             SIGNEN(I,J)=SIGNCEM
             SIGCEN(I,J)=SIGCCEM
             SIGPNEN(I,J)=SIGNCEP
             SIGPCEN(I,J)=SIGCCEP

             ENDDO
             ENDDO

             UNORM=UN
             DNORM=DN
             GNORM=GN

c-- at this point you have various structure functions, parton distributions
c--and reduced cross-sectiosn of interest- 
c-- the rest of the code is to get errors on them- which takes
c--2 *nfree= 22 times as long!
c-----------------------------------------------------------------------------
      write(*,*)'calc for central values complete-now error bands'
c----------------------------------------------------------------------------



            IF(DOERRS)THEN

c  --now get errors on all these from the 2*Neigenvector PDF sets
c--there are input files for statistical (ie uncorrelated)
c--and correlated systematic--and total errors
c--this example is for total errors 
c      open(unit=03,file='instat_**.dat',status='old')
c      open(unit=03,file='insys_**.dat',status='old')      
      if(ivfn.eq.0)then
      open(unit=03,file='intot_zm.dat',status='old')
      elseif(ivfn.eq.1)then
      open(unit=03,file='intot_ff.dat',status='old')
      elseif(ivfn.eq.2)then
      open(unit=03,file='intot_tr.dat',status='old')
      endif  

 110  format(11(1x,f11.7))
 112  format(1x,'params up k=',i2,11(1x,f11.7))
 113  format(1x,'params down k=',i2,11(1x,f11.7))

        DO IK=1,NFREE

C-read up and down errors for each of nfree eigenvectors
C-read ddup and ddown
      read(03,*)(dupp(i,ik),i=1,nfree)
      read(03,*)(ddown(i,ik),i=1,nfree)

        ENDDO

      do ik=1,nfree
      print 112, ik,(dupp(i,ik),i=1,nfree)           
      print 113, ik,(ddown(i,ik),i=1,nfree)
      enddo
C          get the new PDF array for evolution
c-fromm ddup or down and put it in pval
C-first need to modify it to put in the fixed parameter values, just as we did
c--for the central vaues 

      DO I=1,NDIMS 
          PVAL(I)=STVAL(I)
       ENDDO 

       DO IK=1,NFREE
c---assign j=1 to up errors and j=2 to down errors
       DO J=1,2
        DO II=1,NFREE
         I=IFREE(II)
       IF(J.EQ.1)THEN
       PVAL(I)=DUPP(II,IK)
        ELSEIF(J.EQ.2)then
        pval(i)=DDOWN(II,IK)
       ENDIF
        ENDDO 
c--end FOR II LOOP

c--check pval values are reasonable
      DO I=1,NDIMS
      PASVAL(I)=PVAL(I)
        WRITE (*,*) 'PARAM, VAL,ik,j= ',I,PASVAL(I),IK,J
      ENDDO

c--evolve within this j=1,2 loop for each of the nfree eigenvectors in turn
            CALL GRCUTS(-1D0,-1D0,-1D0,-1D0)
             CALL EVOLVE(PVAL)
       alambda=15.400*PVAL(17)-1.5095
        if(alambda.le.0.01)alambda=0.01
      write(*,*)'alambda,ik,j',alambda,ik,j
      WRITE (*,*) 'UN,DN,GN,ik,j',UN,DN,GN,ik,j

c-- now  ready to evaluate all the quantities again: once for each of the
c--2 *Neigenvector PDF sets
c-- in this routine the loop j=1,2 does the up and down shifts
c--and the loop ik=1,nfree goes over the nfree eigenvectors
c-- this is done for each x,q2 value of interest in the k,l loops 

C             DO K=0,160
C             IF(K.LE.72)THEN
C              Q2=10**(5D0/120D0*K)-7D-1
C            ELSE
C            Q2=10**(2D0/88D0*(K-72)+3D0)
C            ENDIF

             DO K=0,60
             Q2=10**(5D0/60D0*K)

            CALL Q2COMBS(Q2)

C              DO L=0,160
C            IF(L.LE.80)THEN
C            X=10**(6D0/120D0*L-6D0)
C            ELSE
C             X=10**(2D0/80D0*(L-80)-201D-2)
C            ENDIF

             DO L=0,60
             X=10**(6D0/60D0*L-601D-2)


      CALL RESULTS(Q2,X,F2,FL,F2C,F2NC,FLNC,XF3NC
     +             ,UQ,DQ,GQ,SQ,UB,DB,ST,CH,BT,DU
     +             ,SIGNCEM,SIGCCEM,SIGNCEP,SIGCCEP)
c--save these results for eachj,k,l
c ie for each x,q2 point and for up and down shifts
             F2UP(J,K,L)=F2
             FLUP(J,K,L)=FL
             F2CUP(J,K,L)=F2C
             XF3NP(J,K,L)=XF3NC
             F2NP(J,K,L)=F2NC
             FLNP(J,K,L)=FLNC
             UUP(J,K,L)=UQ
             DUP(J,K,L)=DQ
             GUP(J,K,L)=GQ
             SUP(J,K,L)=SQ           
             UBUP(J,K,L)=UB
             DBUP(J,K,L)=DB 
             STUP(J,K,L)=ST
             CHUP(J,K,L)=CH
             BTUP(J,K,L)=BT
             SIG(J,K,L)=SIGCCEM
             SIGN(J,K,L)=SIGNCEM
             SIGP(J,K,L)=SIGCCEP
             SIGPN(J,K,L)=SIGNCEP
             DUUP(J,K,L)=DU
             ENDDO
             ENDDO
c--calculation of u,d and glu norms for each of the alternative parameter sets

       UNOR(J)=UN
       DNOR(J)=DN
        GNOR(J)=GN

          write(*,*)'pval end j,ik',j,ik,pval(ik)
C--END 1,2 UP DOwN LOOP
           ENDDO

C--STILL In IK=1,NFREE LOOP HERE 

c -    now have up an down of each of the iK=1,nfree eigenvectOR shifts

c-add up ((up-down)/2)**2 for each i and take sqrt for each quantity

           DUNOR(IK) = (UNOR(1)-UNOR(2))**2.
           DDNOR(IK) = (DNOR(1)-DNOR(2))**2.
           DGNOR(IK) = (GNOR(1)-GNOR(2))**2.

c-the quantity might be a parameter or it might be a value of f2 
c--for a partICULAr x,q2
            DO K=0,160
              DO L=0,160

                F2DPAR(IK,K,L) = (F2UP(1,K,L)-F2UP(2,K,L))**2.
                F2CPAR(IK,K,L) = (F2CUP(1,K,L)-F2CUP(2,K,L))**2.
                FLDPAR(IK,K,L) = (FLUP(1,K,L)-FLUP(2,K,L))**2.
                F2NPPAR(IK,K,L)= (F2NP(1,K,L)-F2NP(2,K,L))**2.
                XF3PPNR(IK,K,L)= (XF3NP(1,K,L)-XF3NP(2,K,L))**2.
                FLNPPAR(IK,K,L)= (FLNP(1,K,L)-FLNP(2,K,L))**2.

               DUDPAR(IK,K,L) = (UUP(1,K,L)-UUP(2,K,L))**2.
                DDDPAR(IK,K,L) = (DUP(1,K,L)-DUP(2,K,L))**2.
                DGDPAR(IK,K,L) = (GUP(1,K,L)-GUP(2,K,L))**2.
                DSDPAR(IK,K,L) = (SUP(1,K,L)-SUP(2,K,L))**2.
                DUBPAR(IK,K,L) = (UBUP(1,K,L)-UBUP(2,K,L))**2.
                DDBPAR(IK,K,L) = (DBUP(1,K,L)-DBUP(2,K,L))**2.
                DSTPAR(IK,K,L) = (STUP(1,K,L)-STUP(2,K,L))**2.
                DCHPAR(IK,K,L) = (CHUP(1,K,L)-CHUP(2,K,L))**2.
                DBTPAR(IK,K,L) = (BTUP(1,K,L)-BTUP(2,K,L))**2.
                DDUPAR(IK,K,L) = (DUUP(1,K,L)-DUUP(2,K,L))**2.



                DCCPAR(IK,K,L) = (SIG(1,K,L)-SIG(2,K,L))**2.
                DNCPAR(IK,K,L) = (SIGN(1,K,L)-SIGN(2,K,L))**2.
               DPCCPAR(IK,K,L) = (SIGP(1,K,L)-SIGP(2,K,L))**2.
             DPNCPAR(IK,K,L) = (SIGPN(1,K,L)-SIGPN(2,K,L))**2.
 

              ENDDO
            ENDDO

C--HERE IS THE IK ENDDO
 89   ENDDO

c--calculation of diagonal errors now
c--note the dividing by two is done here- first a
C--SIMPLE CALCULATION OF ERRORS ON THE NORMS OF UV,DV,AND GLUE FOR ILLUSTRATION
        UNKL=0.0
        DNKL=0.0
        GNKL=0.0

        do ik=1,nfree
        unkl=unkl+dunor(ik)
        dnkl=dnkl+ddnor(ik)
        gnkl=gnkl+dgnor(ik)

        enddo
        ERRUN=0.5*SQRT(UNKL) 
        ERRDN=0.5*SQRT(DNKL) 
        ERRGN=0.5*SQRT(GNKL)

        WRITE(*,*)'ERR ON P1U,P1D,P1G',ERRUN,ERRDN,ERRGN

C---NOW THE X,Q2 LOOPS OVER OTHER QUNATITIES

         DO K=0,160
        DO L=0,160
        RFSKL(K,L)=0.0
        RCSKL(K,L)=0.0
        RLSKL(K,L)=0.0
        RFLNPKL(K,L)=0.
        RF2NPKL(K,L)=0.
        RF3PNL(K,L)=0.0  

        RESKL(K,L)=0.0
        RDSKL(K,L)=0.0
        RGSKL(K,L)=0.0
        RSSKL(K,L)=0.0

        RUBKL(K,L)=0.0
        RDBKL(K,L)=0.0
        RSTKL(K,L)=0.0
        RCHKL(K,L)=0.0
        RBTKL(K,L)=0.0
        RDUKL(K,L)=0.0

        RCCKL(K,L)=0.0
        RPNCKL(K,L)=0.0
        RPCCKL(K,L)=0.0
        RNCKL(K,L)=0.0


           DO Ik=1,NFREE
           RFSKL(K,L)=F2DPAR(IK,K,L) +RFSKL(K,L)
           RLSKL(K,L)=FLDPAR(IK,K,L) +RLSKL(K,L)
           RCSKL(K,L)=F2CPAR(IK,K,L) +RCSKL(K,L)

           RF2NPKL(K,L)=F2NPPAR(IK,K,L) +RF2NPKL(K,L)
           RFLNPKL(K,L)=FLNPPAR(IK,K,L) +RFLNPKL(K,L)
           RF3PNL(K,L)=XF3PPNR(IK,K,L) +RF3PNL(K,L)

           RESKL(K,L)=DUDPAR(IK,K,L) +RESKL(K,L)
           RDSKL(K,L)=DDDPAR(IK,K,L) +RDSKL(K,L)
           RGSKL(K,L)=DGDPAR(IK,K,L) +RGSKL(K,L)
           RSSKL(K,L)=DSDPAR(IK,K,L) +RSSKL(K,L)

           RUBKL(K,L)=DUBPAR(IK,K,L) +RUBKL(K,L)
           RDBKL(K,L)=DDBPAR(IK,K,L) +RDBKL(K,L)
           RSTKL(K,L)=DSTPAR(IK,K,L) +RSTKL(K,L)
           RCHKL(K,L)=DCHPAR(IK,K,L) +RCHKL(K,L)
           RBTKL(K,L)=DBTPAR(IK,K,L) +RBTKL(K,L)
           RDUKL(K,L)=DDUPAR(IK,K,L) +RDUKL(K,L)

           RCCKL(K,L)=DCCPAR(IK,K,L) +RCCKL(K,L)
           RNCKL(K,L)=DNCPAR(IK,K,L) +RNCKL(K,L)
           RPCCKL(K,L)=DPCCPAR(IK,K,L) +RPCCKL(K,L)
           RPNCKL(K,L)=DPNCPAR(IK,K,L) +RPNCKL(K,L)
           ENDDO

       ERRF(K,L)=0.5*SQRT(RFSKL(K,L))
        ERRC(K,L)=0.5*SQRT(RCSKL(K,L))
        ERRL(K,L)=0.5*SQRT(RLSKL(K,L))

        ERFLNP(K,L)=0.5*SQRT(RFLNPKL(K,L))
        ERF2NP(K,L)=0.5*SQRT(RF2NPKL(K,L))
        ERPF3N(K,L)=0.5*SQRT(RF3PNL(K,L))

        ERRU(K,L)=0.5*SQRT(RESKL(K,L)) 
        ERRG(K,L)=0.5*SQRT(RGSKL(K,L))
        ERRD(K,L)=0.5*SQRT(RDSKL(K,L))
        ERRS(K,L)=0.5*SQRT(RSSKL(K,L)) 
 
        ERUB(K,L)=0.5*SQRT(RUBKL(K,L)) 
        ERDB(K,L)=0.5*SQRT(RDBKL(K,L))
        ERST(K,L)=0.5*SQRT(RSTKL(K,L))
        ERCH(K,L)=0.5*SQRT(RCHKL(K,L)) 
        ERBT(K,L)=0.5*SQRT(RBTKL(K,L))
        ERDU(K,L)=0.5*SQRT(RDUKL(K,L))
 
       ERCC(K,L)=0.5*SQRT(RCCKL(K,L))
        ERNC(K,L)=0.5*SQRT(RNCKL(K,L))
        ERPCC(K,L)=0.5*SQRT(RPCCKL(K,L))
        ERPNC(K,L)=0.5*SQRT(RPNCKL(K,L))


       ENDDO
        ENDDO
C--THIS IS THE ENDIF FOR .DOERRS. 
        ENDIF

c-------------------------------------------------------------------
      write(*,*)'calculation of error bands complete-output to grids'
c------------------------------------------------------------------------
C--NOW WE'VE CONSTRUCTED THE QUANTITIES OF INTEREST ACROSS A WHOLE X,Q2
C--GRID we'll OUTPUT ONTO GRID files

c--then the error output

        OPEN (UNIT=19,FILE='f2_pub_ff_tot.dat',STATUS='UNKNOWN')
        DO I=0,160
        DO J=0,160
          F2UPDUM(I,J)=F2CENT(I,J)+ERRF(I,J)
          F2DNDUM(I,J)=F2CENT(I,J)-ERRF(I,J)
          WRITE(19,53) F2CENT(I,J),F2UPDUM(I,J),F2DNDUM(I,J)
        ENDDO
       ENDDO
      CLOSE (UNIT=19)

        OPEN (UNIT=19,FILE='fl_pub_ff_tot.dat',STATUS='UNKNOWN')
        DO I=0,160
        DO J=0,160
          FLUPDUM(I,J)=FLCENT(I,J)+ERRL(I,J)
          FLDNDUM(I,J)=FLCENT(I,J)-ERRL(I,J)
         WRITE(19,53) FLCENT(I,J),FLUPDUM(I,J),FLDNDUM(I,J)
       ENDDO
       ENDDO
      CLOSE (UNIT=19)

        OPEN (UNIT=19,FILE='f2c_pub_ff_tot.dat',STATUS='UNKNOWN')
        DO I=0,160
        DO J=0,160
          F2CUPDU(I,J)=F2CCEN(I,J)+ERRC(I,J)
          F2CDNDU(I,J)=F2CCEN(I,J)-ERRC(I,J)
          WRITE(19,53) F2CCEN(I,J),F2CUPDU(I,J),F2CDNDU(I,J)
        ENDDO
       ENDDO
      CLOSE (UNIT=19)



        OPEN (UNIT=19,FILE='xf3ncep_pub_ff_tot.dat',STATUS='UNKNOWN')
        DO I=0,160
        DO J=0,160
          XF3NPUP(I,J)=XF3PNEN(I,J)+ERPF3N(I,J)
          XF3NPDN(I,J)=XF3PNEN(I,J)-ERPF3N(I,J)
          WRITE(19,53) XF3PNEN(I,J),XF3NPUP(I,J),XF3NPDN(I,J)
        ENDDO
       ENDDO
      CLOSE (UNIT=19)

        OPEN (UNIT=19,FILE='f2ncep_pub_ff_tot.dat',STATUS='UNKNOWN')
        DO I=0,160
        DO J=0,160
          F2NPUP(I,J)=F2NPEN(I,J)+ERF2NP(I,J)
          F2NPDN(I,J)=F2NPEN(I,J)-ERF2NP(I,J)
          WRITE(19,53) F2NPEN(I,J),F2NPUP(I,J),F2NPDN(I,J)
        ENDDO
       ENDDO
      CLOSE (UNIT=19)


        OPEN (UNIT=19,FILE='flncep_pub_ff_tot.dat',STATUS='UNKNOWN')
        DO I=0,160
        DO J=0,160
          FLNPUP(I,J)=FLNCPN(I,J)+ERFLNP(I,J)
          FLNPDN(I,J)=FLNCPN(I,J)-ERFLNP(I,J)
          WRITE(19,53) FLNCPN(I,J),FLNPUP(I,J),FLNPDN(I,J)
        ENDDO
       ENDDO
       CLOSE (UNIT=19)   




        OPEN (UNIT=19,FILE='upval_pub_ff_tot.dat',STATUS='UNKNOWN')
        DO I=0,160
        DO J=0,160
          UUPDUM(I,J)=UCENT(I,J)+ERRU(I,J)
          UDNDUM(I,J)=UCENT(I,J)-ERRU(I,J)
          WRITE(19,53) UCENT(I,J),UUPDUM(I,J),UDNDUM(I,J)
        ENDDO
       ENDDO
      CLOSE (UNIT=19)

        OPEN (UNIT=19,FILE='dnval_pub_ff_tot.dat',STATUS='UNKNOWN')
        DO I=0,160
        DO J=0,160
          DUPDUM(I,J)=DCENT(I,J)+ERRD(I,J)
          DDNDUM(I,J)=DCENT(I,J)-ERRD(I,J)
         WRITE(19,53) DCENT(I,J),DUPDUM(I,J),DDNDUM(I,J)
       ENDDO
       ENDDO
      CLOSE (UNIT=19)
        OPEN (UNIT=19,FILE='gluon_pub_ff_tot.dat',STATUS='UNKNOWN')
        DO I=0,160
        DO J=0,160
          GUPDUM(I,J)=GCENT(I,J)+ERRG(I,J)
          GDNDUM(I,J)=GCENT(I,J)-ERRG(I,J)
         WRITE(19,53) GCENT(I,J),GUPDUM(I,J),GDNDUM(I,J)
       ENDDO
       ENDDO
      CLOSE (UNIT=19)

        OPEN (UNIT=19,FILE='seaqk_pub_ff_tot.dat',STATUS='UNKNOWN')
       DO I=0,160
        DO J=0,160
          SUPDUM(I,J)=SCENT(I,J)+ERRS(I,J)
          SDNDUM(I,J)=SCENT(I,J)-ERRS(I,J)
        WRITE(19,53) SCENT(I,J),SUPDUM(I,J),SDNDUM(I,J)
        ENDDO
        ENDDO
         CLOSE(UNIT=19)

        OPEN (UNIT=19,FILE='ubar_pub_ff_tot.dat',STATUS='UNKNOWN')
       DO I=0,160
        DO J=0,160
          UBUPDUM(I,J)=UBCEN(I,J)+ERUB(I,J)
          UBDNDUM(I,J)=UBCEN(I,J)-ERUB(I,J)
        WRITE(19,53) UBCEN(I,J),UBUPDUM(I,J),UBDNDUM(I,J)
        ENDDO
        ENDDO
         CLOSE(UNIT=19)

        OPEN (UNIT=19,FILE='dbar_pub_ff_tot.dat',STATUS='UNKNOWN')
       DO I=0,160
        DO J=0,160
          DBUPDUM(I,J)=DBCEN(I,J)+ERDB(I,J)
          DBDNDUM(I,J)=DBCEN(I,J)-ERDB(I,J)
        WRITE(19,53) DBCEN(I,J),DBUPDUM(I,J),DBDNDUM(I,J)
        ENDDO
        ENDDO
         CLOSE(UNIT=19)

        OPEN (UNIT=19,FILE='sbar_pub_ff_tot.dat',STATUS='UNKNOWN')
       DO I=0,160
        DO J=0,160
          STUPDUM(I,J)=STCEN(I,J)+ERST(I,J)
          STDNDUM(I,J)=STCEN(I,J)-ERST(I,J)
        WRITE(19,53) STCEN(I,J),STUPDUM(I,J),STDNDUM(I,J)
        ENDDO
        ENDDO
         CLOSE(UNIT=19)

        OPEN (UNIT=19,FILE='cbar_pub_ff_tot.dat',STATUS='UNKNOWN')
       DO I=0,160
        DO J=0,160
          CHUPDUM(I,J)=CHCEN(I,J)+ERCH(I,J)
          CHDNDUM(I,J)=CHCEN(I,J)-ERCH(I,J)
        WRITE(19,53) CHCEN(I,J),CHUPDUM(I,J),CHDNDUM(I,J)
        ENDDO
        ENDDO
         CLOSE(UNIT=19)

        OPEN (UNIT=19,FILE='bbar_pub_ff_tot.dat',STATUS='UNKNOWN')
       DO I=0,160
        DO J=0,160
          BTUPDUM(I,J)=BTCEN(I,J)+ERBT(I,J)
          BTDNDUM(I,J)=BTCEN(I,J)-ERBT(I,J)
        WRITE(19,53) BTCEN(I,J),BTUPDUM(I,J),BTDNDUM(I,J)
        ENDDO
        ENDDO
         CLOSE(UNIT=19)
        OPEN (UNIT=19,FILE='doveru_pub_ff_tot.dat',STATUS='UNKNOWN')
       DO I=0,160
        DO J=0,160
          DUUPDUM(I,J)=DUCEN(I,J)+ERDU(I,J)
          DUDNDUM(I,J)=DUCEN(I,J)-ERDU(I,J)
        WRITE(19,53) DUCEN(I,J),DUUPDUM(I,J),DUDNDUM(I,J)
        ENDDO
        ENDDO
         CLOSE(UNIT=19)
        OPEN (UNIT=19,FILE='emcc_pub_ff_tot.dat',STATUS='UNKNOWN')
        DO I=0,160
        DO J=0,160
          SIGUP(I,J)=SIGCEN(I,J)+ERCC(I,J)
          SIGDN(I,J)=SIGCEN(I,J)-ERCC(I,J)
          WRITE(19,53) SIGCEN(I,J),SIGUP(I,J),SIGDN(I,J)
        ENDDO
       ENDDO
      CLOSE (UNIT=19)

        OPEN (UNIT=19,FILE='emnc_pub_ff_tot.dat',STATUS='UNKNOWN')
        DO I=0,160
        DO J=0,160
          SIGNUP(I,J)=SIGNEN(I,J)+ERNC(I,J)
          SIGNDN(I,J)=SIGNEN(I,J)-ERNC(I,J)
          WRITE(19,53) SIGNEN(I,J),SIGNUP(I,J),SIGNDN(I,J)
        ENDDO
       ENDDO
      CLOSE (UNIT=19)

        OPEN (UNIT=19,FILE='epcc_pub_ff_tot.dat',STATUS='UNKNOWN')
        DO I=0,160
        DO J=0,160
          SIGPUP(I,J)=SIGPCEN(I,J)+ERPCC(I,J)
          SIGPDN(I,J)=SIGPCEN(I,J)-ERPCC(I,J)
          WRITE(19,53) SIGPCEN(I,J),SIGPUP(I,J),SIGPDN(I,J)
        ENDDO
       ENDDO
      CLOSE (UNIT=19)
        OPEN (UNIT=19,FILE='epnc_pub_ff_tot.dat',STATUS='UNKNOWN')
        DO I=0,160
        DO J=0,160
          SIGPNUP(I,J)=SIGPNEN(I,J)+ERPNC(I,J)
          SIGPNDN(I,J)=SIGPNEN(I,J)-ERPNC(I,J)
          WRITE(19,53) SIGPNEN(I,J),SIGPNUP(I,J),SIGPNDN(I,J)
        ENDDO
       ENDDO
      CLOSE (UNIT=19)

 998  CONTINUE
 53   FORMAT(3(E12.4,1X))
      STOP
999   END


c------------------------------------------------------------------------------
      SUBROUTINE INITIAL
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)


      COMMON/GAUS96/XI(96),WI(96),XX(97),NTERMS
      COMMON/INPUT/alambda,flavor,qsct,qsdt,iord,mode
      COMMON/GRID/IQ0,IQC,IQB,NXGRI,NQGRI
      COMMON/QNOUGHT/Q0,ZM2,AMSR,chmq,chmq2,chmq24
      COMMON/CONTROL/READIN,HEAVY,NACT,IVFN
      COMMON/PARVAL/STVAL(45),PASVAL(45)

      LOGICAL READIN,HEAVY,VFN

      INTEGER NACT,IVFN,IORD
      INTEGER IQ0,IQC,IQB,NXGRI,NQGRI
      PARAMETER (NSTARTP=7)
      DIMENSION QSP(NSTARTP)
      DATA QSP/10.,20.,30.,40.,50.,80.,100./

      DIMENSION PWGT(20)
C--   Initialisation
c-- stuff for dick roberts routines
      call wate96
      iord=1
      flavor=3
      qsdt=7.29
      qsct=74.
      mode=2
        alambda=15.4*STVAL(17)-1.5095
        if(alambda.le.0.01)alambda=0.01


c--qcdnum initialisation
      CALL QNINIT
c--se thresholds
       Q0=7.0
      ZM=91.187D0
      ZM2=ZM*ZM
       ALPHAS=QNALFA(ZM2)
    
      Q2C=1.8225
      Q2B=18.49

       IF (Q0.LT.Q2C) THEN
        NACT=3
      ELSE
        NACT=4
      ENDIF
c--this merely defines nact where we startevolution
c--namely at q0
      IF (HEAVY) NACT=3
      CALL QNRSET('MCSTF',SQRT(Q2C))
      CALL QNRSET('MBSTF',SQRT(Q2B))
      CALL QNRSET('MCALF',SQRT(Q2C))
      CALL QNRSET('MBALF',SQRT(Q2B))
      IF (HEAVY) THEN
        CALL QTHRES(1D6,2D6)
      ELSE

        CALL QTHRES(Q2C,Q2B)
      ENDIF

C--   x - Q2 grid

      DO I=1,NSTARTP
        CALL GRQINP(QSP(I),1)
      ENDDO
      CALL GRQINP(Q0,1)
      CALL GRQINP(Q2C,1)
      CALL GRQINP(Q2B,1)
c      qcdnum grid not my grid

      CALL GRXLIM(120,97D-8)

      CALL GRQLIM(61,29D-2,200D3) 



C--   Get final grid definitions and grid indices of Q0, Q2C and Q2B

      CALL GRGIVE(NXGRI,XMI,XMA,NQGRI,QMI,QMA)
      WRITE(*,*)'NX,XL,XH,NQ,QL,QH',NXGRI,XMI,XMA,NQGRI,QMI,QMA
      IQ0 = IQFROMQ(Q0)
      IQC = IQFROMQ(Q2C)
      IQB = IQFROMQ(Q2B)
  
C--   Allow for heavy weights

      IF (HEAVY) THEN
        CALL QNLSET('WTF2C',.TRUE.)
        CALL QNLSET('WTF2B',.TRUE.)
        CALL QNLSET('CLOWQ',.FALSE.)
        CALL QNLSET('WTFLC',.TRUE.)
        CALL QNLSET('WTFLB',.TRUE.)
      ENDIF
 
C--   Compute weights and dump, or read in

      IF (READIN) THEN 
        OPEN(UNIT=24,FILE='weights.dat',FORM='UNFORMATTED',
     .                                  STATUS='UNKNOWN')
        CALL QNREAD(24,ISTOP,IERR)
      ELSE
        CALL QNFILW(0,0)
        IF (HEAVY) THEN
          OPEN(UNIT=24,FILE='weights.dat',FORM='UNFORMATTED',
     .                                    STATUS='UNKNOWN')
          CALL QNDUMP(24)
        ENDIF
      ENDIF

C--   Apply cuts to grid
c--taking away the s cut at 600d0
      CALL GRCUTS(-1D0,-1D0,-1D0,-1D0)

C--   Choose renormalisation and factorisation scales

      CALL QNRSET('AAAR2',1D0)  ! renormalisation
      CALL QNRSET('BBBR2',0D0)
      CALL QNRSET('AAM2L',1D0)  ! factorisation (light)
      CALL QNRSET('BBM2L',0D0)
      CALL QNRSET('AAM2H',1D0)  ! factorisation (heavy)
      CALL QNRSET('BBM2H',0D0)

       ZM=91.187D0
        AS=STVAL(17)
      CALL QNRSET('ALFQ0',ZM*ZM)
      CALL QNRSET('ALFAS',AS)

      ZM2=ZM*ZM
      ALPHAS=QNALFA(ZM2)
      WRITE(*,*)'ALPHAS AT Mz2',ALPHAS

C--   Book non-singlet distributions

      CALL QNBOOK(2,'UPLUS')
      CALL QNBOOK(3,'DPLUS')
      CALL QNBOOK(4,'SPLUS')
      CALL QNBOOK(5,'CPLUS')
      CALL QNBOOK(6,'BPLUS')
      CALL QNBOOK(7,'UPVAL')
      CALL QNBOOK(8,'DNVAL')

C--   Book linear combinations for proton for f = 3,4,5 flavours


C--FIRST THE WORLD SF DATA STUFF
        CALL VZERO(PWGT,20) 
        PWGT(7)=1.
        PWGT(8)=1.
        CALL QNLINC(26,'VALENCE',3,PWGT)
        CALL QNLINC(26,'VALENCE',4,PWGT)
        CALL QNLINC(26,'VALENCE',5,PWGT)
        CALL VZERO(PWGT,20)
        PWGT(1) = 4./18.
        PWGT(2) = 4./9.
        PWGT(3) = 1./9.
        PWGT(4) = 1./9.
        CALL QNLINC(27,'PROTON',3,PWGT)
        PWGT(1) = 5./18.
        PWGT(5) = 4./9.
        CALL QNLINC(27,'PROTON',4,PWGT)
        PWGT(1) = 11./45.
        PWGT(6) = 1./9.
        CALL QNLINC(27,'PROTON',5,PWGT)
        PWGT(1) = 4./18.
        PWGT(2) = 1./9.
        PWGT(3) = 4./9.
        PWGT(4) = 1./9.
        CALL QNLINC(28,'NEUT',3,PWGT)
        PWGT(1) = 5./18.
        PWGT(5) = 4./9.
        CALL QNLINC(28,'NEUT',4,PWGT)
        PWGT(1) = 11./45.
        PWGT(6) = 1./9.
        CALL QNLINC(28,'NEUT',5,PWGT)
        CALL VZERO(PWGT,20)
        PWGT(1) = 4./18.
        PWGT(2) = 5./18.
        PWGT(3) = 5./18.
        PWGT(4) = 1./9.
        CALL QNLINC(29,'DEUTE',3,PWGT)
        PWGT(1) = 5./18.
        PWGT(5) = 4./9.
        CALL QNLINC(29,'DEUTE',4,PWGT)
        PWGT(1) = 11./45.
        PWGT(6) = 1./9.
        CALL QNLINC(29,'DEUTE',5,PWGT)
        CALL VZERO(PWGT,20)        
        PWGT(1) = 1.   
        PWGT(2) = 0.
        PWGT(3) = 0.
        PWGT(4) = 0.
        PWGT(5) = 0.
        PWGT(6) = 0.
        PWGT(7) = -1.
        PWGT(8) = -1.
        CALL QNLINC(16,'SEAQK',3,PWGT)
        CALL QNLINC(16,'SEAQK',4,PWGT)
        CALL QNLINC(16,'SEAQK',5,PWGT)
      
C--THEN THE XSECN STUFF

C--THESE COMBINATIONS ARE FOR UNPOLARISED LEPTON BEAM..
C--BUT ARE EASILY GENERALISED e.g. for e+ (1+P)* these combs
c--for e- (1-P)* these combs , where P=1 for rh P=-1 for lh
c--first cc combinations
        CALL VZERO(PWGT,20) 
        PWGT(1)=0.5
        PWGT(7)=-0.5
        PWGT(8)=0.5
        CALL QNLINC(12,'CCEP2',3,PWGT)
        CALL QNLINC(12,'CCEP2',4,PWGT)
        call qnlinc(12,'CCEP2',5,PWGT)
        PWGT(7) = 0.5
        PWGT(8) = -0.5
        CALL QNLINC(13,'CCEM2',3,PWGT)
        CALL QNLINC(13,'CCEM2',4,PWGT)
        CALL QNLINC(13,'CCEM2',5,PWGT)

        CALL VZERO(PWGT,20)        
c---these need cabibbo suppression factors correctly worked out with
c--sigma..actually  for ccep3  we are always above 
c threcshold
        cos2thc=0.95
        sin2thc=0.05
        PWGT(2) = -0.5
        PWGT(3) = 0.5*cos2thc
        PWGT(4) = 0.5*sin2thc
        PWGT(1) = 0.
        PWGT(7) = +0.5
        PWGT(8) = +0.5*cos2thc
        CALL QNLINC(14,'CCEP3',3,PWGT)
        PWGT(2) = -0.5
        PWGT(3) = 0.5
        PWGT(4) = 0.5
        PWGT(1) =  0.0
        PWGT(5) = -0.5
        PWGT(7) = +0.5
        PWGT(8) = +0.5
        CALL QNLINC(14,'CCEP3',4,PWGT)   
c        PWGT(6) = 0.5
c        PWGT(1) = 0.5/5.
c--leave 5 flavour the same as 4 flavour since b to t is cabibbo supressed
c--rather strikingly
        CALL QNLINC(14,'CCEP3',5,PWGT) 
        IF(HEAVY)THEN
C--FOR HEAVY MAKE IT 4 FLAVOUR EVEN WHEN NACT=3, SO THAT ITS AT LEAST
C--GOT THE CABIBBO UNSUPRESSIONS..OTHERWISe ITS JUST NOT RIGHT
        PWGT(2) = -0.5
        PWGT(3) = 0.5
        PWGT(4) = 0.5
        PWGT(1) =  0.0
        PWGT(5) = -0.5
        PWGT(7) = +0.5
        PWGT(8) = +0.5
        CALL QNLINC(14,'CCEP3',3,PWGT)
        ENDIF
        CALL VZERO(PWGT,20)
        cos2thc=0.95
        sin2thc=0.05
        PWGT(2) = 0.5
        PWGT(3) = -0.5*cos2thc
        PWGT(4) = -0.5*sin2thc
        PWGT(1) = 0.
        PWGT(7) = +0.5
        PWGT(8) = 0.5*cos2thc
        CALL QNLINC(15,'CCEM3',3,PWGT)        
        PWGT(2) = 0.5
        PWGT(3) = -0.5
        PWGT(4) = -0.5
        PWGT(1) = 0.0
        PWGT(7) = +0.5
        PWGT(8) = +0.5
        PWGT(1) = 0.0
        PWGT(5) = 0.5
        CALL QNLINC(15,'CCEM3',4,PWGT)
C        PWGT(6) = -0.5
C        PWGT(1) = -0.5/NACT
C--LEAVE 5 AS FOR 4 BECAUSE BBAR TO TBAR IS CABIBBO SUPRESSED
        CALL QNLINC(15,'CCEM3',5,PWGT)
        IF(HEAVY)THEN
C--FOR HEAVY MAKE IT 4 FLAVOUR EVEN WHEN NACT=3, SO THAT ITS AT LEAST
C--GOT THE CABIBBO UNSUPRESSIONS..OTHERWISe ITS JUST NOT RIGHT
        PWGT(2) = 0.5
        PWGT(3) = -0.5
        PWGT(4) = -0.5
        PWGT(1) =  0.0
        PWGT(5) = 0.5
        PWGT(7) = +0.5
        PWGT(8) = +0.5
        CALL QNLINC(15,'CCEM3',3,PWGT)
        ENDIF
c--define some quark pdfs
         CALL VZERO(PWGT,20)        
        PWGT(2) = 0.5

        PWGT(7) = -0.5

        PWGT(1) = 0.5/3.
        CALL QNLINC(17,'UB',3,PWGT)
        PWGT(1) = 0.5/4.
        CALL QNLINC(17,'UB',4,PWGT)
        PWGT(1) = 0.5/5.
        CALL QNLINC(17,'UB',5,PWGT) 
        CALL VZERO(PWGT,20) 

        PWGT(4) = 0.5
        PWGT(1) = 0.5/3.
        CALL QNLINC(18,'SB',3,PWGT)
        PWGT(1) = 0.5/4.
        CALL QNLINC(18,'SB',4,PWGT)
        PWGT(1) = 0.5/5.
        CALL QNLINC(18,'SB',5,PWGT)
         CALL VZERO(PWGT,20)        
        CALL QNLINC(19,'CB',3,PWGT)
        PWGT(5) = 0.5
        PWGT(1) = 0.5/4.

        CALL QNLINC(19,'CB',4,PWGT)
        PWGT(1) = 0.5/5.
        CALL QNLINC(19,'CB',5,PWGT) 
        CALL VZERO(PWGT,20) 
        PWGT(3) = 0.5

        PWGT(8) = -0.5

        PWGT(1) = 0.5/3.
        CALL QNLINC(20,'DB',3,PWGT)
        PWGT(1) = 0.5/4.
        CALL QNLINC(20,'DB',4,PWGT)
        PWGT(1) = 0.5/5.
        CALL QNLINC(20,'DB',5,PWGT)
         CALL VZERO(PWGT,20)        
        CALL QNLINC(21,'BB',3,PWGT)
       CALL QNLINC(21,'BB',4,PWGT)  
        PWGT(6) = 0.5


  
        PWGT(1) = 0.5/5.
        CALL QNLINC(21,'BB',5,PWGT) 
c---
            CALL QNRGET('MCSTF',chmq)
      chmq2=chmq*chmq
      chmq24=4.*chmq2
      RETURN
      END

C-----------------------------------------------------------------------------
        SUBROUTINE Q2COMBS(Q2)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      COMMON/GAUS96/XI(96),WI(96),XX(97),NTERMS
      COMMON/INPUT/alambda,flavor,qsct,qsdt,iord,mode
      COMMON/GRID/IQ0,IQC,IQB,NXGRI,NQGRI
      COMMON/QNOUGHT/Q0,ZM2,AMSR,chmq,chmq2,chmq24
      COMMON/CONTROL/READIN,HEAVY,NACT,IVFN
      COMMON/PARVAL/STVAL(45),PASVAL(45)

      LOGICAL READIN,HEAVY,VFN

      INTEGER NACT,IVFN,IORD
      INTEGER IQ0,IQC,IQB,NXGRI,NQGRI
      DIMENSION PWGT(20)
C--NOW NEED TO KNOW Q2 THAT WE ARE INTERESTED IN

      DATA ZM/91.187/
      DATA THETAW/0.2315/
c--code for ncem xsecn
c--general stuff for ncem xsecn

        EL=-1.
        T3L=-0.5
        AL=T3L
        VL=T3L-2.*EL*THETAW
        EU=2./3.
        T3U=+0.5
        AU=T3U
        VU=T3U-2.*EU*THETAW
        ED=-1./3.
        T3D=-0.5
        AD=T3D
        VD=T3D-2.*ED*THETAW
        PROP=Q2/(Q2+ZM*ZM)
        PZ=PROP/(4.*THETAW*(1.-THETAW))

        ALU=EU*EU+PZ*2.*EL*EU*VU*(VL+AL)+
     .                PZ*PZ*(VL+AL)**2.*(VU*VU+AU*AU)
        BLU=PZ*2.*EL*EU*AU*(VL+AL) +
     .                PZ*PZ*(VL+AL)**2.*2.*VU*AU
        ALD=ED*ED+PZ*2.*EL*ED*VD*(VL+AL)+
     .                PZ*PZ*(VL+AL)**2.*(VD*VD+AD*AD)
        BLD=PZ*2.*EL*ED*AD*(VL+AL) +
     .                PZ*PZ*(VL+AL)**2.*2.*VD*AD
        ARU=EU*EU+PZ*2.*EL*EU*VU*(VL-AL)+

     .                PZ*PZ*(VL-AL)**2.*(VU*VU+AU*AU)
        BRU=-PZ*2.*EL*EU*AU*(VL-AL) -
     .                PZ*PZ*(VL-AL)**2.*2.*VU*AU
        ARD=ED*ED+PZ*2.*EL*ED*VD*(VL-AL)+
     .                PZ*PZ*(VL-AL)**2.*(VD*VD+AD*AD)
        BRD=-PZ*2.*EL*ED*AD*(VL-AL) -
     .                PZ*PZ*(VL-AL)**2.*2.*VD*AD
C--NOW DEFINE COMBINATIONS OF LEFT AND RIGHT FOR UNPOLARISED
C--AU+=(1-P)/2.*ALU +(1+P)/2.*ARU..SIMILARYLY FOR AD+,BU+BD+
        AUM=0.5*(ALU+ARU)
        ADM=0.5*(ALD+ARD)
        BUM=0.5*(BLU+BRU)
        BDM=0.5*(BLD+BRD)

C--NOW WE CAN DEFINE THE RIGHT COMBINATIONS TO GET F2,XF3

        CALL VZERO(PWGT,20) 
        PWGT(1)=(AUM+2.*ADM)/3.
        PWGT(2)=AUM
        PWGT(3)=ADM
        PWGT(4)=ADM
       
        CALL QNLINC(23,'NCEM2',3,PWGT)
        PWGT(1)=2.*(AUM+ADM)/4.
        PWGT(5)=AUM
        CALL QNLINC(23,'NCEM2',4,PWGT)
        PWGT(6)=ADM
        PWGT(1)=(2.*AUM+3.*ADM)/5.
        CALL QNLINC(23,'NCEM2',5,PWGT)
        CALL VZERO(PWGT,20)        
        PWGT(7) = BUM
        PWGT(8) = BDM
        CALL QNLINC(25,'NCEM3',3,PWGT)
        CALL QNLINC(25,'NCEM3',4,PWGT)
        CALL QNLINC(25,'NCEM3',5,PWGT) 
c--code for nceP xsecn
c--general stuff for nce xsecn
        EL=1.
        T3L=+0.5
        AL=T3L
        VL=T3L-2.*EL*THETAW
        EU=2./3.
        T3U=+0.5
        AU=T3U
        VU=T3U-2.*EU*THETAW
        ED=-1./3.
        T3D=-0.5
        AD=T3D
        VD=T3D-2.*ED*THETAW
        ALU=EU*EU+PZ*2.*EL*EU*VU*(VL+AL)+
     .                PZ*PZ*(VL+AL)**2.*(VU*VU+AU*AU)
        BLU=PZ*2.*EL*EU*AU*(VL+AL) +
     .                PZ*PZ*(VL+AL)**2.*2.*VU*AU
        ALD=ED*ED+PZ*2.*EL*ED*VD*(VL+AL)+
     .                PZ*PZ*(VL+AL)**2.*(VD*VD+AD*AD)
        BLD=PZ*2.*EL*ED*AD*(VL+AL) +
     .                PZ*PZ*(VL+AL)**2.*2.*VD*AD
        ARU=EU*EU+PZ*2.*EL*EU*VU*(VL-AL)+
     .                PZ*PZ*(VL-AL)**2.*(VU*VU+AU*AU)
        BRU=-PZ*2.*EL*EU*AU*(VL-AL) -
     .                PZ*PZ*(VL-AL)**2.*2.*VU*AU
        ARD=ED*ED+PZ*2.*EL*ED*VD*(VL-AL)+
     .                PZ*PZ*(VL-AL)**2.*(VD*VD+AD*AD)
        BRD=-PZ*2.*EL*ED*AD*(VL-AL) -
     .                PZ*PZ*(VL-AL)**2.*2.*VD*AD
C--NOW DEFINE COMBINATIONS OF LEFT AND RIGHT FOR UNPOLARISED
C--AU+=(1+P)/2.*ALU +(1-P)/2.*ARU..SIMILARYLY FOR AD+,BU+BD+
        AUP=0.5*(ALU+ARU)
        ADP=0.5*(ALD+ARD)
        BUP=0.5*(BLU+BRU)
        BDP=0.5*(BLD+BRD)

C--NOW WE CAN DEFINE THE RIGHT COMBINATIONS TO GET F2,XF3
        CALL VZERO(PWGT,20) 

        PWGT(1)=(AUP+2.*ADP)/3.
        PWGT(2)=AUP
        PWGT(3)=ADP
        PWGT(4)=ADP
       
        CALL QNLINC(22,'NCEP2',3,PWGT)

        PWGT(1)=2.*(AUP+ADP)/4.
 
        PWGT(5)=AUP
        CALL QNLINC(22,'NCEP2',4,PWGT)
        PWGT(6)=ADP
        PWGT(1)=(2.*AUP+3.*ADP)/5. 
       CALL QNLINC(22,'NCEP2',5,PWGT)

        CALL VZERO(PWGT,20)        
        PWGT(7) = BUP
        PWGT(8) = BDP
        CALL QNLINC(24,'NCEP3',3,PWGT)
        CALL QNLINC(24,'NCEP3',4,PWGT)
        CALL QNLINC(24,'NCEP3',5,PWGT) 
                
c-- now these combinations are defined we can GET QUANTITIES OF INTEREST FOR EAC--CH X,Q2


         RETURN
         END


C     ==============
      SUBROUTINE RESULTS(Q2,X,F2CENT,FLCENT,F2CCEN,F2NPEN,FLNCPN,XF3PNEN
     +             ,UCENT,DCENT,GCENT,SCENT
     +             ,UBCEN,DBCEN,STCEN,CHCEN,BTCEN,DUCEN
     +             ,SIGNEN,SIGCEN,SIGPNEN,SIGPCEN)
C     ==============

      IMPLICIT DOUBLE PRECISION (A-H,O-Z)


      COMMON/GAUS96/XI(96),WI(96),XX(97),NTERMS
      COMMON/INPUT/alambda,flavor,qsct,qsdt,iord,mode
      COMMON/GRID/IQ0,IQC,IQB,NXGRI,NQGRI
      COMMON/QNOUGHT/Q0,ZM2,AMSR,chmq,chmq2,chmq24
      COMMON/CONTROL/READIN,HEAVY,NACT,IVFN
      COMMON/PARCOV/C(11),DUPP(11,11),DDOWN(11,11)
      COMMON/PARVAL/STVAL(45),PASVAL(45)


      COMMON/NORMS/UN,DN,GN,UBDBN 
      DIMENSION TMPVAL(45)
      LOGICAL READIN,HEAVY,VFN

      INTEGER NACT,NTRIES,IVFN,IORD

      DATA ZM/91.187/
      DATA THETAW/0.2315/

      REAL GLU,UVAL,DVAL,RAT
      DIMENSION PWGT(20)



               IF(IVFN.EQ.1)THEN
            F2CENT=QSTFXQ('F2','PROTON',X,Q2,IFLAG)+
     .             QSTFXQ('F2C','PROTON',X,Q2,IFLAG)+
     .             QSTFXQ('F2B','PROTON',X,Q2,IFLAG)         
            FLCENT=QSTFXQ('FL','PROTON',X,Q2,IFLAG)+
     .             QSTFXQ('FLC','PROTON',X,Q2,IFLAG)+
     .             QSTFXQ('FLB','PROTON',X,Q2,IFLAG)  
            F2CCEN=QSTFXQ('F2C','PROTON',X,Q2,IFLAG)               
               ELSEIF(IVFN.EQ.0)THEN
               F2CENT=QSTFXQ('F2','PROTON',X,Q2,IFLAG)
               FLCENT=QSTFXQ('FL','PROTON',X,Q2,IFLAG)
            F2CCEN=8./9.*QPDFXQ('CB',X,Q2,IFLAG)               
               ELSEIF(IVFN.EQ.2)THEN
       f2cbit=0
c--here call the jacksmithstuff-
c-- this is very time consuming even in the linking so is commented out
c--only put it in if doing thorne roberts coefficient functions AND
c--wanting specifically to look at f2charm
c        W2 = Q2*(1.-X)/X

c--this is not quite w2 but corresponds to the jacsmith check
c--on out of range
c--mass of charm quark 

c       if(w2.le.chmq24)go to 567
c       if(Q2.lt.1.25.or.x.lt.1d-5)go to 567
c       if(q2.le.chmq2)then
c       call js(X,Q2,chmq,fhad)
c       f2cbit=fhad
c       else
c       call js(X,chmq2,chmq,fhad)
c       f2cbit=fhad
c       endif
c 567    continue
c       write(*,*)'w2,x,q2,fhad,f2cbit',w2,x,q2,fhad,f2cbit
       if(x.ge.0.00000112.and.x.le.0.92)then
       call sfun(x,q2,mode,f2p,flp,f1p,rp,f2n,fln,f1n,rn,
     xf2c,flc,f1c,f2b,flb,f1b)
       else
       f2p=0.
       flp=0.
       f2c=0.
       endif
               F2CENT=F2P
               FLCENT=FLP
               F2CCEN=F2C +f2cbit
              ENDIF
               UCENT=QPDFXQ('UPVAL',X,Q2,IFAIL)
               DCENT=QPDFXQ('DNVAL',X,Q2,IFAIL)
               GCENT=QPDFXQ('GLUON',X,Q2,IFAIL)
               UBCEN=QPDFXQ('UB',X,Q2,IFAIL)
               DBCEN=QPDFXQ('DB',X,Q2,IFAIL)
               STCEN=QPDFXQ('SB',X,Q2,IFAIL)
               IF(Q2.GE.Q2C)THEN
               CHCEN=QPDFXQ('CB',X,Q2,IFAIL)
               ELSE
               CHCEN=0.0
               ENDIF
               IF(Q2.GE.Q2B)THEN
               BTCEN=QPDFXQ('BB',X,Q2,IFAIL)
               ELSE
               BTCEN=0.0
               ENDIF
               UR=UCENT+2.*UBCEN
               DR=DCENT+2.*DBCEN
               IF(UR.GT.0.0)THEN
               DUCEN=DR/UR
               ELSE
               DUCEN=0.0
               ENDIF           
               SCENT=2.*(UBCEN+DBCEN+STCEN+CHCEN+BTCEN)

c-- a new patch of code for cc red xsecn here
c--notE ccem and ccep code will NOT work for fixed flavour number
c--QCDNUM was NOT built for adding on the charmed quark contribution to CC
C--PROCESSES
            IF(HEAVY)THEN
            XF3=0.
            F2=0.
            FL=0.
            ELSE
            XF3=QSTFXQ('XF3','CCEM3',X,Q2,IFLAG)
            F2=QSTFXQ('F2','CCEM2',X,Q2,IFLAG)
            FL=QSTFXQ('FL','CCEM2',X,Q2,IFLAG)
            ENDIF
            XF3CEN=XF3
             FLCCMN=FL
             F2CMEN=F2
C---- and nc em red xsec is needed too

            XF3=QSTFXQ('XF3','NCEM3',X,Q2,IFLAG)
            XF3NEN=XF3 
          IF(IVFN.EQ.1)THEN  
          F2=QSTFXQ('F2','NCEM2',X,Q2,IFLAG)+
     .             QSTFXQ('F2C','PROTON',X,Q2,IFLAG)+
     .             QSTFXQ('F2B','PROTON',X,Q2,IFLAG)
          FL=QSTFXQ('FL','NCEM2',X,Q2,IFLAG)+
     .             QSTFXQ('FLC','PROTON',X,Q2,IFLAG)+
     .             QSTFXQ('FLB','PROTON',X,Q2,IFLAG)

          ELSEIF(IVFN.EQ.0)THEN
            F2=QSTFXQ('F2','NCEM2',X,Q2,IFLAG)
           FL=QSTFXQ('FL','NCEM2',X,Q2,IFLAG)
          ELSEIF(IVFN.EQ.2)THEN
            F2Z=QSTFXQ('F2','NCEM2',X,Q2,IFLAG)
            FLZ=QSTFXQ('FL','NCEM2',X,Q2,IFLAG)

            F2GAM=QSTFXQ('F2','PROTON',X,Q2,IFLAG)
            FLGAM=QSTFXQ('FL','PROTON',X,Q2,IFLAG)
       if(x.ge.0.00000112.and.x.le.0.92)then
       call sfun(x,q2,mode,f2p,flp,f1p,rp,f2n,fln,f1n,rn,
     xf2c,flc,f1c,f2b,flb,f1b)
       else
       f2p=0.
       flp=0.
       endif
            IF(F2GAM.GT.0.0.AND.FLGAM.GT.0.0)THEN
             F2=F2P*F2Z/F2GAM
             FL=FLP*FLZ/FLGAM          
            ELSE
             F2=0.
             FL=0.
            ENDIF

c--ivfn endif
          ENDIF
          F2NMEN=F2
          FLNCMN=FL

      SNOM=4.*920.*27.5
          Y=Q2/(SNOM*X)
c--put on kinematic limits for actually reduced cross-sections
          IF(Y.LT.1.0)THEN
          YP=1 + (1-Y)*(1-Y)
          YM=1 - (1-Y)*(1-Y)
           SIGCEN=(F2CMEN*YP - Y*Y*FLCCMN  + YM*XF3CEN)*0.5
           SIGNEN=(F2NMEN*YP - Y*Y*FLNCMN + YM*XF3NEN)/YP
          ELSE
          SIGCEN=0.
          SIGNEN=0.
C--Y KINEMATIC REION ENDIF
          ENDIF

c-- a new patch of code for cc eP red xsecn here
c--note ccem and ccep code will NOT work for fixed flavour number
c--QCDNUM was NOT built for adding on the charmed quark contribution to 
C  CC PROCESSES
            IF(HEAVY)THEN
            XF3=0.
            F2=0.
            FL=0.
            ELSE
            XF3=QSTFXQ('XF3','CCEP3',X,Q2,IFLAG)
            F2=QSTFXQ('F2','CCEP2',X,Q2,IFLAG)
            FL=QSTFXQ('FL','CCEP2',X,Q2,IFLAG)
            ENDIF
           XF3PCEN=XF3
            FLCCPN=FL
            F2CPEN=F2

C---- and nc eP red xsec is needed too
            XF3=QSTFXQ('XF3','NCEP3',X,Q2,IFLAG)
            XF3PNEN=XF3
          IF(IVFN.EQ.1)THEN  
          F2=QSTFXQ('F2','NCEP2',X,Q2,IFLAG)+
     .             QSTFXQ('F2C','PROTON',X,Q2,IFLAG)+
     .             QSTFXQ('F2B','PROTON',X,Q2,IFLAG)
          FL=QSTFXQ('FL','NCEP2',X,Q2,IFLAG)+
     .             QSTFXQ('FLC','PROTON',X,Q2,IFLAG)+
     .             QSTFXQ('FLB','PROTON',X,Q2,IFLAG)

          ELSEIF(IVFN.EQ.0)THEN
            F2=QSTFXQ('F2','NCEP2',X,Q2,IFLAG)
           FL=QSTFXQ('FL','NCEP2',X,Q2,IFLAG)
          ELSEIF(IVFN.EQ.2)THEN
            F2Z=QSTFXQ('F2','NCEP2',X,Q2,IFLAG)
            FLZ=QSTFXQ('FL','NCEP2',X,Q2,IFLAG)

            F2GAM=QSTFXQ('F2','PROTON',X,Q2,IFLAG)
            FLGAM=QSTFXQ('FL','PROTON',X,Q2,IFLAG)

       if(x.ge.0.00000112.and.x.le.0.92)then
       call sfun(x,q2,mode,f2p,flp,f1p,rp,f2n,fln,f1n,rn,
     xf2c,flc,f1c,f2b,flb,f1b)
       else
       f2p=0.
       flp=0.
       endif
            IF(F2GAM.GT.0.0.AND.FLGAM.GT.0.0)THEN
             F2=F2P*F2Z/F2GAM
             FL=FLP*FLZ/FLGAM          
            ELSE
             F2=0.
             FL=0.
            ENDIF

c--ivfn endif
          ENDIF

          F2NPEN=F2
          FLNCPN=FL
c--y kin limit
C      SNOM=4.*820.*27.5
      SNOM=4.*920.*27.5
          Y=Q2/(SNOM*X)
          IF(Y.LT.1.0)THEN
          YP=1 + (1-Y)*(1-Y)
          YM=1 - (1-Y)*(1-Y)
           SIGPCEN=(F2CPEN*YP - Y*Y*FLCCPN - YM*XF3PCEN)*0.5
           SIGPNEN=(F2NPEN*YP - Y*Y*FLNCPN - YM*XF3PNEN)/YP

          ELSE
          SIGPCEN=0.
          SIGPNEN=0.
          ALEXCEN=0.
C--Y KINEMATIC REION ENDIF
          ENDIF

      return
      end


C------------------------------------------------------------------------
      SUBROUTINE EVOLVE(XVAL)
C------------------------------------------------------------------------

      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      
      DIMENSION XVAL(45)      
      COMMON/GRID/IQ0,IQC,IQB,NXGRI,NQGRI
      COMMON/QNOUGHT/Q0,ZM2,AMSR,chmq,chmq2,chmq24
      COMMON/CONTROL/READIN,HEAVY,NACT,IVFN
      COMMON/NORMS/UN,DN,GN,UBDBN
      LOGICAL READIN,HEAVY
      INTEGER NACT,IVFN

      ALPHAS=QNALFA(ZM2)
      UA=XVAL(1)
      UB=XVAL(2)
      UE=XVAL(3)
      UC=XVAL(4)
      DA=XVAL(5)

      DB=XVAL(6)
      DE=XVAL(7)

      DC=XVAL(8)
      SN=XVAL(9)
      SA=XVAL(10)
      SB=XVAL(11)
      SE=0.
      SC=XVAL(12)
      GA=XVAL(13)
      GB=XVAL(14)
      GE=0.
      GC=XVAL(15)
      DLN=XVAL(16)
      DLA=0.5
      DLB=XVAL(11)+2.
      DLE=0.
      DLC=0.
      AS=XVAL(17)
       CALL QNRSET('ALFAS',AS)
C--   Input quark distributions at Q2 = Q02 GeV2
       UN=2./AREA(UA-1,UB,UE,UC)
       DN=1./AREA(DA-1,DB,DE,DC)

c       UBDBN=DLN/AREA(DLA-1,DLB,DLE,DLC)

      DO IX = 1,NXGRI
        X = XFROMIX(IX)
        UPVAL=UN*FF(X,UA,UB,UE,UC)

        DNVAL=DN*FF(X,DA,DB,DE,DC)


        SEA=SN*FF(X,SA,SB,SE,SC)

        GN=(1-UN*AREA(UA,UB,UE,UC)-
     .        DN*AREA(DA,DB,DE,DC)-XVAL(15)*(PART3+PART4)-
     .        SN*AREA(SA,SB,SE,SC))/AREA(GA,GB,GE,GC)
        GLUON=GN*FF(X,GA,GB,GE,GC)



c        UMD=UBDBN*FF(X,DLA,DLB,DLE,DLC)
        UMD=DLN*FF(X,DLA,DLB,DLE,DLC)
        SINGL=UPVAL+DNVAL+SEA        


        CSEA=0.0
        SSEA=0.2*SEA
        USEA=(SEA-SSEA-CSEA)/2.-UMD
        DSEA=(SEA-SSEA-CSEA)/2.+UMD        
        UPLUS=UPVAL+USEA-1./NACT*SINGL
        DPLUS=DNVAL+DSEA-1./NACT*SINGL
        SPLUS=SSEA-1./NACT*SINGL


        CALL QNPSET('GLUON',IX,IQ0,GLUON)
        CALL QNPSET('SINGL',IX,IQ0,SINGL)
        CALL QNPSET('UPLUS',IX,IQ0,UPLUS)
        CALL QNPSET('DPLUS',IX,IQ0,DPLUS)
        CALL QNPSET('SPLUS',IX,IQ0,SPLUS)
        CALL QNPSET('UPVAL',IX,IQ0,UPVAL)
        CALL QNPSET('DNVAL',IX,IQ0,DNVAL)
      ENDDO
C--THINGS ARE FINE FOR HEAVY SO DO IT
      IF (HEAVY) THEN

C--     Evolve over whole grid

        CALL EVOLSG(IQ0,1,NQGRI)
        CALL EVPLUS('UPLUS',IQ0,1,NQGRI)
        CALL EVPLUS('DPLUS',IQ0,1,NQGRI)
        CALL EVPLUS('SPLUS',IQ0,1,NQGRI)
        CALL EVOLNM('UPVAL',IQ0,1,NQGRI)
        CALL EVOLNM('DNVAL',IQ0,1,NQGRI)

      ELSE

C--     Evolve gluon, singlet and valence over whole grid
      
        CALL EVOLSG(IQ0,1,NQGRI)
        CALL EVOLNM('UPVAL',IQ0,1,NQGRI)
        CALL EVOLNM('DNVAL',IQ0,1,NQGRI)
        
C--     Be more careful with plus distributions

        IF (NACT.EQ.3) THEN
C--THINGS ARE ALSO FINE IF 1Q0 IS BELOW 1QC THEN CLEARLY CSEA=0. IS OK
C--SITUATION CD BE 1<Q0<Q2C<Q2B ETC
C--GO DOWN QO TO 1 UP Q0 TO  Q2C
          CALL EVPLUS('UPLUS',IQ0,1,IQC)
          CALL EVPLUS('DPLUS',IQ0,1,IQC)
          CALL EVPLUS('SPLUS',IQ0,1,IQC)
C--DEAL WITH CHARM THRESH
          FACTOR=1./3.-1./4.
          CALL QADDSI('UPLUS',IQC,FACTOR)
          CALL QADDSI('DPLUS',IQC,FACTOR)
          CALL QADDSI('SPLUS',IQC,FACTOR)
          CALL QNPNUL('CPLUS')
          FACTOR=-1/4.
          CALL QADDSI('CPLUS',IQC,FACTOR)
C--GO UP Q2C TO Q2B
          CALL EVPLUS('UPLUS',IQC,IQC,IQB)
          CALL EVPLUS('DPLUS',IQC,IQC,IQB)
          CALL EVPLUS('SPLUS',IQC,IQC,IQB)
          CALL EVPLUS('CPLUS',IQC,IQC,IQB)

        ELSEIF(NACT.EQ.4)THEN
C--1<1QC<1Q0<1QB<ETC
C--NOW WE NEED A RETHINK OF THE INITIAL CONDITIONS
C--FIRST DEAL WITH CPLUS TRUNING ON AT IQC
C--AND GOING UP TO IQB (MIDDLE AGAIN)
          CALL QNPNUL('CPLUS')
          FACTOR=-1/4.
          CALL QADDSI('CPLUS',IQC,FACTOR)
          CALL EVPLUS('CPLUS',IQC,IQC,IQB)
C--REDIFINE THE PLUS DUSTNS TAKING INTO ACCOUNT CPLUS
          CALL QNPNUL('SPLUS')
          CALL QNPNUL('UPLUS')
          CALL QNPNUL('DPLUS')
C--NOW YOU NEED A DO LOOP AGAIN
          DO IX = 1,NXGRI
          X = XFROMIX(IX)
          UPVAL=UN*FF(X,UA,UB,UE,UC)

          DNVAL=DN*FF(X,DA,DB,DE,DC)
          SEA=SN*FF(X,SA,SB,SE,SC)
          SINGL=UPVAL+DNVAL+SEA
          UMD=DLN*FF(X,DLA,DLB,DLE,DLC)
          SSEA=0.2*SEA
          CSEA=QPDFIJ('CPLUS',IX,IQ0,IFL) + 1./NACT*SINGL
          USEA=(SEA-SSEA-CSEA)/2.-UMD
          DSEA=(SEA-SSEA-CSEA)/2.+UMD        
          UPLUS=UPVAL+USEA-1./NACT*SINGL
          DPLUS=DNVAL+DSEA-1./NACT*SINGL
          SPLUS=SSEA-1./NACT*SINGL
          CALL QNPSET('UPLUS',IX,IQ0,UPLUS)
          CALL QNPSET('DPLUS',IX,IQ0,DPLUS)
          CALL QNPSET('SPLUS',IX,IQ0,SPLUS)
          ENDDO
C-NOW DO MIDDLE FOR UPLUS,DPLUS,SPLUS
          CALL EVPLUS('UPLUS',IQ0,IQC,IQB)
          CALL EVPLUS('DPLUS',IQ0,IQC,IQB)
          CALL EVPLUS('SPLUS',IQ0,IQC,IQB)
C--THEN GO DOWN IQC TO 1
             IF(IQC.GT.1)THEN
             FACTOR=1./4.-1./3.
             CALL QADDSI('UPLUS',IQC,FACTOR)
             CALL QADDSI('DPLUS',IQC,FACTOR)
             CALL QADDSI('SPLUS',IQC,FACTOR)
             CALL EVPLUS('UPLUS',IQC,1,IQC)
             CALL EVPLUS('DPLUS',IQC,1,IQC)
             CALL EVPLUS('SPLUS',IQC,1,IQC)
             ENDIF

        ENDIF
C--THEN DEAL WITH B THRESHOLD FOR ALL4
        FACTOR=1./4.-1./5.
        CALL QADDSI('UPLUS',IQB,FACTOR)
        CALL QADDSI('DPLUS',IQB,FACTOR)
        CALL QADDSI('SPLUS',IQB,FACTOR)
        CALL QADDSI('CPLUS',IQB,FACTOR)
C--THEN GO UP
        IF(IQB.LT.NQGRI)THEN 
       CALL EVPLUS('UPLUS',IQB,IQB,NQGRI)
        CALL EVPLUS('DPLUS',IQB,IQB,NQGRI)
        CALL EVPLUS('SPLUS',IQB,IQB,NQGRI)
        CALL EVPLUS('CPLUS',IQB,IQB,NQGRI)
        ENDIF
cC--THEN DEAL WITH B TURNING ON AT IQB AND GO UP
        CALL QNPNUL('BPLUS')
        FACTOR=-1./5.
       CALL QADDSI('BPLUS',IQB,FACTOR)
        CALL EVPLUS('BPLUS',IQB,IQB,NQGRI)
      ENDIF  

      RETURN

      END

C------------------------------------------------------------------------ 
      DOUBLE PRECISION FUNCTION AREA(A,B,E,C)
C------------------------------------------------------------------------ 

      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
 
      IF (A.LE.-0.99.OR.B.LE.-0.99) THEN
        AREA=1D6
        RETURN
      ENDIF

      AR1=(DGAMMA(A+1)*DGAMMA(B+1))/DGAMMA(A+B+2)
      AR2=E*(DGAMMA(A+1.5)*DGAMMA(B+1))/DGAMMA(A+B+2.5)
      AR3=C*(DGAMMA(A+2)*DGAMMA(B+1))/DGAMMA(A+B+3)
      AREA=AR1+AR2+AR3
     
      IF (AREA.LE.1D-6) AREA=1D-6

      RETURN
      END

C------------------------------------------------------------------------ 
      DOUBLE PRECISION FUNCTION FF(X,A,B,E,C)
C------------------------------------------------------------------------ 

      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
 
      FF=X**A*(1D0-X)**B*(1+E*SQRT(X)+C*X)
     
      RETURN
      END










