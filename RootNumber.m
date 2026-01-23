// Journal de Théorie des Nombres de Bordeaux 34 (2022), 575–582 
// Root number of the Jacobian of y2 = x^p + a
// Matthuew Bisatt


// RootNumber of Jac(Hyp(x^p+a))
function RootNumber(a:p:=5)

	function W2(a)
	    a_ := Integers() ! (2^(-Valuation(a,2))*a);
            assert IsOdd(a_);
	    if a_ mod 4 eq 3 then
	        return LegendreSymbol(-1,p);
            elif IsEven(Valuation(a,2)) and not IsDivisibleBy(Valuation(4*a,2),p) then
	        return  LegendreSymbol(2,p);   
	    else
                return 1;
            end if;
	end function;



        Qx<x> := PolynomialRing(Rationals());
        g := x^p + a;
	Delta_g := Discriminant(g);

	function Wp(a)

	    a0 := Evaluate(g,0);
	    //print a0*(p-1)*Valuation(a0,p),Delta_g;
            if Valuation(a0,p) eq 0 then
                HilbSym := 1;
	    else
	        HilbSym := HilbertSymbol(a0*(p-1)*Valuation(a0,p),Delta_g,p);
	    end if;
            tmp := -LegendreSymbol(-2,p)*\
		  HilbSym*\
	          LegendreSymbol(-1,p)^((1+Valuation(Delta_g,p)) div 2);
            return tmp;
	end function;

        S1 := [ ell : ell in PrimeDivisors(a) | IsOdd(Valuation(a,ell)) and not ell in [2,p] ]; 
        S2 := [ ell : ell in PrimeDivisors(a) | IsEven(Valuation(a,ell)) and not ell in [2,p] and not IsDivisibleBy(Valuation(a,ell),p) ];

        if S1 ne [] then
	    prodS1 := &*[LegendreSymbol(-1,ell)^((p-1) div 2) : ell in S1];
	else
	    prodS1 := 1;
	end if;

        if S2 ne [] then
	    prodS2 := (&*[ LegendreSymbol(ell,p) : ell in S2]);
	else
	    prodS2 := 1;
	end if;


        W := W2(a)*Wp(a)*\
	     LegendreSymbol(-1,p)*\
	     prodS1*prodS2;

	return W;
end function;	


/*

load "RootNumber.m";
Qx<x> := PolynomialRing(Rationals());

[(-1)^#[g : g in Generators(MordellWeilGroup(Jacobian(HyperellipticCurve(x^5\
+a)))) | Order(g) eq 0] : a in [1..10]  ];
 
[RootNumber(a) : a in [1..10]  ];

 */
