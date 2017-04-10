function [result] = xing_color_standardization(img)

    dimension=size(img); %dimension sizes
    
    rgbThreshold = [144, 123, 163]; %0-255
    
    result = zeros(dimension(1), dimension(2), dimension(3));
    
    for i=1:dimension(3)
        result(:,:,i) = thresholdMatrixWithValue(img(:,:,i), rgbThreshold(i));
    end
    imshow(result)
end