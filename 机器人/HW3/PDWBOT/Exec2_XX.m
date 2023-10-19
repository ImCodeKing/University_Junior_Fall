% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Analysis the effect of Elastics
%
% The aim of this exercise is to learn the effect of Elastics.
% In this Exercise, you should find out a fast walking with the weights 
% and elastics. For simplisity, you can change C and K only . 
% 
% You could use the previouse exercise results, but you could not change
% the number of the additional weight.
%
% The initial part is given, you can complete it with your own code.
%
% NOTE: Each Team can submit the final version of your group by one person.
%
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%%
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
