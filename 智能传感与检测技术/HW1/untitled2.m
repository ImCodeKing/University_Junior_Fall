a1 = [0.009; 0.074];
a2 = [0.050; 0.044];
a3 = [0.161; 0.170];
a4 = [0.123; 0.210];
a5 = [0.050; 0.183];
a = {a1, a2, a3, a4, a5};
%% 
maxS = -1;
for i = 1:4
    for j = i + 1:5
        Atemp = [a{i}, a{j}]
        S = svd(Atemp)
        sumS = S(1) + S(2);
        if sumS > maxS
            A = Atemp;
            Sm = S;
            maxS = sumS;
        end
    end
end
% A
% S
% maxS