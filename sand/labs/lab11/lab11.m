%% Lab 11: Calcium imaging

load crcns_pvc7_small

% data contains two-photon imaging data from primary visual cortex
% https://crcns.org/data-sets/vc/pvc-7/about-pvc-7
% and is [pixels x pixels x frames]

%% Part 1: Visualizing image/video data

% show first frame and average over time
figure(1)
subplot(1,2,1)
imagesc(data(:,:,1))
axis equal off % force square pixels
% line(xlim(),???)
title('First Frame')
subplot(1,2,2)
% imagesc(???)
axis equal off % force square pixels
% line(xlim(),???)
title('Average')

% show pattern over time for a single row of pixels
figure(2)
% imagesc(???)
xlabel('Time')
ylabel('Pixels')

%% Generate a video of the data
figure(3)
cl = [min(data(:)) max(data(:))];
imagesc(data(:,:,1))
colormap gray; axis equal off
% for i=???
%     imagesc(???)
    set(gca,'CLim',cl); % note: imagesc changes the colorscale
    drawnow
end

%% Part 2: Estimating and correcting for motion artifacts

time1 = 1753;
time2 = 1754;

% raw data
frame1 = double(data(:,:,time1));
frame2 = double(data(:,:,time2));

% filter so that effect are easier to see
h = fspecial('gaussian',20,5);
frame1 = imfilter(frame1,h);
frame2 = imfilter(frame2,h);

% zoom window
box.x=double([85 115]);
box.y=double([210 240]);

figure(4)
subplot(2,4,1)
imagesc(frame1)
axis equal off
rectangle('Position',[box.x(1) box.y(1) box.x(2)-box.x(1) box.y(2)-box.y(1)])
subplot(2,4,2)
imagesc(frame2)
axis equal off
rectangle('Position',[box.x(1) box.y(1) box.x(2)-box.x(1) box.y(2)-box.y(1)])
subplot(2,4,3)
imagesc(frame1-frame2)
axis equal off
rectangle('Position',[box.x(1) box.y(1) box.x(2)-box.x(1) box.y(2)-box.y(1)])

subplot(2,4,5)
imagesc(frame1)
axis equal off
xlim(box.x); ylim(box.y)
subplot(2,4,6)
imagesc(frame2)
axis equal off
xlim(box.x); ylim(box.y)
subplot(2,4,7)
imagesc(frame1-frame2)
axis equal off
xlim(box.x); ylim(box.y)
cl = [min(frame1(:)-frame2(:)) max(frame1(:)-frame2(:))];

%% Alignment

% Option 1: find 2D cross-correlation
R = xcorr2(frame1-mean(frame1(:)),frame2-mean(frame2(:)));
[~,i]=max(R,[],'all');
[ypeak,xpeak] = ind2sub(size(R),i);
corr_offset = [(ypeak-size(frame2,1)) (xpeak-size(frame2,2))];

% Option 2: using matlab image processing toolbox
[optimizer, metric] = imregconfig('monomodal');
tform = imregtform(frame2, frame1, 'affine', optimizer, metric);
% frame2_registered = imwarp(???,???,'OutputView',imref2d(size(frame1)));

subplot(2,4,4)
imagesc(frame1-frame2_registered)
axis equal off
set(gca,'CLim',cl)
subplot(2,4,8)
imagesc(frame1-frame2_registered)
axis equal off
xlim(box.x); ylim(box.y)
set(gca,'CLim',cl)

%% Part 3: ROI extraction

data_subset = data(131:190,131:190,:); % good
X = double(reshape(data_subset,[],2000)');
X = X./mean(X,2);
[C,S]=pca(X);

%% Visualize the principal components and their timeseries
figure(5)
for i=1:4
    subplot(4,3,(i-1)*3+1)
%     imagesc(reshape(???,60,60))
    axis equal
    subplot(4,3,(i-1)*3+[2 3])
%     plot(???)
end

figure(6)
% scatter(???,???,5,1:size(X,1),'filled')
xlabel('PC1'); ylabel('PC2'); axis equal

%% Part 5: Deconvolution
% what happens when you change tau?
% note: this is GCaMP6s (https://blog.addgene.org/aav-encoded-calcium-sensors)
% try a different ROI (it may help to go to figure(1) and set "axis on")

% pick ROI center
locx=160;
locy=147;

% preprocess DF/F
y = squeeze(mean(mean(data((locx-5):(locx+5),(locy-5):(locy+5),:)),2));
y = y./squeeze(mean(mean(data),2));
% y = detrend(y);
y = (y-min(y))/(max(y)-min(y))+eps;

% initialize params
tau   = 10; % time constant for decay
V.dt  = 1/31;  % time step size
P.gam = 1-V.dt/tau; % C(t) = gam*C(t-1)
P.a   = 1;
P.b   = 0;
V.fast_iter_max = 10;
[n_best P_best V C]=fast_oopsi(y,V,P);

% visualize
t = [1:length(y)]'/31;

figure(7)
plot(t,y);
hold on
plot(t,C);
plot(t,n_best)
hold off