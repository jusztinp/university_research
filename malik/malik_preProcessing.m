function [rSegmented bSegmented ySegmented] = malik_preProcessing(img)
%%Segments the red, green, blue and yellow components in HSV color space

hsi = rgb2hsv(img);
figure, imshow(hsi);
rSegmented = zeros(size(img, 1), size(img, 2));
bSegmented = zeros(size(img, 1), size(img, 2));
ySegmented = zeros(size(img, 1), size(img, 2));
    
rSegmented((hsi(:,:,1)<0.06 | hsi(:,:,1)>0.95) & hsi(:,:,2)>0.4 & hsi(:,:,3) > 0.2) =1;
rSegmented = filterAndBinarize(rSegmented);

%figure, imshow(rSegmented);

bSegmented((hsi(:,:,1)>0.33 & hsi(:,:,1)<0.6)&(hsi(:,:,2)>0.7)&(hsi(:,:,3)>0.3)) = 1;
bSegmented = filterAndBinarize(bSegmented);

ySegmented((hsi(:,:,1)>0.1 & hsi(:,:,1)<0.2)&(hsi(:,:,2)>0.9)&(hsi(:,:,3)>0.8)) = 1;
ySegmented = filterAndBinarize(ySegmented);

end
%%
function [result] = filterAndBinarize(img)

result=imgaussfilt(img);
result = imbinarize(result);

end