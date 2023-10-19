function Robot = SetLegPar(L,R,mL,I,B,C)
%Set parameters of the Leg. L is the fixed length of the leg.
% R is the radius of the foot, mL is the mass of each leg, I
% is the inertia of the leg. B and C is the position of the 
% COM of the leg respect to the hip, where B's positive is 
% forward and C's positive is upright.
%
%See also: SetEnvironment.m, SetWeightPar.m,

Robot.L = L+R-sqrt(R^2-30^2);   % mm
Robot.R = R;                    % mm

Robot.m = mL;                   % g
Robot.I = I;                    % g*mm^2

Robot.B = B;                    % mm
Robot.C = C;                    % mm

Robot.gamma = 0.025;            % Slope of ground (radian)
Robot.g = 9806;                 % mm/sec^2

Robot.A = 50;                   % mm    
Robot.eB = B;                   % mm 
Robot.eC = C;                   % mm
Robot.K = 0;                    % e-6N/m

Robot.hF = 0;                   % e-6Nm/rad
