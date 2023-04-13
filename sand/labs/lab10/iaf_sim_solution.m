
%% Simulate an integrate-and-fire neuron

% Parameters...
tau = 10;    % membrane time constant (ms)
R   = 10;    % membrane resistance (MOhms)
E_L = -65;    % resting potential for the leak (mV)
Vthresh= -50;   % spike threshold (mV)
Vreset = -65;   % reset potential (mV)

T = 5000; % simulation time (ms)

% a step current (nA)...
I = zeros(T,1);
I(200:4800) = 1.5001;
% rheobase=1.5

% mu = 1.2;
% st = 1;
% I = mu + st*randn(T,1);

V(1) = -64.9999;   % initial membrane potential (mV)
for t = 2:T       % ms timesteps
    % Integrate...
    V(t) = V(t-1) + (I(t)*R - (V(t-1)-E_L))/tau;
    
    % Fire...
    if V(t)>Vthresh
        V(t) = Vreset;
    end
end

figure(1); clf
subplot(3,1,1:2)
plot(V+(V==Vreset)*65)
box off; set(gca,'TickDir','out')
ylabel('Membrane Potential (mV)')
subplot(3,1,3)
plot(I)
box off; set(gca,'TickDir','out')
ylabel('Current (nA)')
xlabel('Time (ms)')

isis = diff(find(V==Vreset));
cv = std(isis)/mean(isis)

%%

% Parameters...
tau = 10;    % membrane time constant (ms)
R   = 10;    % membrane resistance (MOhms)
E_L = -65;    % resting potential for the leak (mV)
Vthresh= -50;   % spike threshold (mV)
Vreset = -65;   % reset potential (mV)

T = 1000; % simulation time (ms)

% a step current (nA)...
I = zeros(T,3);
I(200:800,:) = bsxfun(@times,ones(601,3),[1 1.25 1.53]);

V=zeros(size(I));
for i=1:size(I,2)
    V(1,i) = -64.99;   % initial membrane potential (mV)
    for t = 2:T       % ms timesteps
        % Integrate...
        V(t,i) = V(t-1,i) + (I(t,i)*R - (V(t-1,i)-E_L))/tau;
        
        % Fire...
        if V(t,i)>Vthresh
            V(t,i) = Vreset;
        end
    end
end

figure(1); clf
subplot(3,2,[1 3])
plot(V+(V==Vreset)*65)
box off; set(gca,'TickDir','out')
ylabel('Membrane Potential (mV)')
subplot(3,2,5)
plot(I)
box off; set(gca,'TickDir','out')
ylabel('Current (nA)')
xlabel('Time (ms)')

%
% a step current (nA)...
% I = zeros(T,1);
% I(200:800) = 1.51;
T=5000;
mu = 1;
st = 1;
I = mu + st*randn(T,1);
V=zeros(size(I));
V(1) = -64.5;   % initial membrane potential (mV)
for t = 2:T       % ms timesteps
    % Integrate...
    V(t) = V(t-1) + (I(t)*R - (V(t-1)-E_L))/tau;
    
    % Fire...
    if V(t)>Vthresh
        V(t) = Vreset;
    end
end

figure(1); 
subplot(3,2,[2 4])
plot(V+(V==Vreset)*65)
box off; set(gca,'TickDir','out')
ylabel('Membrane Potential (mV)')
subplot(3,2,6)
plot(I)
box off; set(gca,'TickDir','out')
ylabel('Current (nA)')
xlabel('Time (ms)')