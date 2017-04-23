function [connectedComponents] = greenhalgh_mser(img, threshold)
%img : blue-red normalized img

thresholdDelta = ceil(255/threshold);


[regions, connectedComponents] = detectMSERFeatures(img,'ThresholdDelta',thresholdDelta);
figure; imshow(img); hold on;
    plot(regions, 'showPixelList', true, 'showEllipses', false);


end