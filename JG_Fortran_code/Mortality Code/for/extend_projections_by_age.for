       !DEC$ NOFREEFORM
       !DEC$ FIXEDFORMLINESIZE:132
       subroutine extend_projections_by_age(dm,df,n)
       implicit real*8(a-h,o-z)

       dimension dm(1900:3500,0:180),df(1900:3500,0:180)
	 DOUBLE PRECISION xdt(n,4), ydt(n)
	 DOUBLE PRECISION b(4)
c
       do 100 it = 1900,2100
         do 50 j = 119-n+1,119
c
           ydt(j-119+n) = log(dm(it,j))
c
           xdt(j-119+n,1) = dfloat(j-119+n)
           xdt(j-119+n,2) = dfloat(j-119+n)**2.0_8
           xdt(j-119+n,3) = dfloat(j-119+n)**3.0_8
c
50       continue
c
         call linear_regression(xdt, ydt, n, n, b)
c
	   do 75 j = 120,180
	     x1 = dfloat(j-119+n)
	     x2 = dfloat(j-119+n)**2.0_8
	     x3 = dfloat(j-119+n)**3.0_8
           dm(it,j) = dmax1(dm(it,j-1), dexp(b(1) + b(2)*x1 + b(3)*x2) + b(4)*x3)
75       continue
c
100    continue
c
       do 200 it = 1900,2100
         do 150 j = 119-n+1,119
c
           ydt(j-119+n) = log(df(it,j))
c
           xdt(j-119+n,1) = dfloat(j-119+n)
           xdt(j-119+n,2) = dfloat(j-119+n)**2.0_8
c
150      continue
c
         call linear_regression(xdt, ydt, n, n, b) 
c
	   do 175 j = 120,180
	     x1 = dfloat(j-119+n)
	     x2 = dfloat(j-119+n)**2.0_8
	     x3 = dfloat(j-119+n)**3.0_8
           df(it,j) = dmax1(df(it,j-1), dexp(b(1) + b(2)*x1 + b(3)*x2) + b(4)*x3)
175      continue
c
200    continue

c
       return
	 end