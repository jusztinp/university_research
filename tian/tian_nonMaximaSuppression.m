function [result] = tian_nonMaximaSuppression(img, radius)

maskSize = 2*radius+1;
mx = ordfilt2(img, maskSize^2, ones(maskSize));
result = (img == mx); % & (img>threshold); %with threshold

end