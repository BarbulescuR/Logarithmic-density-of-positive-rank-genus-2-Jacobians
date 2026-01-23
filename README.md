# Logarithmic Density of Rank ≥ 1 and Rank ≥ 2 Genus-2 Jacobians  
## Applications to Hyperelliptic Curve Cryptography

**Online supplement** of the article  
*“Logarithmic Density of Rank ≥ 1 and Rank ≥ 2 Genus-2 Jacobians and Applications to Hyperelliptic Curve Cryptography”*  

by R. Barbulescu, M. Barcau, V. Pașol, and G. Turcaș.

Description of the files:

   - utils.m ---> |a list of functions to compute the degree of a rational fraction 
                  |and the naive height of the largest coefficient
   
   - Stahlke16.m |
   - Stoll22.m   |
   - Dreier25.m  |
   - Elkies26.m  |                 
   - Elkies27.m  |---> |genus-2 curves with simple Jacobian which are defined over Q(t)
                       |and have rank >= 16, 22, 25, 26 and respectively 27
   
    - GlueFullTorsion.m --->  |a function which, given two elliptic curves F and G
                              |with full rational 2-tprsion over a field k, outputs
                              |a genus-2 curve C defined over k such that
                              |Jac(C)=_k E1 x E2
   
   - Elkies15.m ---> an elliptic curve over Q of rank 15 with full rational 2-torsion
   
   - Kihara6.m ---> an elliptic curve over Q(t) of rank 6 with full rational 2-torsion

   - HightRankSimpleJacobianExamples.m --->
                     |a list of examples of genus-2 curves from                                                |the literature and an evaluation of their naive height
    
   - HightRankSimpleJacobianExamples.m --->
                     |two examples of genus-2 curves with split Jacobian
                     |obtained by gluing from elliptic curves with full 2-torsion

   - RootNumber.m ---> computation of rank(Jac(x^5+a)) using Bisatt's closed formula

   - StollStats.m ---> Seatch of values of *a* such that *Ca: y^2=x^5+a* has high rank.

   - stoll.log ---> |list of integers a in [1,10^5] with >= 3 rational points of height
                    |less than 500 and root number opposed to the parity of the
                    |previously found points. Each line is of the form "a rank(Jac(Ca))"
   
   - stollhecke.gp ---> |written by Aurel Page, the script computes the L-function of
                        |Jac(y^2=x^5+a)
   
   - RootNumber.gp ---> timing of computing the L-function of a genus-2 curves

   - genus1rank2.dat | ---> |the LMFDB data to estimate the logarithmic density of 
   - genus2rank2.dat |      |rank 2 curves. Numerically, one sees that it is larger
                            |for genus-2 curves than for elliptic curves.
                            |This  corroborates with the fact that Watkins conjectured
                            | a logarithmic density of 3/4 for elliptic curves
                            | and we prove a log. density >= 5/7 for genus-2 curves.
