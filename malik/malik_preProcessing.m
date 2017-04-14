function [rSegmented, gSegmented, bSegmented, ySegmented] = malik_preProcessing(img)
%%Segments the red, green, blue and yellow components in HSV color space

hsi = rgb2hsv(img);
figure, imshow(hsi), title('HSI');
rSegmented = zeros(size(img, 1), size(img, 2));
gSegmented = zeros(size(img, 1), size(img, 2));
bSegmented = zeros(size(img, 1), size(img, 2));
ySegmented = zeros(size(img, 1), size(img, 2));

rSegmented((hsi(:,:,1)<0.06 | hsi(:,:,1)>0.95) & hsi(:,:,2)>0.68 & hsi(:,:,3) > 0.2) =1;
subplot(2,2,1), imshow(rSegmented), title('RSegmented'); 

gSegmented((hsi(:,:,1)>0.4 & hsi(:,:,1)<0.5)&(hsi(:,:,2)>0.7)&(hsi(:,:,3)>0.5)) = 1;
subplot(2,2,2), imshow(gSegmented), title('GSegmented'); 

bSegmented((hsi(:,:,1)>0.33 & hsi(:,:,1)<0.6)&(hsi(:,:,2)>0.7)&(hsi(:,:,3)>0.3)) = 1;
subplot(2,2,3), imshow(bSegmented), title('BSegmented'); 

ySegmented((hsi(:,:,1)>0.1 & hsi(:,:,1)<0.2)&(hsi(:,:,2)>0.9)&(hsi(:,:,3)>0.8)) = 1;
subplot(2,2,4), imshow(ySegmented), title('YSegmented'); 
end