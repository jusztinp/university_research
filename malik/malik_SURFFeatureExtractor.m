function [features, featureMetrics, varargout] = malik_SURFFeatureExtractor(I)

[height,width,numChannels] = size(I);

%could use preprocessing here
if numChannels > 1
    grayImage = rgb2gray(I);
else
    grayImage = I;
end

surfFeatures = detectSURFFeatures(grayImage);
                    
features = extractFeatures(grayImage, surfFeatures,'Upright',true);

% Use the variance of the SURF features as the feature metric.
featureMetrics = var(features,[],2);

if nargout > 2
    % Return feature location information
    varargout{1} = multiscaleGridPoints.Location;
end
  