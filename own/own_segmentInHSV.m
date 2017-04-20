function [segm] = own_segmentInHSV(img)

hsi = rgb2hsv(img);
figure, imshow(hsi), title('HSI');
segm = zeros(size(img, 1), size(img, 2));

segm((hsi(:,:,1)<0.05555 | hsi(:,:,1)>0.75) & hsi(:,:,2)>0.5)=1;
%segm((hsi(:,:,1)<0.05555 | hsi(:,:,1)>0.9) & hsi(:,:,2)>0.5 & hsi(:,:,3)>0.12 & hsi(:,:,3)<0.8)=1;
%segm((hsi(:,:,1)<0.08333 | hsi(:,:,1)>0.91777) & hsi(:,:,2)>0.2)=1;
figure, imshow(segm), title('SEGMENTED');


end