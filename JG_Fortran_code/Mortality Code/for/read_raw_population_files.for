       !DEC$ NOFREEFORM
       !DEC$ FIXEDFORMLINESIZE:132
       subroutine read_raw_population_files
       implicit real*8(a-h,o-z)
       include 'common.blk'
c
c **** THIS PROGRAM READS THE SSA MORTALITY PROBABILITIES FILE, EXTRACTS
c **** MORTALITY PROBABILITIES BY AGE AND SEX, AND REWRITES THEM IN TWO FILES
c **** DTHM.X AND DTHF.X, WHERE X=1,2,OR 3, (SSA ALTERNATIVE ASSUMPTIONS: 1=HIGH COST, 2=INTERMEDIATE, 3=LOW COST).
c
c **** Code to read in and reformat mortality data. ******************************************
c
       i_male = 1_4
c
c **** Data for different years from 1900 through 2080 is stacked beginning with data for 2000.
c **** For each year, data on male mortality is followed by data on female mortality.
c **** For a given year and given sex, the data is organized in 'sections' (See below).
c
c **** Open level-1 loop over years.
c
	 do	250 k=itbeg,itend
c
           iunit = 20
           if (k>=2008) iunit=21
c
c **** Initialize age counter "iagem" to zero
c
		 iagem = 0
c
c **** Data is organized in 'sections' with 6 header rows followed by 12 'data-groups' in each section.
c **** A data group has 5 rows of numbers followed by 1 blank line [12x(5+1) = 60+12 rows per section].
c **** Each year's data is organized in two sections for age range 0-119 (120 lines of data in two sections).
c
c **** Begin reading a section of data: read across the first 6 header lines lines in variable "mspace."
c **** This is just to get the current line positioned at the 1st row of data
c
105        do 110 km1 = 1,6
	       read (iunit,101) mspace
110        continue
c
c **** Open level-2 loop over data group
c
           do 145 km2 = 1,12
c
c **** Open level-3 loop over data group: read each line of information and advance age count "iagem" by 1.
c
             do 140 j=1,5
               read (iunit,*) junk, dm(k,iagem)
               iagem = iagem + 1
c
c **** Close level-3 loop
c
140          continue
c
c **** Read the blank line in the variable "mspace"
c
             read (iunit,101) mspace
c
c **** Done with level-2 loop
c
145        continue
c
c **** If age is < 119 repeat reading the second section of data.  Age=119 implies we have finished reading the 2 sections for this year
c **** In that case, read female mortality data for the year k.
c
	     if (iagem<119) go to 105
c
c **** Initialize age counter "iagef" to zero.
c
	     iagef = 0
c
c
c **** Begin reading a section of data: read across the first 6 header lines lines in variable "mspace."
c **** This is just to get the current line positioned at the 1st row of data
c
205        do 210 kf1 = 1,6
	       read (iunit,101) mspace
210        continue
c
c **** Open level-2 loop over data group
c
           do 245 kf2 = 1,12
c
c **** Open level-3 loop over data group: read each line of information and advance age count "iagem" by 1.
c
             do 240 j=1,5
               read (iunit,102) junk, df(k,iagef)
               iagef = iagef + 1
c
c **** Close level-3 loop
c
240          continue
c
c **** Read the blank line in the variable "mspace"
c
             read (iunit,101) mspace
c
c **** Done with level-2 loop
c
245        continue
c
c **** If age is < 119 repeat reading the second section of data.  Age=119 implies we have finished reading the 2 sections for this year
c **** In that case, read female mortality data for the year k.
c
	     if (iagef<119) go to 205
c
c **** Write output: Header line with year and sex label for males
c ****               Mortality data for males
c ****               Header line with year and sex label for females
c ****               Mortality data for females
c
         do 255 j = 120,180
           dm(k,j) = 1.0_8
	     df(k,j) = 1.0_8
255      continue
c
         if (k>=1970) then
           dm(k,120) = 1.0_8
           df(k,120) = 1.0_8
           write (31,103) k,(dm(k,j),j=0,119)
           write (32,103) k,(df(k,j),j=0,119)
         endif
c
c **** All done with this year, process the next year.
c
250    continue
101	 format (1a15)
102    format (i4,f10.8)
103	 format (i4,1x,120(f10.6,1x))
c     
c **** All done.  Close I-O files and stop
c
	 return
	 end