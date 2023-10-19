function newBot = AddWeight(oldBot, Weight)

newBot.L = oldBot.L;
newBot.R = oldBot.R;

newBot.m = oldBot.m + Weight.m;
newBot.B = (oldBot.m*oldBot.B + Weight.m*Weight.B)/newBot.m;
newBot.C = (oldBot.m*oldBot.C + Weight.m*Weight.C)/newBot.m;
newBot.I = oldBot.I + Weight.I + ...
    oldBot.m*((oldBot.B-newBot.B)^2 + (oldBot.C-newBot.C)^2)+ ...
    Weight.m*((Weight.C-newBot.C)^2 + (Weight.C-newBot.C)^2);

newBot.gamma = oldBot.gamma;
newBot.g = oldBot.g;
newBot.hF = oldBot.hF;

newBot.A = oldBot.A;
newBot.K = oldBot.K;
newBot.eB = oldBot.eB;
newBot.eC = oldBot.eC;
       
