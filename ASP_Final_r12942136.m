close all
clear
clc
%basic setup
load('ASP_Final_Data.mat')
load('ASP_Final_Answer.mat')
N = length(matX(:,1));
L = length(matX(1,:));
%% question 2,3 
theta_s_hat = noise_filter(theta_s_noisy, 0.02);
theta_i_hat = noise_filter(theta_i_noisy, 0.06);
t = 1 : length(theta_s_hat);

figure('Name','ASP_Final_DOA')
plot(t, theta_s_hat)
hold on
plot(t, theta_i_hat)
plot(t, theta_i)
plot(t, theta_s)
legend({'$\hat{\theta}_s(t)$', '$\hat{\theta}_i(t)$','$\theta_i$','\theta_s'},'Interpreter','latex')
xlabel('time index')
%%
% 
%   for x = 1:10
%       disp(x)
%   end
% 
ylabel('degree°')
title('ASP\_Final\_DOA')
grid on
%% LCMV
[s_t_LCMV, w_LCMV] = LCMV(matX, theta_s_hat, theta_i_hat);
figure('Name','LCMV')
subplot(2, 1, 1)
plot(t, real(s_t_LCMV))
title('$\Re[{\hat{s}_{LCMV}(t)}]$','Interpreter','latex')
xlabel('time index')    
ylabel('Amp')
grid on

subplot(2,1,2)
plot(t, imag(s_t_LCMV));
title('$\Im[{\hat{s}_{LCMV}(t)}]$','Interpreter','latex')
xlabel('time index')
ylabel('Amp')
grid on
%% uniform beamforming
[s_t_uni, w_uni] = Uniform(matX, theta_s_hat);
figure('Name','Uniform')
subplot(2, 1, 1)
plot(t, real(s_t_uni))
title('$\Re[{\hat{s}_{Uniform}(t)}]$','Interpreter','latex')
xlabel('time index')
ylabel('Amp')
grid on

subplot(2,1,2)
plot(t, imag(s_t_uni));
title('$\Im[{\hat{s}_{Uniform}(t)}]$','Interpreter','latex')
xlabel('time index')
ylabel('Amp')
grid on
%% MVDR
[s_t_MVDR, w_MVDR] = MVDR(matX, theta_s_hat);
figure('Name','MVDR')
subplot(2, 1, 1)
plot(t, real(s_t_MVDR))
title('$\Re[{\hat{s}_{MVDR}(t)}]$','Interpreter','latex')
xlabel('time index')    
ylabel('Amp')
grid on

subplot(2,1,2)
plot(t, imag(s_t_MVDR));
title('$\Im[{\hat{s}_{MVDR}(t)}]$','Interpreter','latex')
xlabel('time index')
ylabel('Amp')
grid on
%% comparision
figure('Name','Comparison')
subplot(2,1,1)
plot(t,real(s_t_uni))
hold on
plot(t, real(s_t_LCMV))
plot(t, real(s_t_MVDR))
hold off
legend({'$\Re[{\hat{s}_{Uniform}(t)}]$', '$\Re[{\hat{s}_{LCMV}(t)}]$', '$\Re[{\hat{s}_{MVDR}(t)}]$'},'Interpreter','latex')
title('Comparsion of real part')

subplot(2,1,2)
plot(t,imag(s_t_uni))
hold on
plot(t, imag(s_t_LCMV))
plot(t, imag(s_t_MVDR))
hold off
legend({'$\Im[{\hat{s}_{Uniform}(t)}]$', '$\Im[{\hat{s}_{LCMV}(t)}]$', '$\Re[{\hat{s}_{MVDR}(t)}]$'},'Interpreter','latex')
title('Comparsion of imaginary part')
%% modify
lamda = 0.8;
[s_t_hat, w_hat] = mybeam(matX,theta_s_hat, theta_i_hat, lamda);

figure('Name','ASP_Final_Source')
subplot(2, 1, 1)
plot(t, real(s_t_hat))
title('$\Re[{\hat{s}(t)}]$','Interpreter','latex')
xlabel('time index')    
ylabel('Amp')
grid on

subplot(2,1,2)
plot(t, imag(s_t_hat));
title('$\Im[{\hat{s}(t)}]$','Interpreter','latex')
xlabel('time index')
ylabel('Amp')
grid on