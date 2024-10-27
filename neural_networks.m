% Universal Function Approximation - Neural Networks
% Author: Lucas Casaril (eng@lucascasaril.me)

clear all
clc
close all

%% Creating the Inputs and Outputs

% Define the range
x = linspace(-2*pi, 2*pi, 100000);
actual_sine = sin(x);

% Input
P = x;

% Output;
T = actual_sine;

%% Creating the Neural Network
net = feedforwardnet(30); % 30 Hidden Layers
net = configure(net,P,T);

%% Dividing the Training Patters
net.divideFcn = 'dividerand';
net.divideParam.trainRatio = 1.00; 
net.divideParam.valRatio = 0.00;
net.divideParam.testRatio = 0.00;

%% Initializing the Neural Network
net = init(net);

%% Training
net.trainParam.showWindow = true;
net.layers{1}.dimensions = 30;          
net.layers{1}.transferFcn = 'tansig';   
net.layers{2}.transferFcn = 'purelin'; 
net.performFcn = 'mse';                
net.trainFcn = 'trainlm';              
net.trainParam.epochs = 1000;       
net.trainParam.time = 240;              
net.trainParam.lr = 0.1;           
net.trainParam.min_grad = 10^-18;       
net.trainParam.max_fail = 1000;

[net, tr] = train(net,P,T);

%% Plotting results
y_pred = net(x);

% Calculate error
error = abs(actual_sine - y_pred);
max_error = max(error);
mse = mean(error.^2);

figure;
subplot(2,1,1);
plot(x, actual_sine, 'b-', 'LineWidth', 2, 'DisplayName', 'Actual Sine');
hold on;
plot(x, y_pred, 'r--', 'LineWidth', 2, 'DisplayName', 'Neural Network');
grid on;
legend('Location', 'best');
title(sprintf('Neural Network Sine Approximation (30 hidden neurons)'));
xlabel('x');
ylabel('y');

subplot(2,1,2);
plot(x, error, 'g-', 'LineWidth', 2);
grid on;
title('Approximation Error');
xlabel('x');
ylabel('Absolute Error');

figure;
plot(x, actual_sine, 'b-', 'LineWidth', 2, 'DisplayName', 'Actual Sine');
hold on;
plot(x, y_pred, 'r--', 'LineWidth', 2, 'DisplayName', 'Neural Network');
legend('Location', 'best');
title(sprintf('Neural Network Sine Approximation (30 hidden neurons)'));
xlabel('x');
ylabel('y');

% Display error metrics
fprintf('Maximum absolute error: %e\n', max_error);
fprintf('Mean squared error: %e\n', mse);