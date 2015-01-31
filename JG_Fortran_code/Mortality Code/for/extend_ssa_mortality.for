       !DEC$ NOFREEFORM
       !DEC$ FIXEDFORMLINESIZE:132
       subroutine extend_ssa_mortality
       implicit real*8(a-h,o-z)
       include 'common.blk'
c
       dimension ddth_rate_top(5), ddth_rate_bot(5)
	 dimension dth_rate_top(21), dth_rate_bot(21)
c
       data ddth_rate_bot /  0,  15,  50,  65,  85/
	 data ddth_rate_top / 14,  49,  64,  84, 180/
c
       data dth_rate_bot /  0,   1,   5,  10,  15,  20,  25,   30,  35,  40,  45,  50,  55,  60,  65,  70,  75,  80,  85,  90,  95/
	 data dth_rate_top /  0,   4,   9,  14,  19,  24,  29,   34,  39,  44,  49,  54,  59,  64,  69,  74,  79,  84,  89,  94, 180/
c
       if (alt=='111') iss_alt = 1_4
       if (alt=='211') iss_alt = 2_4
       if (alt=='311') iss_alt = 3_4

       do 300 it = itend+1,3500
	   do 200 j = 0,180
c
	     do 170 j_cat = 1,21
	       if (j>=dth_rate_bot(j_cat).and.j<=dth_rate_top(j_cat)) then 
		     jj = j_cat
		     go to 171
             endif	        
170        continue
c
171        do 180 j_cat = 1,5
	       if (j>=ddth_rate_bot(j_cat).and.j<=ddth_rate_top(j_cat)) then
		     kk = j_cat
		     go to 181
             endif	        
180        continue
c
181        dm(it,j) = 0.0_8
           df(it,j) = 0.0_8
           do 190 k = 1,7
	       dth_rate_m(it,iss_alt,jj,k) = dth_rate_m(it-1,iss_alt,jj,k)*(1.0_8-ddth_rate_m(iss_alt,kk,k))
	       dth_rate_f(it,iss_alt,jj,k) = dth_rate_f(it-1,iss_alt,jj,k)*(1.0_8-ddth_rate_f(iss_alt,kk,k))
	       dm(it,j) = dm(it,j) + dth_rate_m(it,iss_alt,jj,k)
	       df(it,j) = df(it,j) + dth_rate_f(it,iss_alt,jj,k)
190        continue
           dm(it,j) = dmin1(dm(it-1,j), dm(it,j), 1.0_8)
	     df(it,j) = dmin1(df(it-1,j), df(it,j), 1.0_8)
c
200      continue
c
300    continue
c
       do 400 it=1900,3500
c
         do 350 j = 0,180
	     if (dm(it,j)>1.0_8) dm(it,j)=1.0_8
           if (df(it,j)>1.0_8) df(it,j)=1.0_8
350      continue
c
         write (31,*) it,' male '
         write (31,101) (dm(it,j),j=0,180)
         write (32,*) it,' female '
         write (32,101) (df(it,j),j=0,180)
400    continue
c
c       do 400 it = 1900,3490,10
c         write (31,103) it,'-',it+9,' Male   '
c         write (32,103) it,'-',it+9,' Female '
c         do 350 j = 0,118
c           write (31,102) j,(dm(itt,j),itt=it,it+9)
c           write (32,102) j,(df(itt,j),itt=it,it+9)
c350      continue
c400    continue
c
c       do 350 j = 0,118
c         write (31,102) j,(dm(itt,j),itt=1900,2000,10)
c         write (32,102) j,(df(itt,j),itt=1900,2000,10)
c350    continue
c
101	 format (10f10.6)
102	 format (15x,i4,1x,10(f10.8,1x))
103	 format (i4,a1,i4,1x,a8)
c
c **** ALL DONE: RETURN TO CALLING ROUTINE
c
       return
	 end