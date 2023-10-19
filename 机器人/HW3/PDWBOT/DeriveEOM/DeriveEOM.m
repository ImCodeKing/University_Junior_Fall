% DeriveEOM  derives symbolically the equations motion.
%
%   See also: STEP, PRINTMATRIX, WALK, ANIMATION

% clear memory 
clear all;
clc;

% creation of symbolic variables
% leg parameters
syms  L     % leg length
syms  R     % foot radius
syms  B     % horizontal position of the CoM with respect to the hip
syms  C     % vertical position of the CoM with respect to the hip

% generalized coordinates and their derivatives
syms  phi_st  phi_st_d  % counter-clockwise rotation of the stance leg
syms  phi_sw  phi_sw_d  % counter-clockwise rotation of the swing leg 

q = [phi_st; phi_sw];
q_d = [phi_st_d; phi_sw_d];

% auxiliary relationship: position of hip joint
pos_h = [-R*phi_st - (L-R)*sin(phi_st)
         R         + (L-R)*cos(phi_st) ];

% expression of all model coordinates in terms of generalized coordinates
x_st = [ pos_h + RotationMatrix(phi_st)*[B; C]    % x and y position of CoM of the stance leg 
         phi_st                                   % angle of CoM of the stance leg 
         pos_h + RotationMatrix(phi_sw)*[B; C]    % x and y position of CoM of the swing leg 
         phi_sw  ];                               % angle of CoM of the swing leg    

% derivation of partial derivatives of x to q
J_st = simplify(jacobian(x_st,q));
     
% derivation of corriolis terms (second derivative of x)
D = simplify(jacobian(J_st*q_d,q)*q_d);

% print matrices so that the user can copy-paste them to Step.m
PrintMatrix(J_st,'J_st')
PrintMatrix(D,'D')

% for the impact equation we need also to express the model coordinates in
% terms of generalized coordinates with the assumption that the swing leg is
% in contact with the ground

% position of hip joint with repect to the swing leg
pos_h_sw = [-R*phi_sw - (L-R)*sin(phi_sw)
            R         + (L-R)*cos(phi_sw) ];

% expression of all model coordinates in terms of generalized coordinates
x_sw = [ pos_h_sw + RotationMatrix(phi_st)*[B; C]
         phi_st
         pos_h_sw + RotationMatrix(phi_sw)*[B; C]
         phi_sw ];

% derivation of partial derivatives of x to q
J_sw = simple(jacobian(x_sw,q));

% print matrix so that the user can copy-paste it to Step.m
PrintMatrix(J_sw,'J_sw')