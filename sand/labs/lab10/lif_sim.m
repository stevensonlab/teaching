
%% Simulate an integrate-and-fire neuron

% Parameters...
% tau    = ???;    % membrane time constant (ms)
% R      = ???;    % membrane resistance (MOhms)
% E_L    = ???;    % resting potential for the leak (mV)
% Vthres = ???;   % spike threshold (mV)
% Vreset = ???;   % reset potential (mV)

% T = ???; % simulation time (ms)

% A step current (units of nA)...
% I = zeros(T,1);
% I(200:800) = ???;

% White noise current (units of nA)...
% mu = 1;
% st = 1;
% I = mu + st*randn(T,1);

V = zeros(size(I)); % pre-allocate for speed
% V(1) = ???;   % initial membrane potential (mV)
for t = 2:T  % ms timesteps
    % Integrate...
    V(t) = V(t-1) + (I(t)*R - (V(t-1)-E_L))/tau;
    
    % Fire...
    if V(t)>Vthres
        V(t) = Vreset;
    end
end

% Plot voltage and current
figure(1); clf
subplot(3,1,1:2)
plot(V+(V==Vreset)*65)
subplot(3,1,3)
plot(I)

% Compute coefficient of variation
% isis = ???;
% cv = ???