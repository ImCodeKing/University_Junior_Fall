%% parameter setting of a rimless wheel
% 运行前请确定RLW的所有文件在当前运行的目录！！！
close all;  
clc;
V = zeros(6,2);
% Specifies the number of spokes
for n = 1:6
    
Nspk = 4 + n;       % number of the spoke(5~10)
Nwt = 2 ;        % number of additional weight(2,4,6)

% 基础的RimlessWheel的所有参数，
par.M = 1.034;          % gram
par.I = 0.0030452;      % meter.m^2  (inertia) （基础8辐的RimlessWheel）
par.L = 0.11;           % meter （The length of the spoke）
par.Phi = 2*pi/Nspk;    % radian (The Angle between the spokes)
par.g = 9.8;            % meter/sec^2 (gravity acceleration)
n_gamma = 15;
par.Gamma = -n_gamma*pi/100;     % radian (angle of the slope)

% 配重
Wt.M = 0.18*Nwt;
Wt.I = 0.00002503*Nwt;

% 给基础RimlessWheel增加配重,得到最终的机器人
par.M = par.M + Wt.M;
par.I = par.I + Wt.I;

%% find a fixed point
close all;  
clc;

% Guess an initial state
s0 = [par.Phi/2 - par.Gamma; -pi/1.25];    % [angle; angluar velocity]
t0 = 0;

% Options for fsolve
options = optimset('TolFun', 1e-12, 'TolX', 1e-12, 'LargeScale', 'off', 'MaxFunEvals', 20); 

% Find a fixed point
s_fp = fsolve(@(s) Step(double(s), 0, par) - s, s0, options);

% Calculate Jacobian matrix numerically at s_fp
J = zeros(2, 2);
delta = 1e-8;
for i = 1:2
s_perturbed = s_fp;
s_perturbed(i) = s_perturbed(i) + delta;
f_perturbed = Step(s_perturbed, 0, par);
J(:, i) = (f_perturbed - s_fp) / delta;
end
eigenvalues = eig(J);
% Display the Jacobian matrix at s_fp
disp(eigenvalues)

% walk 5 steps with s_fp as the initial state
% data store all informations during the walking, in order to animate it later 
[s_end, t_end, fp_data] = Walk(s_fp, t0, par, 5);
max_w = min(0.0, max(fp_data.s(:, 2))); % 找到s(:, 2)的最大值
min_w = min(fp_data.s(:, 2)); % 找到s(:, 2)的最小值
V(n,  1) = min_w;
V(n,  2) = max_w;
end

% 绘制J的曲线
figure;
hold on; % 保持图形窗口中的现有图形
x = 5:10; % 横坐标范围
plot(x, V(:, 1)); % 绘制J(:, 1)的曲线
plot(x, V(:,  2)); % 绘制J(:, 2)的曲线

% 设置横坐标刻度为整数
xticks(x);
xticklabels(string(x));
scatter(x, V(:, 1), 'rx', 'LineWidth', 2); % 在 V(:, 1)的对应点上添加蓝色叉号
scatter(x, V(:, 2), 'rx', 'LineWidth', 2);
% 填充两条曲线之间的区域
fill([x fliplr(x)], [V(:, 1)' fliplr(V(:,  2)')], 'g', 'FaceAlpha', 0.4); % 使用绿色填充，设置透明度

hold off; % 取消保持图形窗口中的现有图形
title(sprintf('Range of Omega')); % 设置标题
xlabel('number of the spoke');
ylabel('angular velocity');
%legend('off'); % 去掉曲线的标签

legend(sprintf("Nwt = %d", Nwt), sprintf('gamma = %d*pi/100', n_gamma)); % 显示填充区域的标签为("Nwt = %d", Nwt)

pause(1000)
% animate the walking
Animation(fp_data, par, 2);
%% walking 20 steps with a specified inial state 
close all;
clc;

% Speicify an initial states
theta0 = par.Phi/2-par.Gamma;;
theta_d0 = -sqrt( 2*par.M*par.g*par.L*(1-cos(par.Phi/2+par.Gamma) )/(par.M*par.L^2+2*par.I) );

s0 = [theta0; theta_d0];
t0 = 0;

% Take 10 steps. 
[s_end, t_end, data] = Walk(s0, t0, par,20);
Animation(data, par, 2);
% 这个例子是一个初始速度过小，能量不足的情况，因此形成不了极限环。

%% walking 20 steps with another specified inial state
close all;
clc;

% Initial Conditions
s0 = [par.Phi/2-par.Gamma; -12*pi/8];
t0 = 0;

% Take 10 steps. 
[s_end, t_end, data] = Walk(s0, t0, par,20);
Animation(data, par, 2);
% 这个例子是初始速度较大，但最终能收敛到稳定极限环的情况。
% 对于8个辐的RimlessWheel，初速度是足够大的， 
% 但对于7个辐的RimlessWheel，初速度仍较小，仍需要加大。
