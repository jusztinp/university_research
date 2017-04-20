function [connectedComponents] = greenhalgh_mser(img)
%img : blue-red normalized img

threshold = 24;
thresholdDelta = ceil(255/threshold);


[regions, connectedComponents] = detectMSERFeatures(img,'ThresholdDelta',thresholdDelta);
figure; imshow(img); hold on;
    plot(regions, 'showPixelList', true, 'showEllipses', false);


end