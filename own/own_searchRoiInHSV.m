function [result]=own_searchRoiInHSV(img)

%%Only works for circles

hsi = rgb2hsv(img);
figure, imshow(hsi), title('HSI');
segm = zeros(size(img, 1), size(img, 2));

segm((hsi(:,:,1)<0.05555 | hsi(:,:,1)>0.75) & hsi(:,:,2)>0.68)=1;
%segm((hsi(:,:,1)<0.05555 | hsi(:,:,1)>0.9) & hsi(:,:,2)>0.1 & hsi(:,:,3)>0.12 & hsi(:,:,3)<0.8)=1;
%segm((hsi(:,:,1)<0.08333 | hsi(:,:,1)>0.91777) & hsi(:,:,2)>0.2)=1;
figure, imshow(segm), title('SEGMENTED');

result = medfilt2(segm, [4 4]);
figure, imshow(result), title('MEDFILT');

result = imclose(result, strel('disk', 5));
figure, imshow(result), title('Close');

result = imfill(result, 'holes');
result = imclearborder(result, 4);
structuringElement = strel('diamond', 2);
result = imerode(result, structuringElement);
result = imerode(result, structuringElement);

figure, imshow(result), title('FILL-CLEARBORDER-ERODE-ERODE');


%searching circles on the image
[center, radi] = imfindcircles(result,[10 200]);
    
figure, imshow(img); h=viscircles(center,radi);

%searching connected-components
resultbinary = im2bw(result);
resultv = regionprresults(resultbinary,'BoundingBox'); % dont know what was this, maybe a function of mine 
figure, imshow(img), hold on


%marking with bounding box
for i=1:length(resultv)
   t = resultv(i).BoundingBox;
   disp(t);
   tempor=imcrresult(img, [t(1)-t(3)/10,...
	t(2)-t(4)/10,...
	t(3)+t(3)/10,...
	t(4)]+t(4)/10);
   assignin('base',strcat('roihsioutput',num2str(i)),tempor);
   rectangle('Position', [t(1),t(2),t(3),t(4)],...
  'EdgeColor','r','LineWidth',2 )
end
end