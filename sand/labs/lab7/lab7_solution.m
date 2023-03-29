
%% Waveforms from 8-electrodes...

figure(1)
plot(X(:,1:100:end))
xlabel('Time x ElectrodeNumber'); ylabel('Voltage')

%% Principal Components Analysis

[C,S,vexp]=pca(X');

% Plot first two PC scores
figure(2)
plot(S(:,1),S(:,2),'.')
xlabel('PC1'); ylabel('PC2')
axis equal

% Reconstruction from first k PCs
k=25;
m = mean(X');
Xhat = bsxfun(@plus,S(:,1:k)*C(:,1:k)',m)';

figure(3)
plot(1:size(X,1),X(:,1),1:size(X,1),Xhat(:,1))
xlabel('Time x ElectrodeNumber'); ylabel('Voltage')
legend({'Original','Reconstruction'})


% Variance Explained
figure(4)
plot(cumsum(vexp)/sum(vexp))
xlabel('PCs'); ylabel('Fraction of Variance Explained')

%% bonus plot
figure(10)
plot(1:256,C(:,1),1:256,C(:,2))

%% K-Means Clustering...

rng(1)
k = 20;
[idx,c,sumd] = kmeans(S(:,1:25),k);

figure(5)
cmap = lines(k);
for i=1:k
    plot(S(idx==i,1),S(idx==i,2),'.','Color',cmap(i,:));
    hold on
end
hold off
drawnow
xlabel('PC1'); ylabel('PC2')
box off; set(gca,'TickDir','out'); axis equal

%% Show Clusters from the Buzsaki Lab for Comparison...

figure(6)
idx = Clu;
k = max(Clu);
cmap = lines(k);
for i=1:k
    plot(S(idx==i,1),S(idx==i,2),'.','Color',cmap(i,:));
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

%% Bonus - evaluate sum squared distances for k-means with varying k
ssdk=[];
for k=1:20
    for rep=1:5
        [~,~,sumd] = kmeans(S(:,1:5),k);
        ssdk(k,rep)=sum(sumd);
    end
end
figure(8)
plot(ssdk)