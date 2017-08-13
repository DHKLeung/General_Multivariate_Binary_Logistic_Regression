function cost = computeCost(X, y, theta)

%   Initialize value
m = length(y);

%   Compute the cost
cost = (1 / m) * sum((-y .* log(sigmoid(X * theta))) - ((1 - y) .* log(1 - sigmoid(X * theta))));
