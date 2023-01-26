
%getPSTH.m
function psth = getPSTH(spikeList,binsize)

if nargin<2,
    binsize=5;
end
T = 2000;     % in ms

psth = zeros(T/binsize+1,1);
for trial=1:length(spikeList)
    time_index =1;
    for t=0:binsize:T
        psth(time_index) = psth(time_index) + ...
            sum(spikeList{trial}>t & spikeList{trial}<=(t+binsize));
        time_index = time_index+1;
    end
end

% psth = histogram(cell2mat(spikeList'),linspace(0,T,T/binsize));
