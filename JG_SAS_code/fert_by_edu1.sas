filename raw   'C:\cps\req\micro_fert\junmult.raw' ;
FILENAME dat06 "C:/CPS/NBER_JUN/cpsjun06.dat";
FILENAME dat08 "C:/CPS/NBER_JUN/cpsjun08.dat";
FILENAME dat10 "C:/CPS/NBER_JUN/jun10pub.dat";
FILENAME dat12 "C:/CPS/NBER_JUN/jun12pub.dat";

filename  f1 'C:\CPS\req\micro_fert\fert_dist1.dat' ;
filename  f2 'C:\CPS\req\micro_fert\fem_dist1.dat'  ;

options nocenter ;
*************************************************************************************************;
*** This section obtains a data extract of the CPS for years 1995, 1998, 2000, 2002 and 2004;
***;
data edu0; infile raw dlm='"';
  length recnum 8 ; length age 3 ; length sex 3 ; length wgtfnl 8 ; length race 3 ; length birthlm 3 ;
  length birthly 4 ; length month 3 ; length _year 4 ; length grdatn 3 ; length spneth 3 ; length numbaby 3 ;
  input recnum / age / sex / wgtfnl / race / birthlm / birthly / month / _year / grdatn / spneth / numbaby;  year=_year;
  year = _year;
  if year<=2002 and (spneth = 1 or spneth = 2) then spneth = 3;  * Reclassify Hispanic origin according to... ;
  spneth = spneth - 2; 											 *...post 2002 coding from 1 through 5;
  yr_child1 = .;
  wgtfnl=wgtfnl/10000;							* 4 implied decimal places in years 1994-04;
  keep year age sex wgtfnl race birthlm birthly month grdatn spneth numbaby yr_child1;
run;
*************************************************************************************************;
*** This section obtains a data extract of the CPS for 2006;
***;
data edu06; 
  infile dat06 lrecl = 2300 missover; 
  length birthly 4 ; length month 3 ; length year 4 ; length grdatn 3 ; length spneth 3 ; length numbaby 3 ;
  length peage 3; length age 3;
  length pesex 3; length sex 3;
  length perace 3; length race 3;
  length birthlm 3; 
  input
  @16   hrmonth      2. 
  @122  peage        2. 
  @129  pesex        2. 
  @137  peeduca      2. 
  @139  perace       2. 
  @141  PRDTHSP      2. 
  @613  pwsswgt    10.4 
  @951  pesf1        2. 
  @953  pesf2a       2. 
  @955  pesf2b       4. ;

  year = 2006;
  age = peage; sex = pesex; wgtfnl = pwsswgt; race = perace; birthlm = PESF2A; birthly = PESF2B; month = hrmonth;
  grdatn = peeduca; spneth = PRDTHSP; numbaby = pesf1; yr_child1 = .;
  keep year age sex wgtfnl race birthlm birthly month grdatn spneth numbaby yr_child1;
run;
*************************************************************************************************;
*** This section obtains a data extract of the CPS for 2008;
***;
data edu08; 
  infile dat08 lrecl = 2300 missover; 
  length birthly 4 ; length month 3 ; length year 4 ; length grdatn 3 ; length spneth 3 ; length numbaby 3 ;
  length peage 3; length age 3;
  length pesex 3; length sex 3;
  length perace 3; length race 3;
  length birthlm 3; 
  input
  @16   hrmonth      2. 
  @122  peage        2. 
  @129  pesex        2. 
  @137  peeduca      2. 
  @139  perace       2. 
  @141  PRDTHSP      2. 
  @613  pwsswgt    10.4 
  @951  pesf1        2. 
  @953  pesf2a       2. 
  @955  pesf2b       4. ;

  year = 2008;
  age = peage; sex = pesex; wgtfnl = pwsswgt; race = perace; birthlm = PESF2A; birthly = PESF2B; month = hrmonth;
  grdatn = peeduca; spneth = PRDTHSP; numbaby = pesf1; yr_child1 = .;
  keep year age sex wgtfnl race birthlm birthly month grdatn spneth numbaby yr_child1;
run;
*************************************************************************************************;
*** This section obtains a data extract of the CPS for 2010;
***;
data edu10; 
  infile dat10 lrecl = 2300 missover; 
  length birthly 4 ; length month 3 ; length year 4 ; length grdatn 3 ; length spneth 3 ; length numbaby 3 ;
  length peage 3; length age 3;
  length pesex 3; length sex 3;
  length perace 3; length race 3;
  length birthlm 3; 
  input
  @16   hrmonth      2. 
  @122  peage        2. 
  @129  pesex        2. 
  @137  peeduca      2. 
  @139  perace       2. 
  @141  PRDTHSP      2. 
  @613  pwsswgt    10.4 
  @951  pesf1        2. 
  @953  pesf2a       2. 
  @955  pesf2b       4. ;

  year = 2010;
  age = peage; sex = pesex; wgtfnl = pwsswgt; race = perace; birthlm = PESF2A; birthly = PESF2B; month = hrmonth;
  grdatn = peeduca; spneth = PRDTHSP; numbaby = pesf1; yr_child1 = .;
  keep year age sex wgtfnl race birthlm birthly month grdatn spneth numbaby yr_child1;
run;
*************************************************************************************************;
*** This section obtains a data extract of the CPS for 2012;
***;
data edu12; 
  infile dat12 lrecl = 2300 missover; 
  length birthly 4 ; length month 3 ; length year 4 ; length grdatn 3 ; length spneth 3 ; length numbaby 3 ;
  length peage 3; length age 3;
  length pesex 3; length sex 3;
  length perace 3; length race 3;
  length birthlm 3; 
  input
  @16   hrmonth      2. 
  @122  peage        2. 
  @129  pesex        2. 
  @137  peeduca      2. 
  @139  perace       2. 
  @141  PRDTHSP      2. 
  @613  pwsswgt    10.4 
  @951  pesf1        2. 
  @953  ptsf2        4.; 

  year = 2012;
  age = peage; sex = pesex; wgtfnl = pwsswgt; race = perace; birthlm = .; birthly = .; month = hrmonth;
  grdatn = peeduca; spneth = PRDTHSP; numbaby = pesf1; yr_child1 = ptsf2; 
  keep year age sex wgtfnl race birthlm birthly month grdatn spneth numbaby yr_child1;
run;
*************************************************************************************************;
*** Stack CPS data for all years extracted  -- the "year" variable keeps track of year for each observation;
***;

data all0; 
  set edu0 edu06 edu08 edu10 edu12;
run;
*************************************************************************************************;
*** Drop males, young (age<14) and old (age>49) females, and obs with missing/negative weights;
*** Prepare fertile-aged female attribute variables -- age, race, education;
***;

data all1; 
  set all0;
  if sex=1 then delete;
  if age<14 or age>49 then delete;
  if wgtfnl<0 or wgtfnl = . then delete;
  if year< 2000 then birthly=birthly+1900;	* 2-digit year for birth year of last child in years before 2000;

  if race=1           then R = 1; 
  if race=2           then R = 2;
  if race=4 or race=5 then R = 3;
  if race=3 or race>5 then R = 5;
  if 1<=spneth<=5     then R = 4;

  if                grdatn<=34 then edu=1;
  if grdatn>=35 and grdatn<=38 then edu=2;
  if grdatn =39                then edu=3;
  if grdatn>=40 and grdatn<=42 then edu=4;
  if grdatn>=43                then edu=5;
run;
*******************************************************************************************************;
proc sort data=all1; 
  by year R age; 
run;
***************************************************************************************************;
*** Identify new mothers;
***;
data all2; 
  set all1; 
  by year R age;
 
  if ( (birthly=year   and birthlm<=month) or (birthly=year-1 and birthlm> month) ) and numbaby=1 
  then new_mom = 1; else new_mom=0;

  new_mom_wt = new_mom*wgtfnl;
  fem = 1;
  fem_wt = fem*wgtfnl;
run;
*******************************************************************************************************;
*** The macro calculates the frequence of new motherhood among females by age, race, and education;
***;
%macro datain(dtin,dtout,yr);
data dtin1; set &dtin;
if year=1900+&yr;

array p(5) p1-p5;
array f(5) f1-f5;

do i = 1 to 5;
  if edu = i then p(i) = new_mom_wt; else p(i)=0;
  if edu = i then f(i) =     fem_wt; else f(i)=0;
end;

proc sort data=dtin1; by R age;

proc means data=dtin1 noprint; 
  by R age; 
  var   p1-p5 new_mom_wt   f1-f5 fem_wt;
  output out=edusum sum=  psum1 psum2 psum3 psum4 psum5 ptot
                          fsum1 fsum2 fsum3 fsum4 fsum5 ftot;

data &dtout; set edusum;
if fsum1>0 then psum1 = (psum1/fsum1)*1000;
if fsum2>0 then psum2 = (psum2/fsum2)*1000;
if fsum3>0 then psum3 = (psum3/fsum3)*1000;
if fsum4>0 then psum4 = (psum4/fsum4)*1000;
if fsum5>0 then psum5 = (psum5/fsum5)*1000;
if ftot >0 then ferat = ( ptot/ ftot)*1000;

year = 1900+&yr;

keep year R age psum1-psum5 fsum1-fsum5 ferat;

proc datasets; delete dtin1 edusum;
run;
%mend datain;
*******************************************************************************************************;
*** Call the macro for each year;
*** And write output to files;
***;
%datain(all2,fert95,95);
%datain(all2,fert98,98);
%datain(all2,fert00,100);
%datain(all2,fert02,102);
%datain(all2,fert04,104);
%datain(all2,fert06,106);
%datain(all2,fert08,108);
%datain(all2,fert10,110);
%datain(all2,fert12,112);

data all3; set fert95 fert98 fert00 fert02 fert04 fert06 fert08 fert10 fert12;
  file f1 noprint notitle; put 							
  (year R age psum1-psum5)(3*f4.0 5*f14.7);

file f2 noprint notitle; put 							
  (year R age fsum1-fsum5)(3*f4.0 5*f16.7);
run;  
