/*
Purpose: optional search for examples related to Remark 2.2.
Paper location: optional/exploratory; not part of the default reproducibility workflow.
Usage: magma search-non-torsion.m
Output: prints a coefficient vector when it finds a suitable example.
Reference: T. G. Berry, On periodicity of continued fractions in hyperelliptic
function fields.
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

