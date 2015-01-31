       !DEC$ NOFREEFORM
       !DEC$ FIXEDFORMLINESIZE:132
       implicit real*8(a-h,o-z)
       include 'link_fnl_static.h'
	 include 'common.blk'
c
c **** THIS PROGRAM READS THE SSA MORTALITY PROBABILITIES FILE, EXTRACTS
c **** MORTALITY PROBABILITIES BY AGE AND SEX, AND REWRITES THEM IN TWO FILES
c **** DTHM.X AND DTHF.X, WHERE X=1,2,OR 3, (SSA ALTERNATIVE ASSUMPTIONS: 1=HIGH COST, 2=INTERMEDIATE, 3=LOW COST).
c
c **** THE VARIABLE "alt" HOLDS FILENAME EXTENSION FOR INPUT AND OUTPUT FILE--DENOTING SSA ASSUMPTIONS
c ****               106 = HIGH COST
c ****               206 = INTERMEDIATE
c ****               306 = LOW COST
c
       alt = '211'
c
c **** Select Type of Regression (1=Exponential; 2=Quadratic; 3=SSA Death-Rate Decline)
c
       i_reg_type = 3
c
c **** INITIALIZE THE FOLLOWING VARIABLES: itbeg = BEGINNING YEAR FOR SSA DATA; itend = FINAL YEAR OF SSA DATA;
c
	 itbeg = 1900
	 itend = 2100
c
c **** INITIALIZE n = # OF FINAL SSA YEARS TO USE IN REGRESSION TO EXTRACT TIME TREND IN MORTALITY BY AGE AND SEX.
c **** REGRESSION COEFFICIENTS ARE USED TO PROJECT MORTALITY IMPROVEMENTS BEYOND SSA HORIZON.
c
       n = 50_4
c
c **** Initialize arrays dm and df to zero
c
	 dm = 0.0_8
	 df = 0.0_8
c
c **** STEP 1: OPEN FILES FOR IO
c 
       call openfiles
c
c **** READ CAUSE OF DEATH FILES TO SELECT PROBABILITIES FOR YEAR 2100 (TERMINAL YEAR OF SSA PROJECTIONS)
c
       call read_cause_death_files 
c
c **** STEP 2: CALL ROUTINES TO READ RAW POPULATION FILES AND WRITE OUT MORTALITY BY YEAR, AGE, AND SEX.
c 
       call read_raw_population_files
c
       stop
c
       call extend_projections_by_age(dm,df,50_4)
c
c **** STEP 3: FIND MORTALITY TREND BY AGE-SEX CONTAINED IN SSA ASSUMPTION BEING CONSIDERED (SEE ABOVE)
c 
       call find_mortality_trend
c
c **** IF i_reg_type=3 THEN READ THE SSA DATA ON DEATH RATES BY CAUSE OF DEATH IN 2080 AND RATE OF DECLINE IN DEATH RATES BY CAUSE
c
       if (i_reg_type==3) then
	   call extend_ssa_mortality
	   stop
       endif
c
c **** STEP 4: PROJECT MORTALITY BEYOND SSA HORIZON;
c 
       call extend_mortality_projections1(dm, df, itbeg, itend, n, i_reg_type)
c
c **** ALL DONE. CLOSE FILES AND STOP.
c
       close (21)
	 close (31)
	 close (32)
	 close (33)
	 close (34)
	 close (35)
	 close (36)
c
	 stop
	 end