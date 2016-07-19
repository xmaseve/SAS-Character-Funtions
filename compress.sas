data one;
input subj $ 1-3 weight: $8. height $12.;
datalines;
001 80kgs 5ft 3in
002 190lbs 6' 1"
003 70KG. 5ft 11in
004 177LbS. 5' 11"
005 100kgs 6ft
;
run;

data new;
	set one;
	weight_lbs = input(compress(weight,,'kd'),12.);
	if findc(weight,'k','i') then weight_lbs = weight_lbs*2.2;
	height = compress(height,,'kds');
	feet = input(scan(height,1,' '), 12.);
	inch = input(scan(height,2,' '), 12.);
	if missing(inch) then inch = 0;
	height_inch = 12 * feet + inch;
	drop weight height feet inch;
run;

proc print data=new;
run;

data new1;
	set one;
	weight_lbs = input(compress(weight,,'kd'),12.);
	if findc(weight,'k','i') then weight_lbs = weight_lbs*2.2;
	height = compress(height,,'kds');
	array nvar{2} feet inch;
	do i = 1 to 2;
		nvar{i} = input(scan(height,i,' '), 12.);
	end;
	if missing(inch) then inch = 0;
	height_inch = 12 * feet + inch;
	drop i weight height feet inch;
run;

proc print data=new1;
run;
