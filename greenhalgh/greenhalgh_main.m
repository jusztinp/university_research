function [features] = greenhalgh_main(img, model)

imshow(img);
%%
normalized = greenhalgh_normalize(img);
figure, imshow(normalized, []);

numberOfThresholds = 24;
connectedComponents = greenhalgh_mser(normalized, numberOfThresholds);

%%
tblBounds = regionprops('table',connectedComponents, 'BoundingBox');
for i=1:numel(tblBounds)
   tblBounds{i,1} = tblBounds{i,1} + [-1 -1 2 2]; 
end
strctAreaPerBoundsArea = regionprops(connectedComponents,'Extent');
strctPerimeter = regionprops(connectedComponents,'Perimeter');

areaPerBoundsArea = struct2array(strctAreaPerBoundsArea);
perimeter = struct2array(strctPerimeter);

constAspectRatio = 0.6;

constMaxHeight = 420;
constMinHeight = 24;

constMaxWidth = 400;
constMinWidth= 24;

constMaxAreaPerBoundsAreaRatio = 1;
constMinAreaPerBoundsAreaRatio = 0.4;

constMaxPerimeterRatio =  1.2;
constMinPerimeterRatio =  0.3;

bounds = table2array(tblBounds);
%%
disp(size(bounds,1));
for i=1:size(bounds,1)
    
    boundingBox = bounds(i,:);
    
    actualHeight = boundingBox(3);
    actualWidth = boundingBox(4);
    aspectRatio = actualHeight/actualWidth;
    
    actualAreaPerBoundsAreaRatio = areaPerBoundsArea(i);
    
    actualPerimeterRatio = perimeter(i) / (2*(actualHeight+actualWidth));
        
    %rectangle('Position', boundingBox, 'EdgeColor', 'b', 'LineWidth',2);
    
    if aspectRatio > constAspectRatio && aspectRatio < (1/constAspectRatio) ...
        && actualHeight < constMaxHeight && actualHeight > constMinHeight ...
        && actualWidth < constMaxWidth && actualWidth > constMinWidth...
        && actualAreaPerBoundsAreaRatio < constMaxAreaPerBoundsAreaRatio...
        && actualAreaPerBoundsAreaRatio > constMinAreaPerBoundsAreaRatio...
        && actualPerimeterRatio < constMaxPerimeterRatio...
        && actualPerimeterRatio > constMinPerimeterRatio
    
    disp([boundingBox(1:2) actualAreaPerBoundsAreaRatio actualPerimeterRatio aspectRatio]) ;
    
        %rectangle('Position', boundingBox, 'EdgeColor', 'r', 'LineWidth',4), hold on;
        tmp = imcrop(normalized, boundingBox);
        tmp = imresize(tmp,[128 128]);
        figure, imshow(tmp);
        
        %get hog features
        [features, vis]= extractHOGFeatures(tmp, 'CellSize', [8 8], 'BlockSize', [2 2],'NumBins',9);
        figure, plot(vis);
        
        label = predict(model, features);
        disp(label);
        %TODO : get shape by shaperecognizer
        
        %TODO : get table by tablerecognizer
    end
    
end

end
