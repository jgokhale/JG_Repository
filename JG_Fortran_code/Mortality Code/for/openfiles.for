       !DEC$ NOFREEFORM
       !DEC$ FIXEDFORMLINESIZE:132
       subroutine openfiles
       implicit real*8(a-h,o-z)
       include 'common.blk'
c
c **** THIS PROGRAM READS THE SSA MORTALITY PROBABILITIES FILE, EXTRACTS
c **** MORTALITY PROBABILITIES BY AGE AND SEX, AND REWRITES THEM IN TWO FILES
c **** DTHM.X AND DTHF.X, WHERE X=1,2,OR 3, (SSA ALTERNATIVE ASSUMPTIONS: 1=HIGH COST, 2=INTERMEDIATE, 3=LOW COST).
c
c
c **** The variable "alt" holds filename extension for input and output file--denoting SSA assumptions
c ****               111 = High Cost
c ****               211 = Intermediate
c ****               311 = Low Cost
c
c **** Construct the input and output filenames based on value of "alt"
c
c **** Open input and output files.
c
       open (unit=20,file='c:\Wharton\Mortality\io\per0007.h11')
       open (unit=21,file='c:\Wharton\Mortality\io\per0800.211')
	 open (unit=31,file='c:\Wharton\Mortality\io\dm2100.211')
	 open (unit=32,file='c:\Wharton\Mortality\io\df2100.211')
	 open (unit=33,file='c:\Wharton\Mortality\io\ave_ddx.211')
	 open (unit=34,file='c:\Wharton\Mortality\io\trnd_dm.211')
	 open (unit=35,file='c:\Wharton\Mortality\io\trnd_df.211')
	 open (unit=36,file='c:\Wharton\Mortality\io\coefddx.211')
c
       open (unit=51,file='c:\Wharton\Mortality\io\CausDth.alt1')
       open (unit=52,file='c:\Wharton\Mortality\io\CausDth.alt2')
       open (unit=53,file='c:\Wharton\Mortality\io\CausDth.alt3')
c       
       return
	 end