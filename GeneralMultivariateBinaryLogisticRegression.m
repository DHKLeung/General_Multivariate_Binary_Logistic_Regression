%%  General Multivariate Binary Logistic Regression
%   Programed by Daniel H. Leung 13/08/2017 (DD/MM/YYYY)
%
%   Usage:
%       This code requires 2 csv file or file that content as if csv file.
%       One is training data and one is test data.
%       Default setting of training data filename and test data file name are 'train_data.csv' and 'test_data.csv' respectively. Can be altered in line 34 and 35.
%       Default setting of Learning Rate(alpha) and Epoch are 0.1 and 10000 respectively. Can be altered in line 51 and 52.
%       Example:
%           Student A: Chinese 100, English 100, Maths 60, Pass 1
%           Student B: Chinese 60, English 60, Maths 60, Pass 1
%           Student C: Chinese 100, English 0, Maths 0, Fail 0
%       Then the file should be written like this:
%           100,100,60,1
%           60,60,60,1
%           100,0,0,0
%       in this case the first three columns represent three features,
%       while the last column is the label.
%       There aren't limitations on the amount of feature. This code will
%       automatically deal with multivariate features.
%
%       Example "test_data.csv" and "train_data.csv" has been put on the GitHub repository.

%%  Initialization

clear;
close all;
clc;

fprintf('Initialized\n');

%%  Load Data

train_data_address = 'train_data.csv';
test_data_address = 'test_data.csv';
train_data = load(train_data_address);
X = [ones(length(train_data), 1), train_data(:, 1:(size(train_data, 2)) - 1)];
y = train_data(:, size(train_data, 2));

fprintf('Data loaded\n');

%%  Feature Scaling

[X, mu, stddev] = featureScaling(X);

fprintf('Feature scaled\n');

%%  Gradient Descent

%   Set learning rate(alpha) and epoch
alpha = 0.1;
epoch = 10000;

%   Initialize theta and Run Gradient Descent
theta = zeros(size(X, 2), 1);
[theta, costHistory] = gradientDescent(X, y, theta, alpha, epoch);

fprintf('Computed Gradient Descent\n');

%%  Plot graphs, hypothesis and display Theta

%   Plot graph Cost - Num of Iterations
figure('Name', 'Cost - Num of Iterations');
plot(1:numel(costHistory), costHistory, '-b', 'LineWidth', 2);
xlabel('Num of Iterations');
ylabel('Cost');

%   Plot all graph Prediction & Label y - Feature x
featureNum = 0;
for i = 2:size(X, 2)
    featureNum = i - 1;
    figure('Name', strcat('Prediction & Label y - Feature x', int2str(featureNum)));
    plot(X(:, i), y, 'rx', 'MarkerSize', 10);
    ylabel('Prediction & Label y');
    xlabel(strcat('Feature x', int2str(featureNum)));
    hold on;
    plot(X(:, i), sigmoid(X * theta), '-');
    legend('Training Data', 'Logistic Regression');
    hold off;
end

%   Display results
fprintf('Theta computed from Gradient Descent:\n\n');
fprintf('%f\n', theta);
fprintf('\n');

%%  Compare to testcase

%   Load test data
testcase = load(test_data_address);
X_Testcase = [ones(length(testcase), 1), testcase(:, 1:(size(testcase, 2) - 1))];
y_Testcase = testcase(:, size(testcase, 2));

%   Scale test data
for i = 2:size(X_Testcase, 2)
    X_Testcase(:, i) = (X_Testcase(:, i) - mu(i - 1)) / stddev(i - 1);
end

%   Compute the result
test_result = sigmoid(X_Testcase * theta);
test_result = test_result >= 0.5;
counter = 0;
for i = 1:length(test_result)
   if test_result(i) ~= y_Testcase(i)
       counter = counter + 1;
   end
end
fprintf('Tested by testcase:\n');
fprintf('Error percentage: %f%%\n', (counter / length(test_result)) * 100);
