function [result]=own_main(img, model)
%% Segmentation vol.1
%segm = own_segmentInHSV(img);
%% Segmentation vol.2
segm = own_derivingColorConvert(img);
segm( segm>0) = 255;
%%
resultbinary = im2bw(segm);
figure, imshow(resultbinary, []);
labeledImg = bwlabel(resultbinary);
numberOfLabels = size(unique(labeledImg))-1;

figure, imshow(img), hold on;

%%
dimensions = size(img);
constAspectRatio = 0.65;
constMaxHeight = dimensions(1) * .97;
constMinHeight = dimensions(1) * .08;

constMaxWidth = dimensions(2) * .97;
constMinWidth= dimensions(2) * .08;

%marking with bounding box
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
        vector = own_getOwn(tempor,15);
	
        vectors = zeros(1, numel(vector));
        vectors(1,:) = vector;
        label = predict(model, vectors);
        
        disp(label);
        disp([box(1)*100/dimensions(2) box(2)*100/dimensions(1)]);
		rectangle('Position', box, 'EdgeColor','r','LineWidth',2 );
		
	end
end


end