clc
clear
close all

load('HW2P6.mat'); 
GT = readmatrix('HW2P6_GT.csv');

x_s1;   % 200x1
y_s1;   % 200x1
z_s1;   % 200x1
z_s2;   % 200x1

Y = [x_s1;y_s1;z_s1;z_s2];

% H matrix
H = [ ones(200,1),zeros(200,1),zeros(200,1);
      zeros(200,1),ones(200,1),zeros(200,1);
      zeros(200,1),zeros(200,1),ones(200,1);
      zeros(200,1),zeros(200,1),ones(200,1) ];

% H matrix
R = diag([0.5*ones(600,1);1*ones(200,1)]);  

% Batch LS estimate

tic
X_hat = inv((H' * inv(R) * H)) * (H' * inv(R) * Y);
time_batch = toc;

x_hat = X_hat(1);
y_hat = X_hat(2);
z_hat = X_hat(3);


disp(x_hat)
disp(y_hat)
disp(z_hat)


Cov_X_hat = inv(H' * inv(R) * H)

disp("time_batch = " + time_batch)

