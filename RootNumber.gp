/*
Optional file.
Purpose: PARI/GP timing comparison for genus-2 L-function setup.
Paper location: optional comparison script; not part of the default reproducibility workflow.
Usage: gp -q RootNumber.gp
Output: prints the elapsed time for the loop.
Reference: B. Allombert, Defining L-functions in GP, 2018.
*/

t1=gettime();
for(i=1,1000,L = lfungenus2([x^5-(123456789012345678901+i),0]))
\\[r,R,w] = lfunrootres(L));
t2=gettime();
print(t2-t1);
quit
