function [red blue yellow] = own_segmentInHSV(img)

hsi = rgb2hsv(img);
figure, imshow(hsi), title('HSI');
red = zeros(size(img, 1), size(img, 2));
blue= zeros(size(img, 1), size(img, 2));
yellow = zeros(size(img, 1), size(img, 2));

red((hsi(:,:,1)<0.05555 | hsi(:,:,1)>0.75) & hsi(:,:,2)>0.5)=1;
%segm((hsi(:,:,1)<0.05555 | hsi(:,:,1)>0.9) & hsi(:,:,2)>0.5 & hsi(:,:,3)>0.12 & hsi(:,:,3)<0.8)=1;
%segm((hsi(:,:,1)<0.08333 | hsi(:,:,1)>0.91777) & hsi(:,:,2)>0.2)=1;
figure, imshow(red), title('RED SEGMENTED');

blue((hsi(:,:,1)>0.55 & hsi(:,:,1)<0.65) & (hsi(:,:,2)>0.4) & (hsi(:,:,3)>0.3))=1;
%segm((hsi(:,:,1)<0.05555 | hsi(:,:,1)>0.9) & hsi(:,:,2)>0.5 & hsi(:,:,3)>0.12 & hsi(:,:,3)<0.8)=1;
%segm((hsi(:,:,1)<0.08333 | hsi(:,:,1)>0.91777) & hsi(:,:,2)>0.2)=1;
figure, imshow(blue), title('BLUE SEGMENTED');

yellow((hsi(:,:,1)<0.05555 | hsi(:,:,1)>0.75) & hsi(:,:,2)>0.5)=1;
%segm((hsi(:,:,1)<0.05555 | hsi(:,:,1)>0.9) & hsi(:,:,2)>0.5 & hsi(:,:,3)>0.12 & hsi(:,:,3)<0.8)=1;
%segm((hsi(:,:,1)<0.08333 | hsi(:,:,1)>0.91777) & hsi(:,:,2)>0.2)=1;
figure, imshow(yellow), title('YELLOW SEGMENTED');


end