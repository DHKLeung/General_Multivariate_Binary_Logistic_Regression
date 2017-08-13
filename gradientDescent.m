function [theta, costHistory] = gradientDescent(X, y, theta, alpha, epoch)

%   Initialize values
m = length(y);
costHistory = zeros(epoch, 1);
temp = zeros(length(theta), 1);

%   Run Gradient Descent
for iter = 1:epoch
    for i = 1:length(theta)
        temp(i) = theta(i) - (alpha / m) * sum((sigmoid(X * theta) - y) .* X(:, i));
    end
    theta = temp;

    %   Save the cost in costHistory in every iteration
    costHistory(iter) = computeCost(X, y, theta);
end

end
