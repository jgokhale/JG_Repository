       !DEC$ NOFREEFORM
       !DEC$ FIXEDFORMLINESIZE:132
       subroutine find_mortality_trend
       implicit real*8(a-h,o-z)
       include 'common.blk'
c
c **** THIS PROGRAM COMPUTES THE TREND IN MORTALITY FOR THE LAST N YEARS OF SSA's PROJECTION HORIZON
c
c **** FIND THE TREND IN MORTALITY FOR THE FINAL N YEARS OF SSA'S PROJECTION HORIZON 
c **** AND CALCULATE THE AVERAGE RATE OF MORTALITY DECLINE.
c
       ave_ddm = 0.0_8
	 ave_ddf = 0.0_8
c
       do 100 j = 0,119
c         do 90 it = itend-n+1,itend
         do 90 it = itend-n+1,itend
	     ddm_pct(it,j) = (1.0_8-(dm(it,j)/dm(it-1,j)))*100.0_8
	     ddf_pct(it,j) = (1.0_8-(df(it,j)/df(it-1,j)))*100.0_8
	     ave_ddm(j) = ave_ddm(j) + ddm_pct(it,j)
	     ave_ddf(j) = ave_ddf(j) + ddf_pct(it,j)
90       continue
         ave_ddm = ave_ddm/dfloat(n)
	   ave_ddf = ave_ddf/dfloat(n)
         write (33,102) j, ave_ddm(j), ave_ddf(j) 
100    continue
c
       do 120 j = 5,115,5
c	   write (34,102) j,(ddm_pct(it,j),it=itend-n+1,itend)
c	   write (35,102) j,(ddf_pct(it,j),it=itend-n+1,itend)
	   write (34,102) j,(ddm_pct(it,j),it=itend-n+1,itend)
	   write (35,102) j,(ddf_pct(it,j),it=itend-n+1,itend)
120    continue
c
101	 format (10f10.6)
102    format (i4,1x,120(f6.3,1x))
c
c **** ALL DONE. RETURN TO CALLING ROUTINE
c
       return
	 end