
%% Waveforms from 8-electrodes...

figure(1)
% plot(???)
xlabel('Time x ElectrodeNumber'); ylabel('Voltage')

%% Principal Components Analysis

% [???]=pca(???);

% Plot first two PC scores
figure(2)
% plot(???)
xlabel('PC1'); ylabel('PC2')

% Reconstruction from first k PCs
% k=???;
m = mean(X');
Xhat = bsxfun(@plus,S(:,1:k)*C(:,1:k)',m)';

figure(3)
plot(1:size(X,1),X(:,1),1:size(X,1),Xhat(:,1))
xlabel('Time x ElectrodeNumber'); ylabel('Voltage')
legend({'Original','Reconstruction'})


% Variance Explained
figure(4)
% plot(???)
xlabel('PCs'); ylabel('Fraction of Variance Explained')

%% K-Means Clustering...

% k = ??;
% [???] = kmeans(???);

figure(5)
cmap = lines(k);
for i=1:k
%     plot(???,'.','Color',cmap(i,:));
    hold on
end
hold off
drawnow
xlabel('PC1'); ylabel('PC2')

%% Show Clusters from the Buzsaki Lab for Comparison...

figure(6)
idx = Clu;
k = max(Clu);
cmap = lines(k);
for i=1:k
%     plot(???,'.','Color',cmap(i,:));
    hold on
end
hold off
drawnow
xlabel('PC1'); ylabel('PC2')

%% Plot Waveforms for each Cluster...

figure(7)
clf
for i=1:k
    subplot(k/2,2,i)
    ridx = randperm(sum(idx==i));
    ids  = find(idx==i);
    ids = ids(ridx(1:min(100,sum(idx==i))));
    plot(X(:,ids),'Color',cmap(i,:));
    axis tight
    ylabel(['Cluster ' num2str(i)])
end