function [d,v] = Stability(par,s0)
% [d,v] = Stability(par,s0)
% Returns the Eigenvalues (d) and Eigenvectors (columns of v) associated
% with a fixed point (s0) for a given walker (par)
%

s = s0;     % fixed point state

Jfp = FixedPointJacobian(par,s); % compute the Numerical Jacobian for perturbations near this fixed point

[v,d] = eig(Jfp); % Compute eigenvalues (d) and eigenvectors (v) for the local Jacobian (Jfp)
% The eigenvectors (v) are "perturbation directions" that grow with a scalar
% multiplier during each step cycle.
% The scalar multiplier for each eigenvector is the associated eigenvalue
% (d). 

d = diag(d); % d is originally returned in a diagonal matrix; make it a simple list of eigenvalues. 

[dmag,ind] = sort(abs(d),'descend');  % Sort eigenvalues. 
d = d(ind);
% For stability, larger eigenvalues mean less asymptotic stability. Sort 
% them in descending order. 

v = v(:,ind);    % Sort the eigenvectors so they are in the same order. 

% Stability check: 
if max(abs(d))>1  % If any eigenvalue has magnitude greater than 1... 
    sprintf('UNSTABLE !!!')  % then the fixed point is unstable.
elseif max(abs(d))==1  % If the largest eigenvalue has magnitude 1...
    sprintf('MARGINALLY STABLE !')  % then the fixed point is neutrally stable.
else                   % Else, all the eigenvalues are less than one...
    sprintf('STABLE !!!')  % and the fixed point is locally, asymptotically stable. 
end



