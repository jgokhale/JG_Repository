       !DEC$ NOFREEFORM
       !DEC$ FIXEDFORMLINESIZE:132
       subroutine linear_regression(X, Y, NOBS, LDX, B)
       implicit real*8(a-h,o-z)
c
       INTEGER INTCEP, LDX, NCOEF, NIND, NOBS
       PARAMETER (INTCEP=1, NIND=3, NCOEF=INTCEP+NIND)
c
       DOUBLE PRECISION B(NCOEF), SSE, SST, X(LDX,NIND), Y(NOBS)
c
       CALL D_RLSE(NOBS, Y, NIND, X, LDX, INTCEP, B, SST, SSE)
c
       return
	 end