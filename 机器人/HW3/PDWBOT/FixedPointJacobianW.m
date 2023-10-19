function J = FixedPointJacobianW(par,s0,n)
% J = FixedPointJacobian(par,s0) 
% This function perturbs states one-by-one, to compute the Jacobian around 
% the Fixed Point, a matrix representing the partial derivative of the
% Final condition with respect to the initial condition. The "partial 
% derivative" is computed as a series of finite differences. 
%
  s0 = reshape(s0,1,[]);  % standardize the input state to be a row vector
  delta = 1e-4;  % The perturbation on each state is very small. 
  ds = zeros(length(s0),length(s0)); % preallocate array
  
  for i=1:length(s0)  
    s = s0'; % Use the nominal state... 
    s(i) = s(i) + delta;  % ... with one perturbed state.
    [s_end, t_end, data] = Walk(s, 0, par, n);
    ds(:,i) = s_end - s0;
     % Return the difference between final condition after a step 
     % and the nominal fixed point. Store it in a column of the matrix.
  end 
  J = ds / delta;  
  % The Jacobian is just the full matrix, representing the partial derivative 
  % of the final state sF with respect to the initial state s0.