% DeriveEOM  derives symbolically the equations motion 
% of a rimless wheel using matrix form.
%
% L is length of the spoke, M and I=M*Rgyr^2 are mass and inertia of the 
% RimlessWheel. Phi is the angle of the adjacent spokes. Gamma is angle of 
% the slope, and G is the gravity accleration. Theta is the angle of stance 
% spoke, which counter-clockwise rotate from the perpendicular of the slope.
% 
% See also: PRINTMATRIX

% Mingguo Zhao, May 2010
% Robotics&Control Lab, Dept. of Automation, Tsinghua University 


%% creation of symbolic variables
clear all

% wheel parameters
syms  L     % spoke length
syms  M     % mass of the wheel
syms  R     % radius of center mass for caculate the inertia
syms  Phi   % angle of adjacent spokes
syms  Gamma % angle of slope
syms  g     % gravity accleration

% generalized coordinates and their derivatives
syms  theta  theta_d  % counter-clockwise rotation of the stance spoke

%% EOM: equation of motion
clc

% position of the COM in 2D, where st denote it is base on the stance spoke.
Xst = [ L*sin(theta)            % x and y Position of CoM of the Wheel
           L*cos(theta)            
           theta            ];       % angle of the stance leg 

% derivation of partial derivatives of x to theta
Jst = simplify(jacobian(Xst,theta));

% derivation of corriolis terms (second derivative of x)
D = simplify(jacobian(Jst*theta_d,theta) * theta_d);

% derivation of the force by gravity, 
Fa = [  M*g*sin(Gamma)          % x is parallel/down to the slope 
         -M*g*cos(Gamma)          % y is perpendicular/upward to the slope 
          0                        ];       % no torqe to COM 
% mass matrix
Mb = [ M   0    0
        0    M    0
        0    0    M*R^2];

% EOM of Rimless Wheel
theta_d2 = simplify( (Jst.'*Mb*Jst) \ (Jst.'*(Fa-Mb*D)) );
PrintMatrix(theta_d2, 'Theta_d2');

% force
Fc = simplify(Mb*Jst*theta_d2 - Mb*D - Fa);
PrintMatrix(Fc, 'Fc');

%% EOI: equation of impact
% for the impact equation we need also to express the model coordinates in
% terms of generalized coordinates with the assumption that the next spoke is
% in contact with the ground

% position of hip joint with repect to the swing leg
Xsw = [ L*sin(theta + Phi)          % x and y Position of CoM of the Wheel
            L*cos(theta + Phi)         % with next spoke as orign
            theta                   ];      % angle of the rimless wheel

% derivation of partial derivatives of x to theta
Jsw = simplify(jacobian(Xsw,theta));

% Eoi Matrix
Ti = simplify( (Jsw.' * Mb * Jsw) \ (Jsw.' * Mb * Jst) );
PrintMatrix(Ti,'Ti');