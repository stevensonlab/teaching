
function plotSpikeRaster(spikeList)

cmap = lines(1);
% plot spike raster...
for i=1:length(spikeList)
	plot(spikeList{i},i,'.','Color',cmap(1,:))
    hold on
end
hold off
