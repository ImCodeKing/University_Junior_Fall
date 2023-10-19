% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Analysis the effect of additional weights.
%
% The total additional weights should not more than 10, That is to say
% you could you 0~10 weights to modofiy your robot in this exercise. 
%
% The aim of this exercise is learn the effect of Mass Distribution.
% You could compare the following models:
% 1st: one position with all weights, change C only . 
% 2nd: one position with 5 weights, and another position with 5 weights.
%      But the CoM of the 10 Weights is the same of 1st.  
% 
% You should compare the average step length, average velocity with
% respect to the weigthts' vertical coordinates C of 1st model. 
% And, try to find out the fast walking one with maximum 10 weights. 
% The initial part is given, you can complete it with your own code.
%
% NOTE: Each Team can submit the final version of your group by one person.
%
clc;            
close all;     
clear all;      

options = optimset('TolFun', 1e-12, ...
                   'TolX', 1e-12, ...
                   'LargeScale', 'off', ...
                   'MaxFunEvals', 100);                  

PDWBot = SetLegPar(180, 50, 210, 8.16e5, -2.3, -67);  
PDWBot = SetEnvironment(PDWBot, 0.025, 9806);     

%% your code here...
