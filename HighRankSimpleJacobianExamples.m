/*
Purpose: reproduce the high-rank simple genus-2 examples listed in Appendix A.1.
Usage: magma HighRankSimpleJacobianExamples.m
Optional variable: OUTPUT_FILE may be set by run_examples.py.
Output: a short table written to OUTPUT_FILE, defaulting to Families-list.log.
*/

load "utils.m";
if not assigned OUTPUT_FILE then
    OUTPUT_FILE := "Families-list.log";
end if;
gd := Open(OUTPUT_FILE, "w");

print "Running Appendix A.1 high-rank simple-Jacobian examples.";
print "Writing summary to", OUTPUT_FILE;

load "Stahlke16.m";
CurveToRankAndHeight("Stahlke 16",f,[],gd:Qs:=Qs);
load "Stoll22.m";
CurveToRankAndHeight("Stoll 22",f,[],gd:Qs:=Qs);
load "Dreier25.m";
CurveToRankAndHeight("Dreier 25",f,[],gd:Qs:=Qs);
load "Elkies26.m";
CurveToRankAndHeight("Elkies 26",f,[],gd:Qs:=Qs);
load "Elkies29gen2.m";
CurveToRankAndHeight("Elkies 2015 genus-2 example", f, xs, gd);
print "Finished Appendix A.1 examples.";
quit;
