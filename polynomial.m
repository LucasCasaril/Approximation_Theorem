% Universal Function Approximation - Polynomal Functions
% Author: Lucas Casaril (eng@lucascasaril.me)

clear all
clc
close all

% Define the range
x = linspace(-2*pi, 2*pi, 100000);
actual_sine = sin(x);

% Parameters for Taylor series
n_terms = 11;  % Number of terms in the approximation

% Initialize approximation
approx_sine = zeros(size(x));

% Calculate Taylor series approximation
for n = 0:(n_terms-1)
    term = ((-1)^n .* x.^(2*n + 1)) / factorial(2*n + 1);
    approx_sine = approx_sine + term;
end

% Calculate error
error = abs(actual_sine - approx_sine);
max_error = max(error);

% Plotting
figure;
subplot(2,1,1);
plot(x, actual_sine, 'b-', 'LineWidth', 2, 'DisplayName', 'Actual Sine');
hold on;
plot(x, approx_sine, 'r--', 'LineWidth', 2, 'DisplayName', 'Approximation');
grid on;
legend('Location', 'best');
title(sprintf('Sine Function Approximation (%d terms)', n_terms));
xlabel('x');
ylabel('y');

subplot(2,1,2);
plot(x, error, 'g-', 'LineWidth', 2);
grid on;
title('Approximation Error');
xlabel('x');
ylabel('Absolute Error');

% Plotting
figure;
plot(x, actual_sine, 'b-', 'LineWidth', 2, 'DisplayName', 'Actual Sine');
hold on;
plot(x, approx_sine, 'r--', 'LineWidth', 2, 'DisplayName', 'Approximation');
legend('Location', 'best');
title(sprintf('Sine Function Approximation (%d terms)', n_terms));
xlabel('x');
ylabel('y');

% Display maximum error
fprintf('Maximum absolute error: %e\n', max_error);
