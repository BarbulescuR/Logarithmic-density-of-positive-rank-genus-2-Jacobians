/*
Search examples for Remark 2.2.
*/

Qx<x> := PolynomialRing(Rationals());

for a in CartesianPower([0,2],7) do
    f := Qx ! [ ai : ai in a]; 
    if Degree(f) ne 6 then continue; end if; 
    found := true;
    for h_ in CartesianPower([0,1],4) do
        h := (Qx ! [hi : hi in h_]);
        g := f+(1/4)*h^2;
        if Discriminant(g) eq 0 then continue; end if; 
	C := HyperellipticCurve([f,h]);
	J := Jacobian(C);
	bool,c := IsSquare(LeadingCoefficient(g));
	if not bool then continue; end if;
        pts := PointsAtInfinity(C);
	alpha := pts[1] - pts[2]; 
	if Order(alpha) ne 0 then found:=false; end if;
    end for;
    if found then
        print a;
    	break;
    end if;
end for;


