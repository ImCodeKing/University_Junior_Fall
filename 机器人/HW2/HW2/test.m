%% parameter setting of a rimless wheel
% 运行前请确定RLW的所有文件在当前运行的目录！！！
close all;  
clc;

num = 50;
figure;
data_cell = cell(1, num);
for spoke = 5:10
%spoke=5;
    x_data = [];
    y_data = [];

    % Specifies the number of spokes
    Nspk = spoke;       % number of the spoke(5~10)
    Nwt = 2;        % number of additional weight(2,4,6)
    
    % 基础的RimlessWheel的所有参数，
    par.M = 1.034;          % gram
    par.I = 0.0030452;      % meter.m^2  (inertia) （基础8辐的RimlessWheel）
    par.L = 0.11;           % meter （The length of the spoke）
    par.Phi = 2*pi/Nspk;    % radian (The Angle between the spokes)
    par.g = 9.8;            % meter/sec^2 (gravity acceleration)
    par.Gamma = 0;     % radian (angle of the slope)
    
    % 配重
    Wt.M = 0.18*Nwt;
    Wt.I = 0.00002503*Nwt;
    
    % 给基础RimlessWheel增加配重,得到最终的机器人
    par.M = par.M + Wt.M;
    par.I = par.I + Wt.I;

    for k = 1:(num*2)
        par.Gamma = par.Gamma - pi/num/10;
        %% find a fixed point
        close all;  
        clc;

        % Guess an initial state
        s0 = [ par.Phi/2-par.Gamma; -pi/1.25];    %[angle; angluar velocity]
        t0 = 0;

        % Options for fsolve
        options = optimset('TolFun',1e-12,'TolX',1e-12,'LargeScale','off','MaxFunEvals',20); 
    
        % find a fixed point
        s_fp = fsolve(@(s) Step(s,0,par)-s,s0,options);
    
        % Calculate Jacobian matrix numerically at s_fp
        J = zeros(2, 2);
        delta = 1e-12;
        for i = 1:2
            s_perturbed = s_fp;
            s_perturbed(i) = s_perturbed(i) + delta;
            f_perturbed = Step(s_perturbed, 0, par);
            J(:, i) = (f_perturbed - s_fp) / delta;
        end
        eigenvalues = eig(J);
        % Display the Jacobian matrix at s_fp
        disp(eigenvalues)
        if abs(eigenvalues(1)+eigenvalues(2)) < 1
            x_data = [x_data; par.Gamma];
            y_data = [y_data; eigenvalues(1)+eigenvalues(2)];
        end
    end
    data_cell{spoke-4} = [x_data, y_data];
    disp('#####################################################################################################')
end

% 绘制折线图
for spoke = 5:10
    data = data_cell{spoke - 4};
    x_data = data(:, 1);
    y_data = data(:, 2);
    plot(x_data, y_data);
    hold on;
end

title('eigenvalues of different gamma and spoke num');
xlabel('Gamma');
ylabel('Eigenvalues');
legend('Spoke 5', 'Spoke 6', 'Spoke 7', 'Spoke 8', 'Spoke 9', 'Spoke 10');
