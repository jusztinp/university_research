function []=own_main(img, model)
tic
%% Segmentation vol.1
%segm = own_segmentInHSV(img);
%% Segmentation vol.2
[red, blue, yellow] = own_segmentInHSV(img);
%[red, blue, yellow] = own_derivingColorConvert(img);

figure, imshow(img), hold on;

own_onChannel(red, img, model);
own_onChannel(blue, img, model);
%own_onChannel(yellow, img, model);

end


function [] = own_onChannel(segm, img, model)

segm( segm>0) = 255;
%%
resultbinary = im2bw(segm);
figure, imshow(resultbinary, []);
labeledImg = bwlabel(resultbinary);
numberOfLabels = size(unique(labeledImg))-1;


%%
dimensions = size(img);
constAspectRatio = 0.65;
constMaxHeight = dimensions(1) * .50;
constMinHeight = dimensions(1) * .05;

constMaxWidth = dimensions(2) * .5;
constMinWidth= dimensions(2) * .05;

%marking with bounding box
disp(numberOfLabels);
for i=1:numberOfLabels
	
    resultv = regionprops(labeledImg == i, 'BoundingBox');
    
	box = resultv.BoundingBox;
	width = box(3);
	height = box(4);
	aspectRatio = width/height;
	
	if 	aspectRatio > constAspectRatio && aspectRatio<(1/constAspectRatio) &&...
		width > constMinWidth && width < constMaxWidth &&...
		height > constMinHeight && height < constMaxHeight
		
	
		tempor=imcrop(img, box);	
        vector = own_getOwn(tempor,20);
	
        vectors = zeros(1, numel(vector));
        vectors(1,:) = vector;
        label = predict(model, vectors);
        
        disp(label);
        disp([box(1)*100/dimensions(2) box(2)*100/dimensions(1)]);
		rectangle('Position', box, 'EdgeColor','r','LineWidth',3);
		
	end
end
toc
end