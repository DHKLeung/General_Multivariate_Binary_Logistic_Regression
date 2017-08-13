function [X_norm, mu, stddev] = featureScaling(X)

%   Initialize the values that need to be return
X_norm = X;
mu = zeros(1, size(X, 2) - 1);
stddev = zeros(1, size(X, 2) - 1);

%   Compute the normalized X (won't normalized the intercept terms)
for i = 2:size(X, 2)
   mu(i - 1) = mean(X(:, i));
   stddev(i - 1) = std(X(:, i));
   X_norm(:, i) = (X_norm(:, i) - mu(i - 1)) / stddev(i - 1);
end

end
