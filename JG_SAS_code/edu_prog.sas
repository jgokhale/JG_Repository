filename raw 'c:\cps\req\fertility\marmult.raw' ;
filename  f1 'c:\cps\req\fertility\edu_dist' ;
libname path 'c:\cps\req\fertility' ;
options nocenter nodate linesize=200 pagesize=200;
data edu0 ; infile raw dlm='"' ;

length recnum 8 ; length _year $ 5; length age 3; length _male 3; length _hhrel 3; length grdatn 3; length wgt 8;
length wgtfnl 8 ; length spneth 3; length race 3; 
input recnum / _year / age / _male / _hhrel / grdatn / wgt / wgtfnl / spneth / race;

  if _year='2001s' then _year='2001 ';
  
  if _year='1995 ' then year=1995; if _year='1996 ' then year=1996; if _year='1997 ' then year=1997;
  if _year='1998 ' then year=1998; if _year='1999 ' then year=1999; if _year='2000 ' then year=2000; 
  if _year='2001 ' then year=2001; if _year='2002 ' then year=2002; if _year='2003 ' then year=2003; 
  if _year='2004 ' then year=2004; if _year='2005 ' then year=2005; if _year='2006 ' then year=2006; 
  if _year='2007 ' then year=2007; if _year='2008 ' then year=2008; if _year='2009 ' then year=2009;
  if _year='2010 ' then year=2010; if _year='2011 ' then year=2011; if _year='2012 ' then year=2012;
  if _year='2013 ' then year=2013;

  wgt=wgt/100;
  if age<14 or age>49 then delete;
  if _male=1 then delete;
  if year<=2002 and (spneth = 1 or spneth = 2) then spneth = 3;  * Reclassify Hispanic origin according to... ;
  spneth = spneth - 2; 											 *...post 2002 coding from 1 through 5;

run;
*******************************************************************************************************;
data edu1; set edu0;
  if year=1995 and _race = 5 then _race = 6; 		* Push this "pther" race code beyond 5 to get it classified into R=5 below;
  if race=1           then R = 1; 
  if race=2           then R = 2;
  if race=4 or race=5 then R = 3;
  if race=3 or race>5 then R = 5;
  if 1<=spneth<=5     then R = 4;

  if                grdatn<=34 then edu=1;
  if grdatn>=35 and grdatn<=38 then edu=2;
  if grdatn=39                 then edu=3;
  if grdatn>=40 and grdatn<=42 then edu=4;
  if grdatn>=43                then edu=5;

  keep year R age edu wgt;
run;

proc sort data=edu1; by year R age; run;

*******************************************************************************************************;
proc tabulate data=edu1 formchar=' ' noseps out=edu2; by year R age;
 class edu;    								
 var wgt;                                         								
 table edu*wgt=' '*(reppctsum*f=f8.4); 		
run;

data edu2; 
  set edu2;
  array p(5) p1-p5;
  do i = 1 to 5;
    if edu = i then p(i) = wgt_pctsum_0; else p(i)=0;
  end;
run;

proc means data=edu2; 
  by year R age; 
  var p1-p5;
  output out=edusum sum=psum1-psum5;
run;

data edusum; 
  set edusum;
  file f1 noprint notitle; 
  put (year R age psum1-psum5)(3*f5.0 5*f11.5);
run;  

