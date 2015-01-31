       !DEC$ NOFREEFORM
       !DEC$ FIXEDFORMLINESIZE:132
       subroutine read_cause_death_files
       implicit real*8(a-h,o-z)
       include 'common.blk'
c
       character*4 char_aged,char_year,char_junk
       character*5 char_agegrp
       character*6 char_sex
c
       do 100 i_alt = 1,3
5        read (50+i_alt,*) char_junk
         read (50+i_alt,101) char_sex,char_aged,char_agegrp
         if (char_agegrp=='    0') j_cat=1_4
         read (50+i_alt,*) char_junk
         read (50+i_alt,*) char_junk
         read (50+i_alt,*) char_junk
         read (50+i_alt,*) char_junk
10       read (50+i_alt,*) iyr,(p(k),k=1,8)
         if (iyr==0) go to 10
c
         if (char_sex=='  Male') then
           total_dth_rate_m(iyr,i_alt,j_cat)=p(1)
           do 120 k = 2,8
             dth_rate_m(iyr,i_alt,j_cat,k-1)=p(k)
120        continue
         endif
         if (char_sex=='Female') then
           total_dth_rate_f(iyr,i_alt,j_cat)=p(1)
           do 130 k = 2,8
             dth_rate_f(iyr,i_alt,j_cat,k-1)=p(k)
130        continue
         endif        
c
         if (iyr<2100) go to 10
         if (char_agegrp=='  85+'.and.char_sex=='Female') go to 100
         if (iyr==2100.and.j_cat<26) then  
           j_cat = j_cat + 1_4
           go to 5
         endif
         if (iyr==2100.and.j_cat==26) go to 5
100    continue
c
       do 200 i_alt = 1,3
         do 195 j_cat = 22,26
           do 190 i_caus=1,7
             do 185 iyr=2030,2095,5
                ddth_rate_m(i_alt,j_cat-21,i_caus) = ddth_rate_m(i_alt,j_cat-21,i_caus) + 
     *                                            (dth_rate_m(iyr+5,i_alt,j_cat,i_caus)-dth_rate_m(iyr,i_alt,j_cat,i_caus))/5.0_8
                ddth_rate_f(i_alt,j_cat-21,i_caus) = ddth_rate_f(i_alt,j_cat-21,i_caus) + 
     *                                            (dth_rate_f(iyr+5,i_alt,j_cat,i_caus)-dth_rate_f(iyr,i_alt,j_cat,i_caus))/5.0_8
185          continue
190        continue
195      continue
200    continue              
c
101    format (1x,a6,1x,a4,1x,a5)
102    format (6x,i4,8(f10.1))
103    format (8(f10.1))
c
       return
       end