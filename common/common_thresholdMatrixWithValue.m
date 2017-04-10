function [result] = common_thresholdMatrixWithValue(img, thresholdValue)

    dimensions = size(img);
    
    result=zeros(dimensions(1), dimensions(2));
    
    result(img(:,:)>thresholdValue)=255;
end