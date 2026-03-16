clc
clear
close all

load('HW2P6.mat'); 
GT = readmatrix('HW2P6_GT.csv');


X_hat = [0; 0; 0.7];   % Initial conditions (given)
K = eye(3);            % initial covariance

H_k = [1 0 0;0 1 0;0 0 1; 0 0 1];

R = diag([0.5 0.5 0.5 1]);
R_inv = inv(R);

N = length(x_s1);

x_rls = zeros(N,1);
y_rls = zeros(N,1);
z_rls = zeros(N,1);

sigma_x = zeros(N,1);
sigma_y = zeros(N,1);
sigma_z = zeros(N,1);

tic
for k = 1:N
    
    Y_k = [x_s1(k);y_s1(k);z_s1(k);z_s2(k)];
    
    K = inv(inv(K) + H_k' * R_inv * H_k ); % Covariance update
    
    X_hat = X_hat + K * H_k' * R_inv *( Y_k - H_k * X_hat ); % Parameter update
    
    
    x_rls(k) = X_hat(1);
    y_rls(k) = X_hat(2);
    z_rls(k) = X_hat(3);

    sigma_x(k) = 3*sqrt(K(1,1));
    sigma_y(k) = 3*sqrt(K(2,2));
    sigma_z(k) = 3*sqrt(K(3,3));
    
end
time_rls = toc;

t = 1:N;

figure;

subplot(3,1,1)
plot(t,x_rls); hold on
plot(t,x_rls + sigma_x, 'r--')
plot(t,x_rls - sigma_x, 'r--')
title('x estimate with 3\sigma bounds')
hold off

subplot(3,1,2)
plot(t,y_rls,'b'); hold on
plot(t,y_rls + sigma_y,'r--')
plot(t,y_rls - sigma_y,'r--')
title('y estimate with 3\sigma bounds')
hold off

subplot(3,1,3)
plot(t,z_rls,'b'); hold on
plot(t,z_rls + sigma_z,'r--')
plot(t,z_rls - sigma_z,'r--')
title('z estimate with 3\sigma bounds')
hold off


disp("time_rls = " + time_rls)

%% RLS has shown Faster computation than the batch least squares for the given data set.
