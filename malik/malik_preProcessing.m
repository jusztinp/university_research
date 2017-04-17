function [rSegmented] = malik_preProcessing(img)
%%Segments the red, green, blue and yellow components in HSV color space

hsi = rgb2hsv(img);
figure, imshow(hsi);
rSegmented = zeros(size(img, 1), size(img, 2));
%gSegmented = zeros(size(img, 1), size(img, 2));
%bSegmented = zeros(size(img, 1), size(img, 2));
%ySegmented = zeros(size(img, 1), size(img, 2));

rSegmented((hsi(:,:,1)<0.06 | hsi(:,:,1)>0.75) & hsi(:,:,2)>0.5 & hsi(:,:,3) > 0.2) =1;
rSegmented = filterAndBinarize(rSegmented);
se = strel('rectangle', [1 1]);
rSegmented = imdilate(rSegmented, se);
figure, imshow(rSegmented);
%gSegmented((hsi(:,:,1)>0.4 & hsi(:,:,1)<0.5)&(hsi(:,:,2)>0.7)&(hsi(:,:,3)>0.5)) = 1;
%gSegmented = filterAndBinarize(gSegmented);

%bSegmented((hsi(:,:,1)>0.33 & hsi(:,:,1)<0.6)&(hsi(:,:,2)>0.7)&(hsi(:,:,3)>0.3)) = 1;
%bSegmented = filterAndBinarize(bSegmented);

%ySegmented((hsi(:,:,1)>0.1 & hsi(:,:,1)<0.2)&(hsi(:,:,2)>0.9)&(hsi(:,:,3)>0.8)) = 1;
%ySegmented = filterAndBinarize(ySegmented);

end
%%
function [result] = filterAndBinarize(img)

result=imgaussfilt(img);
result = imbinarize(result);

end