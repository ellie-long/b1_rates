!
	subroutine deut_ff(q2,a,b)
!	small subroutine to return the a and b form factors of the
!	deuteron
!	q2 in gev**2
!	parametrizations from Makis Petratos
!
	A = 10**(-2.5275-1.5704*Q2+0.09667*Q2**2) 
	B = 10**(-2.1870-3.4066*Q2+0.44380*Q2**2) 
!
	return
	end
