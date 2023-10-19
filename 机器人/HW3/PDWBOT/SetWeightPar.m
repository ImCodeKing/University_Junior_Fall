function Weight = SetWeightPar(m,I,B,C)
%Set parameters of the add-on weight. m is the mass of the weight,
% I is the inertia. B and C is the add-on position respect to the 
% robot hip of each leg, where B's positive is forward and C's 
% positive is upright.
%
%See also: SetEnvironment.m, SetLegPar.m.

Weight.m = m;
Weight.I = I;
Weight.B = B;
Weight.C = C;