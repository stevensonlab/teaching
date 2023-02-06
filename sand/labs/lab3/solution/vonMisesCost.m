
% Compute sum-squared-error for a von Mises curve
%  given parameters b
%        data-directions   x [n x 1]
%        data-responses    y [n x 1]

function f = vonMisesCost(b,x,y)

y_predicted = vonMises(b,x);    % get prediction
f = sum((y-y_predicted).^2);    % return the sum-squared-error
