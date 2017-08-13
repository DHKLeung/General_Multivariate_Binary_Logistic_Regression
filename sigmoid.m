function g = sigmoid(z)

%   Initialize value
g = zeros(size(z));

%   Compute sigmoid
g = 1 ./ (1 + exp(-z));

end