function [result]=own_searchRoiInHSV(img)

hsi = rgb2hsv(img);
figure, imshow(hsi), title('HSI');
segm = zeros(size(img, 1), size(img, 2));

segm((hsi(:,:,1)<0.05555 | hsi(:,:,1)>0.75) & hsi(:,:,2)>0.68)=1;
%segm((hsi(:,:,1)<0.05555 | hsi(:,:,1)>0.9) & hsi(:,:,2)>0.1 & hsi(:,:,3)>0.12 & hsi(:,:,3)<0.8)=1;
%segm((hsi(:,:,1)<0.08333 | hsi(:,:,1)>0.91777) & hsi(:,:,2)>0.2)=1;
figure, imshow(segm), title('SEGMENTED');

dimensions = size(img);


resultbinary = im2bw(segm);
resultv = regionprops(resultbinary,'BoundingBox');
figure, imshow(img), hold on;


constAspectRatio = 0.65;
constMaxHeight = dimensions(1) * .97;
constMinHeight = dimensions(1) * .03;

constMaxWidth = dimensions(2) * .97;
constMinWidth= dimensions(2) * .03;

%marking with bounding box
for i=1:length(resultv)
	
	box = resultv(i).BoundingBox;
	width = box(3);
	height = box(4);
	aspectRatio = width/height;
	
	if 	aspectRatio > constAspectRatio && aspectRatio<(1/constAspectRatio) &&...
		width > constMinWidth && width < constMaxWidth &&...
		height > constMinHeight && height < constMaxHeight
		
		
	
		tempor=imcrop(img, box);
		%assignin('base',strcat('roihsioutput',num2str(i)),tempor);
		rectangle('Position', box, 'EdgeColor','r','LineWidth',2 );
		
	end
end


end