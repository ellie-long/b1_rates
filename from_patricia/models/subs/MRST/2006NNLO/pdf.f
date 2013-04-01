C----------------------------------------------------------------------
C--   Fortran interpolation code for MRST 2006 NNLO PDFs, building
C--   on existing MRST Fortran code and J.Andersen's C++ code.
C--   Three user interfaces:
C--    call GetAllPDFs(prefix,i,x,q,
C--                    upv,dnv,usea,dsea,str,sbar,chm,bot,glu)
C--    call GetAllPDFsAlt(prefix,i,x,q,xpdf)
C--    xf = GetOnePDF(prefix,i,x,q,f)
C--   See enclosed example.f for usage.
C--   Comments to watt(at)hep.ucl.ac.uk
C----------------------------------------------------------------------

C----------------------------------------------------------------------

C--   Traditional MRST-like interface: return all flavours.
C--   (Note the additional "sbar" compared to previous MRST releases.)
      subroutine GetAllPDFs(prefix,i,x,q,
     &     upv,dnv,usea,dsea,str,sbar,chm,bot,glu)
      implicit none
      integer i
      double precision x,q,upv,dnv,usea,dsea,str,sbar,chm,bot,glu,
     &     GetOnePDF
      character*(*) prefix

      upv  = GetOnePDF(prefix,i,x,q,1)
      dnv  = GetOnePDF(prefix,i,x,q,2)
      usea = GetOnePDF(prefix,i,x,q,4)
      dsea = GetOnePDF(prefix,i,x,q,8)
      str  = GetOnePDF(prefix,i,x,q,6)
      sbar = GetOnePDF(prefix,i,x,q,9)
      chm  = GetOnePDF(prefix,i,x,q,5)
      bot  = GetOnePDF(prefix,i,x,q,7)
      glu  = GetOnePDF(prefix,i,x,q,3)

      return
      end

C----------------------------------------------------------------------

C--   Alternative LHAPDF-like interface: return PDFs in an array.
      subroutine GetAllPDFsAlt(prefix,i,x,q,xpdf)
      implicit none
      integer i
      double precision x,q,xpdf(-6:6),
     &     upv,dnv,usea,dsea,str,sbar,chm,bot,glu
      character*(*) prefix

      call GetAllPDFs(prefix,i,x,q,
     &     upv,dnv,usea,dsea,str,sbar,chm,bot,glu)
      xpdf(-6) = 0.d0           ! tbar
      xpdf(-5) = bot            ! bbar
      xpdf(-4) = chm            ! cbar
      xpdf(-3) = sbar           ! sbar
      xpdf(-2) = usea           ! ubar
      xpdf(-1) = dsea           ! dbar
      xpdf(0) = glu             ! g
      xpdf(1) = dnv+dsea        ! d
      xpdf(2) = upv+usea        ! u
      xpdf(3) = str             ! s
      xpdf(4) = chm             ! c
      xpdf(5) = bot             ! b
      xpdf(6) = 0.d0            ! t
      
      return
      end

C----------------------------------------------------------------------

C--   New interface: get only one parton flavour 'f'.
C--   Notation:1=upv 2=dnv 3=glu 4=usea 5=chm 6=str 7=bot 8=dsea 9=sbar
      double precision function GetOnePDF(prefix,i,x,q,f)
      implicit none
      logical warn,fatal
      parameter(warn=.true.,fatal=.true.)
C--   Set warn=.false. to turn off warnings when extrapolating.
C--   Set fatal=.false. to return zero instead of terminating when
C--   invalid input values of x and q are used.
      integer i,f,nhess,nx,nq,np,nqc0,nqb0,nqc,nqb,n,m,io
      double precision x,q,xmin,xmax,qsqmin,qsqmax,emc2,emb2,eps,
     &     dummy,qsq,xlog,qsqlog,res,ExtrapolatePDF,InterpolatePDF
      parameter(nx=64,nq=48,np=9,nqc0=4,nqb0=14,nqc=nq-nqc0,nqb=nq-nqb0)
      parameter(xmin=1d-6,xmax=1d0,qsqmin=1d0,qsqmax=1d9,eps=1d-6)
      parameter(nhess=30,emc2=1.43d0**2,emb2=4.3d0**2) ! MRST 2006 NNLO
      character set*2,prefix*(*),filename*60,oldprefix(0:nhess)*50
      double precision f1(nx,nq),f2(nx,nq),f3(nx,nq),f4(nx,nq),
     &     f5(nx,nq),f6(nx,nq),f7(nx,nq),f8(nx,nq),fc(nx,nqc),
     &     fb(nx,nqb),f9(nx,nq)
      double precision qq(nq),xx(nx),cc1(0:nhess,nx,nq,4,4),
     &     cc2(0:nhess,nx,nq,4,4),cc3(0:nhess,nx,nq,4,4),
     &     cc4(0:nhess,nx,nq,4,4),cc6(0:nhess,nx,nq,4,4),
     &     cc8(0:nhess,nx,nq,4,4),cc9(0:nhess,nx,nq,4,4),
     &     ccc(0:nhess,nx,nqc,4,4),ccb(0:nhess,nx,nqb,4,4)
      double precision xxl(nx),qql(nq),qqlc(nqc),qqlb(nqb)
      data xx/1d-6,2d-6,4d-6,6d-6,8d-6,
     &     1d-5,2d-5,4d-5,6d-5,8d-5,
     &     1d-4,2d-4,4d-4,6d-4,8d-4,
     &     1d-3,2d-3,4d-3,6d-3,8d-3,
     &     1d-2,1.4d-2,2d-2,3d-2,4d-2,6d-2,8d-2,
     &	   .1d0,.125d0,.15d0,.175d0,.2d0,.225d0,.25d0,.275d0,
     &	   .3d0,.325d0,.35d0,.375d0,.4d0,.425d0,.45d0,.475d0,
     &	   .5d0,.525d0,.55d0,.575d0,.6d0,.625d0,.65d0,.675d0,
     &     .7d0,.725d0,.75d0,.775d0,.8d0,.825d0,.85d0,.875d0,
     &     .9d0,.925d0,.95d0,.975d0,1d0/
      data qq/1.d0,
     &     1.25d0,1.5d0,emc2-eps,emc2,2.5d0,3.2d0,4d0,5d0,6.4d0,8d0,
     &     1d1,1.2d1,emb2-eps,emb2,2.6d1,4d1,6.4d1,1d2,
     &     1.6d2,2.4d2,4d2,6.4d2,1d3,1.8d3,3.2d3,5.6d3,1d4,
     &     1.8d4,3.2d4,5.6d4,1d5,1.8d5,3.2d5,5.6d5,1d6,
     &     1.8d6,3.2d6,5.6d6,1d7,1.8d7,3.2d7,5.6d7,1d8,
     &     1.8d8,3.2d8,5.6d8,1d9/
      save

      if (f.lt.1.or.f.gt.np) then
         print *,"Error: invalid parton flavour = ",f
         stop
      end if

      if (i.lt.0.or.i.gt.nhess) then
         print *,"Error: invalid eigenvector number = ",i
         stop
      end if

C--   Check if the requested parton set is already in memory.
      if(oldprefix(i).eq.prefix) goto 10

C--   Start of initialisation for eigenvector set "i" ...
C--   Do this only the first time the set "i" is called,
C--   OR if the prefix has changed from the last time.

C--   Check that the character arrays "oldprefix" and "filename"
C--   are large enough.
      if (len_trim(prefix).gt.len(oldprefix(i))) then
         print *,"Error in GetOnePDF: increase size of oldprefix"
         stop
      else if (len_trim(prefix)+7.gt.len(filename)) then
         print *,"Error in GetOnePDF: increase size of filename"
         stop
      end if

      write(set,'(I2.2)') i     ! convert integer to string
C--   Remove trailing blanks from prefix before assigning filename.
      filename = prefix(1:len_trim(prefix))//'.'//set//'.dat'
C--   Line below can be commented out if you don't want this message.
      print *,"Reading grid from ",filename(1:len_trim(filename))
      open(unit=33,file=filename,iostat=io,status='old')
      if (io.ne.0) then
         print *,"Error: can't open ",filename
         stop
      end if

      do n=1,nx-1
         do m=1,nq              ! N.B. Read 7 before 6!
            read(33,50,iostat=io) f1(n,m),f2(n,m),f3(n,m),f4(n,m),
     &           f5(n,m),f7(n,m),f6(n,m),f8(n,m),f9(n,m)
C--   Notation:1=upv 2=dnv 3=glu 4=usea 5=chm 6=str 7=bot 8=dsea 9=sbar
            if (io.ne.0) then
               print *,"Error reading ",filename
               stop
            end if
         enddo
      enddo
 50   format(9e13.5)

C--   Check that ALL the file contents have been read in.
      read(33,*,iostat=io) dummy
      if (io.eq.0) then
         print *,"Error: not at end of ",filename
         stop
      end if
      close(unit=33)

      do m=1,nq
         f1(nx,m)=0d0
         f2(nx,m)=0d0
         f3(nx,m)=0d0
         f4(nx,m)=0d0
         f5(nx,m)=0d0
         f6(nx,m)=0d0
         f7(nx,m)=0d0
         f8(nx,m)=0d0
         f9(nx,m)=0d0
      enddo

      do n=1,nx
         xxl(n)=log10(xx(n))
      enddo
      do m=1,nq
         qql(m)=log10(qq(m))
      enddo

      call InitialisePDF(i,nhess,nx,nq,nqc0,nqb0,xxl,qql,f1,cc1)
      call InitialisePDF(i,nhess,nx,nq,nqc0,nqb0,xxl,qql,f2,cc2)
      call InitialisePDF(i,nhess,nx,nq,nqc0,nqb0,xxl,qql,f3,cc3)
      call InitialisePDF(i,nhess,nx,nq,nqc0,nqb0,xxl,qql,f4,cc4)
      call InitialisePDF(i,nhess,nx,nq,nqc0,nqb0,xxl,qql,f6,cc6)
      call InitialisePDF(i,nhess,nx,nq,nqc0,nqb0,xxl,qql,f8,cc8)
      call InitialisePDF(i,nhess,nx,nq,nqc0,nqb0,xxl,qql,f9,cc9)
      
      do m=1,nqc
         qqlc(m)=qql(m+nqc0)
         do  n=1,nx
            fc(n,m)=f5(n,m+nqc0)
         enddo
      enddo
      call InitialisePDF(i,nhess,nx,nqc,nqc0-nqc0,nqb0-nqc0,
     &     xxl,qqlc,fc,ccc)
      
      do m=1,nqb
         qqlb(m)=qql(m+nqb0)
         do n=1,nx
            fb(n,m)=f7(n,m+nqb0)
         enddo
      enddo
      call InitialisePDF(i,nhess,nx,nqb,nqc0-nqb0,nqb0-nqb0,
     &     xxl,qqlb,fb,ccb)

      oldprefix(i) = prefix

C--   ... End of initialisation for eigenvector set "i".

   10 continue

      qsq=q*q
C--   If emc2-eps < qsq < emc2, then qsq = emc2-eps.
      if (qsq.gt.qq(nqc0).and.qsq.lt.qq(nqc0+1)) qsq = qq(nqc0)
C--   If emb2-eps < qsq < emb2, then qsq = emb2-eps.
      if (qsq.gt.qq(nqb0).and.qsq.lt.qq(nqb0+1)) qsq = qq(nqb0)
      
      xlog=log10(x)
      qsqlog=log10(qsq)

      res = 0.d0
      
      if (x.le.0.d0.or.x.gt.xmax.or.qsq.lt.qsqmin) then

         print *,"Error in GetOnePDF: x,qsq = ",x,qsq
         if (fatal) stop

      else if (x.lt.xmin.or.qsq.gt.qsqmax) then ! extrapolate

         if (warn) then
            print *, "Warning in GetOnePDF, extrapolating: f = ",f,
     &           ", x = ",x,", q = ",q
         end if

         if (f.eq.1) then       ! upv
            res = ExtrapolatePDF(i,nhess,xlog,qsqlog,nx,nq,xxl,qql,cc1)
         else if (f.eq.2) then  ! dnv
            res = ExtrapolatePDF(i,nhess,xlog,qsqlog,nx,nq,xxl,qql,cc2)
         else if (f.eq.3) then  ! glu
            res = ExtrapolatePDF(i,nhess,xlog,qsqlog,nx,nq,xxl,qql,cc3)
         else if (f.eq.4) then  ! usea
            res = ExtrapolatePDF(i,nhess,xlog,qsqlog,nx,nq,xxl,qql,cc4)
         else if (f.eq.6) then  ! str
            res = ExtrapolatePDF(i,nhess,xlog,qsqlog,nx,nq,xxl,qql,cc6)
         else if (f.eq.8) then  ! dsea
            res = ExtrapolatePDF(i,nhess,xlog,qsqlog,nx,nq,xxl,qql,cc8)
         else if (f.eq.9) then  ! sbar
            res = ExtrapolatePDF(i,nhess,xlog,qsqlog,nx,nq,xxl,qql,cc9)
         else if (f.eq.5.and.qsq.ge.emc2) then ! chm
            res = ExtrapolatePDF(i,nhess,xlog,qsqlog,nx,nqc,xxl,qqlc,
     &           ccc)
         else if (f.eq.7.and.qsq.ge.emb2) then ! bot
            res = ExtrapolatePDF(i,nhess,xlog,qsqlog,nx,nqb,xxl,qqlb,
     &           ccb)
         end if

      else                      ! do usual interpolation

         if (f.eq.1) then       ! upv
            res = InterpolatePDF(i,nhess,xlog,qsqlog,nx,nq,xxl,qql,cc1)
         else if (f.eq.2) then  ! dnv
            res = InterpolatePDF(i,nhess,xlog,qsqlog,nx,nq,xxl,qql,cc2)
         else if (f.eq.3) then  ! glu
            res = InterpolatePDF(i,nhess,xlog,qsqlog,nx,nq,xxl,qql,cc3)
         else if (f.eq.4) then  ! usea
            res = InterpolatePDF(i,nhess,xlog,qsqlog,nx,nq,xxl,qql,cc4)
         else if (f.eq.6) then  ! str
            res = InterpolatePDF(i,nhess,xlog,qsqlog,nx,nq,xxl,qql,cc6)
         else if (f.eq.8) then  ! dsea
            res = InterpolatePDF(i,nhess,xlog,qsqlog,nx,nq,xxl,qql,cc8)
         else if (f.eq.9) then  ! sbar
            res = InterpolatePDF(i,nhess,xlog,qsqlog,nx,nq,xxl,qql,cc9)
         else if (f.eq.5.and.qsq.ge.emc2) then ! chm
            res = InterpolatePDF(i,nhess,xlog,qsqlog,nx,nqc,xxl,qqlc,
     &           ccc)
         else if (f.eq.7.and.qsq.ge.emb2) then ! bot
            res = InterpolatePDF(i,nhess,xlog,qsqlog,nx,nqb,xxl,qqlb,
     &           ccb)
         end if
         
      end if

      GetOnePDF = res

      return
      end

C----------------------------------------------------------------------

      subroutine InitialisePDF(i,nhess,nx,my,myc0,myb0,xx,yy,ff,cc)
      implicit none
      integer nhess,i,nx,my,myc0,myb0,j,k,l,m,n
      double precision xx(nx),yy(my),ff(nx,my),
     &     ff1(nx,my),ff2(nx,my),
     &     ff12(nx,my),yy0(4),yy1(4),yy2(4),yy12(4),z(16),
     &     cl(16),cc(0:nhess,nx,my,4,4),iwt(16,16),
     &     dx,dy,polderiv,d1,d2,d1d2,xxd

      data iwt/1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
     &     0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,
     &     -3,0,0,3,0,0,0,0,-2,0,0,-1,0,0,0,0,
     &     2,0,0,-2,0,0,0,0,1,0,0,1,0,0,0,0,
     &     0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,
     &     0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,
     &     0,0,0,0,-3,0,0,3,0,0,0,0,-2,0,0,-1,
     &     0,0,0,0,2,0,0,-2,0,0,0,0,1,0,0,1,
     &     -3,3,0,0,-2,-1,0,0,0,0,0,0,0,0,0,0,
     &     0,0,0,0,0,0,0,0,-3,3,0,0,-2,-1,0,0,
     &     9,-9,9,-9,6,3,-3,-6,6,-6,-3,3,4,2,1,2,
     &     -6,6,-6,6,-4,-2,2,4,-3,3,3,-3,-2,-1,-1,-2,
     &     2,-2,0,0,1,1,0,0,0,0,0,0,0,0,0,0,
     &     0,0,0,0,0,0,0,0,2,-2,0,0,1,1,0,0,
     &     -6,6,-6,6,-3,-3,3,3,-4,4,2,-2,-2,-2,-1,-1,
     &     4,-4,4,-4,2,2,-2,-2,2,-2,-2,2,1,1,1,1/

      do m=1,my
         dx=xx(2)-xx(1)
         ff1(1,m)=(ff(2,m)-ff(1,m))/dx
         dx=xx(nx)-xx(nx-1)
         ff1(nx,m)=(ff(nx,m)-ff(nx-1,m))/dx
         do n=2,nx-1
            ff1(n,m)=polderiv(xx(n-1),xx(n),xx(n+1),ff(n-1,m),ff(n,m),
     x           ff(n+1,m))
         enddo
      enddo

C--   Calculate the derivatives at qsq=emc2-eps,emc2,emb2-eps,emb2
C--   in a similar way as at the endpoints qsqmin and qsqmax.
      do n=1,nx
         do m = 1, my
            if (m.eq.1.or.m.eq.myc0+1.or.m.eq.myb0+1) then
               dy=yy(m+1)-yy(m)
               ff2(n,m)=(ff(n,m+1)-ff(n,m))/dy
            else if (m.eq.my.or.m.eq.myc0.or.m.eq.myb0) then
               dy=yy(m)-yy(m-1)
               ff2(n,m)=(ff(n,m)-ff(n,m-1))/dy
            else
               ff2(n,m)=polderiv(yy(m-1),yy(m),yy(m+1),ff(n,m-1),
     &              ff(n,m),ff(n,m+1))
            end if
         end do
      end do

      do m=1,my
         dx=xx(2)-xx(1)
         ff12(1,m)=(ff2(2,m)-ff2(1,m))/dx
         dx=xx(nx)-xx(nx-1)
         ff12(nx,m)=(ff2(nx,m)-ff2(nx-1,m))/dx
         do n=2,nx-1
            ff12(n,m)=polderiv(xx(n-1),xx(n),xx(n+1),ff2(n-1,m),
     x           ff2(n,m),ff2(n+1,m))
         enddo
      enddo

      do n=1,nx-1
         do m=1,my-1
            d1=xx(n+1)-xx(n)
            d2=yy(m+1)-yy(m)
            d1d2=d1*d2
            
            yy0(1)=ff(n,m)
            yy0(2)=ff(n+1,m)
            yy0(3)=ff(n+1,m+1)
            yy0(4)=ff(n,m+1)
            
            yy1(1)=ff1(n,m)
            yy1(2)=ff1(n+1,m)
            yy1(3)=ff1(n+1,m+1)
            yy1(4)=ff1(n,m+1)
            
            yy2(1)=ff2(n,m)
            yy2(2)=ff2(n+1,m)
            yy2(3)=ff2(n+1,m+1)
            yy2(4)=ff2(n,m+1)
            
            yy12(1)=ff12(n,m)
            yy12(2)=ff12(n+1,m)
            yy12(3)=ff12(n+1,m+1)
            yy12(4)=ff12(n,m+1)
            
            do k=1,4
               z(k)=yy0(k)
               z(k+4)=yy1(k)*d1
               z(k+8)=yy2(k)*d2
               z(k+12)=yy12(k)*d1d2
            enddo
            
            do l=1,16
               xxd=0.d0
               do k=1,16
                  xxd=xxd+iwt(k,l)*z(k)
               enddo
               cl(l)=xxd
            enddo
            l=0
            do k=1,4
               do j=1,4
                  l=l+1
                  cc(i,n,m,k,j)=cl(l)
               enddo
            enddo
         enddo
      enddo
      return
      end

C----------------------------------------------------------------------

      double precision function InterpolatePDF(i,nhess,x,y,nx,my,xx,yy,
     &     cc)
      implicit none
      integer i,nx,my,nhess,locx,l,m,n
      double precision xx(nx),yy(my),cc(0:nhess,nx,my,4,4),
     &     x,y,z,t,u

      n=locx(xx,nx,x)
      m=locx(yy,my,y)
      
      t=(x-xx(n))/(xx(n+1)-xx(n))
      u=(y-yy(m))/(yy(m+1)-yy(m))
      
      z=0.d0
      do l=4,1,-1
         z=t*z+((cc(i,n,m,l,4)*u+cc(i,n,m,l,3))*u
     .        +cc(i,n,m,l,2))*u+cc(i,n,m,l,1)
      enddo

      InterpolatePDF = z

      return
      end

C----------------------------------------------------------------------

      double precision function ExtrapolatePDF(i,nhess,x,y,nx,my,xx,yy,
     &     cc)
      implicit none
      integer i,nx,my,nhess,locx,n,m
      double precision xx(nx),yy(my),cc(0:nhess,nx,my,4,4),
     &     x,y,z,f0,f1,z0,z1,InterpolatePDF
      
      n=locx(xx,nx,x)           ! 0: below xmin, nx: above xmax
      m=locx(yy,my,y)           ! 0: below qsqmin, my: above qsqmax
      
C--   If extrapolation in small x only:
      if (n.eq.0.and.m.gt.0.and.m.lt.my) then
         f0 = InterpolatePDF(i,nhess,xx(1),y,nx,my,xx,yy,cc)
         f1 = InterpolatePDF(i,nhess,xx(2),y,nx,my,xx,yy,cc)
         if (f0.gt.0.d0.and.f1.gt.0.d0) then
            z = exp(log(f0)+(log(f1)-log(f0))/(xx(2)-xx(1))*(x-xx(1)))
         else
            z = f0+(f1-f0)/(xx(2)-xx(1))*(x-xx(1))
         end if
C--   If extrapolation into large q only:
      else if (n.gt.0.and.m.eq.my) then
         f0 = InterpolatePDF(i,nhess,x,yy(my),nx,my,xx,yy,cc)
         f1 = InterpolatePDF(i,nhess,x,yy(my-1),nx,my,xx,yy,cc)
         if (f0.gt.0.d0.and.f1.gt.0.d0) then
            z = exp(log(f0)+(log(f0)-log(f1))/(yy(my)-yy(my-1))*
     &           (y-yy(my)))
         else
            z = f0+(f0-f1)/(yy(my)-yy(my-1))*(y-yy(my))
         end if
C--   If extrapolation into large q AND small x:
      else if (n.eq.0.and.m.eq.my) then
         f0 = InterpolatePDF(i,nhess,xx(1),yy(my),nx,my,xx,yy,cc)
         f1 = InterpolatePDF(i,nhess,xx(1),yy(my-1),nx,my,xx,yy,cc)
         if (f0.gt.0.d0.and.f1.gt.0.d0) then
            z0 = exp(log(f0)+(log(f0)-log(f1))/(yy(my)-yy(my-1))*
     &           (y-yy(my)))
         else
            z0 = f0+(f0-f1)/(yy(my)-yy(my-1))*(y-yy(my))
         end if
         f0 = InterpolatePDF(i,nhess,xx(2),yy(my),nx,my,xx,yy,cc)
         f1 = InterpolatePDF(i,nhess,xx(2),yy(my-1),nx,my,xx,yy,cc)
         if (f0.gt.0.d0.and.f1.gt.0.d0) then
            z1 = exp(log(f0)+(log(f0)-log(f1))/(yy(my)-yy(my-1))*
     &           (y-yy(my)))
         else
            z1 = f0+(f0-f1)/(yy(my)-yy(my-1))*(y-yy(my))
         end if
         if (z0.gt.0.d0.and.z1.gt.0.d0) then
            z = exp(log(z0)+(log(z1)-log(z0))/(xx(2)-xx(1))*(x-xx(1)))
         else
            z = z0+(z1-z0)/(xx(2)-xx(1))*(x-xx(1))
         end if
      else
         print *,"Error in ExtrapolatePDF"
         stop
      end if

      ExtrapolatePDF = z      

      return
      end

C----------------------------------------------------------------------

      integer function locx(xx,nx,x)
      implicit none
      integer nx,jl,ju,jm
      double precision x,xx(nx)
      if(x.eq.xx(1)) then
         locx=1
         return
      endif
      if(x.eq.xx(nx)) then
         locx=nx-1  
         return
      endif
      ju=nx+1
      jl=0
    1 if((ju-jl).le.1) go to 2
      jm=(ju+jl)/2
      if(x.ge.xx(jm)) then
         jl=jm
      else
         ju=jm
      endif
      go to 1
    2 locx=jl
      return
      end

C----------------------------------------------------------------------

      double precision function polderiv(x1,x2,x3,y1,y2,y3)
      implicit none
      double precision x1,x2,x3,y1,y2,y3
      polderiv=(x3*x3*(y1-y2)-2.d0*x2*(x3*(y1-y2)+x1*(y2-y3))
     &     +x2*x2*(y1-y3)+x1*x1*(y2-y3))/((x1-x2)*(x1-x3)*(x2-x3))
      return
      end

C----------------------------------------------------------------------
