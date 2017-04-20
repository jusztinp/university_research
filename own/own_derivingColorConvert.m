function [cr] = own_derivingColorConvert(img)

red = img(:,:,1);
green = img(:,:,2);
blue = img(:,:,3);

normalizedFactor = red + green + blue;

cr = max(0, ...
         min(((red - green)./normalizedFactor), ...
             ((red - blue)./normalizedFactor)));

cb = max(0, ...
         min(((blue - green)./normalizedFactor), ...
             ((blue - red)./normalizedFactor)));

cy = max(0, ...
         min(((red - blue)./normalizedFactor), ...
             ((green - blue)./normalizedFactor)));

cr = imgaussfilt(cr);
cb = imgaussfilt(cb);
cy = imgaussfilt(cy);      

end