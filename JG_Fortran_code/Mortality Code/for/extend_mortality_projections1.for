       !DEC$ NOFREEFORM
       !DEC$ FIXEDFORMLINESIZE:132
       subroutine extend_mortality_projections1(dm, df, itbeg, itend, n, i_reg_type)
       implicit real*8(a-h,o-z)
c
	 DOUBLE PRECISION xdt_m(n,2), xdt_f(n,2), b(n+1)
	 DOUBLE PRECISION ydt_m(n),   ydt_f(n)
	 dimension zdt_m(n),   zdt_f(n)
	 dimension c0_m(0:180), c0_f(0:180)
	 dimension c1_m(0:180), c1_f(0:180)
	 dimension c2_m(0:180), c2_f(0:180)
	 dimension dm(1900:3500,0:180), df(1900:3500,0:180)
c
c **** THIS PROGRAM COMPUTES THE TREND IN MORTALITY FOR THE LAST N YEARS OF SSA's PROJECTION HORIZON
c
       do 100 j = 0,180
         do 90 it = itend-n+1,itend
c
           if (i_reg_type==1) then
c
c **** Exponential Regression
c
             ydt_m(it-itend+n) = log(dm(it,j))
             ydt_f(it-itend+n) = log(df(it,j))
c
           else
c
c **** Linear Regression
c
             ydt_m(it-itend+n) = dm(it,j)
             ydt_f(it-itend+n) = df(it,j)
c ****
           endif
c
           xdt_m(it-itend+n,1) = dfloat(it-itend+n)
	     xdt_f(it-itend+n,1) = dfloat(it-itend+n)
           xdt_m(it-itend+n,2) = dfloat(it-itend+n)**2.0_8
	     xdt_f(it-itend+n,2) = dfloat(it-itend+n)**2.0_8
c
90       continue
c
         call linear_regression(xdt_m, ydt_m, n, n, b)
	   c0_m(j) = b(1)
	   c1_m(j) = b(2)
	   c2_m(j) = b(3)
         call linear_regression(xdt_f, ydt_f, n, n, b)
	   c0_f(j) = b(1)
	   c1_f(j) = b(2)
	   c2_f(j) = b(3)
	   write (36,101) j,c0_m(j),c1_m(j),c2_m(j),c0_f(j),c1_f(j),c2_f(j)
100    continue
c
c **** EXTRAPOLATE VALUES OF dm(.,.) AND df(.,.) THROUGH 3500 ****************************************************
c
       do 200 it = itend+1,3500
	   do 190 j = 0,180
	     x1 = dfloat(it-itend+n)
		 x2 = dfloat(it-itend+n)**2.0_8
c
           if (i_reg_type==1) then
c
c **** Recover Predicted Values: Exponential Regression
c **** Mortality cannot increase over time--hence the dmin1 function
c **** Mortality cannot fall below a certain level--defined by the dmax1 function.
c 
             dm(it,j) = dmin1(dm(it-1,j), dmax1(0.0_8, dexp(c0_m(j) + c1_m(j)*x1 + c2_m(j)*x2)))
             df(it,j) = dmin1(df(it-1,j), dmax1(0.0_8, dexp(c0_f(j) + c1_f(j)*x1 + c2_f(j)*x2)))

c
           else
c
c **** Recover Predicted Values: Linear Regression
c **** Mortality cannot increase over time--hence the dmin1 function
c **** Mortality cannot fall below a certain level--defined by the dmax1 function.
c
             dm(it,j) = dmin1(dm(it-1,j), dmax1(0.0_8, (c0_m(j) + c1_m(j)*x1 + c2_m(j)*x2)))
             df(it,j) = dmin1(df(it-1,j), dmax1(0.0_8, (c0_f(j) + c1_f(j)*x1 + c2_f(j)*x2)))
c
             if (dm(it,j)>1.0_8) dm(it,j)=1.0_8
             if (df(it,j)>1.0_8) df(it,j)=1.0_8
c
           endif
c
190      continue
200    continue
c
       do 300 it=1900,3500
c
         do 250 j = 0,180
	     if (dm(it,j)>1.0_8) dm(it,j)=1.0_8
           if (df(it,j)>1.0_8) df(it,j)=1.0_8
250      continue
c
         write (31,*) it,' male '
         write (31,102) (dm(it,j),j=0,180)
         write (32,*) it,' female '
         write (32,102) (df(it,j),j=0,180)
300    continue

c
c **** ALL DONE. CLOSE IO FILES AND RETURN TO CALLING ROUTINE.
c
101    format (i4,1x,6(f10.6,1x))
102	 format (10f10.6)
c
       return
	 end
