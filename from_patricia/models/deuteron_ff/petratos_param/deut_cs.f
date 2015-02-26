!	program to calcuate elastic electron deuteron cs
	program deut_cs
!	
!
	rmp = 0.9382
	pi = 3.141593
	rads = 0.01745329
	fscnst = .00729714
	hbc = 0.1973289
	write(6,*) 'Deuteron elastic cross section'
	write(6,*)' Parametrizations of A abd B from Makis Petratos'
	write(6,1)
1	format ('$ Enter E(GeV), theta : ')
	read(5,*)e,theta
!	
	th2r=theta*rads/2.
	thr=theta*rads
	tn2=(tan(th2r))**2. 
	cost = cos(thr)
	sint = sin(thr)
	s2=(sin(th2r))**2.
	cs2 = cos(th2r)**2
!	calculate some numbers
	rmt = 2*rmp	!mass of target
 	frec = 1./(1+2.*e/rmt*s2)
	ef = e*frec
	omega = e - ef	!energy loss
	qv = sqrt(e**2 + ef**2 - 2.*e*ef*cosd(theta))
	q42=4.*e*ef*s2 
	qx=e-ef*cost 
	qy=-ef*sint 
	qz=0.0
	qv2=q42+omega**2 
	qv=sqrt(qv2)
	sigmot =    (fscnst/(2.*e*s2))**2*cs2/frec
	sigmot = sigmot * 0.01 * hbc**2       ! units in barns
	call deut_ff(q42,aff,bff)
	sigd = sigmot*(aff + bff*tn2)
	write(6,'(a,f7.3,a,e10.5,a,e10.5)')' q42 = ',q42,
     >	' aff = ',aff,' bff = ',bff
	write(6,'(a,f7.3,a,f5.1,a,e10.5)')' sigd at e = ',e,' and 
     >	theta = ',theta,' = ',sigd
!	call exit
	stop
	end
!
