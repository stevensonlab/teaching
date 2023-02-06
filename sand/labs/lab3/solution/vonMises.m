
% Compute vonMises function for parameters b and direction x
%   for now... frequency is fixed at 2 cycles

function f = vonMises(b,x)

% von mises
f = exp(b(1)+b(2)*cos(2*(x-b(3))));