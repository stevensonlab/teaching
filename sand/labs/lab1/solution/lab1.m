
% lab 1

neuron = 20;

figure(1); clf
subplot(3,1,1:2)
plotSpikeRaster(data(neuron).spks)
set(gca,'XTickLabel',[])
ylabel('Trial')
box off; set(gca,'TickDir','out')
tmp = strsplit(data(neuron).desc{1},' ');
title(tmp{2})

%
% plot the psth
figure(1)
subplot(3,1,3)
psth = getPSTH(data(neuron).spks,5);
psth_time = 0:5:2000;
bar(psth_time,psth,1,'EdgeColor','none')
xlim([0 2000])
box off; set(gca,'TickDir','out')
ylabel('Counts')
xlabel('Time [ms]')