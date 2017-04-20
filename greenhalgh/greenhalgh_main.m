function [features] = greenhalgh_main(img)

imshow(img);
%%
normalized = greenhalgh_normalize(img);
connectedComponents = greenhalgh_mser(normalized);

%%
tblBounds = regionprops('table',connectedComponents, 'BoundingBox');
strctAreaPerBoundsArea = regionprops(connectedComponents,'Extent');
strctPerimeter = regionprops(connectedComponents,'Perimeter');

areaPerBoundsArea = struct2array(strctAreaPerBoundsArea);
perimeter = struct2array(strctPerimeter);

constAspectRatio = 0.6;

constMaxHeight = 110;
constMinHeight = 14;

constMaxWidth = 100;
constMinWidth= 14;

constMaxAreaPerBoundsAreaRatio = 1;
constMinAreaPerBoundsAreaRatio = 0.4;

constMaxPerimeterRatio =  1.2;
constMinPerimeterRatio =  0.3;

bounds = table2array(tblBounds);
%%

for i=1:size(bounds,1)
    
    boundingBox = bounds(i,:);
    
    actualHeight = boundingBox(3);
    actualWidth = boundingBox(4);
    aspectRatio = actualHeight/actualWidth;
    
    actualAreaPerBoundsAreaRatio = areaPerBoundsArea(i);
    
    actualPerimeterRatio = perimeter(i) / (2*(actualHeight+actualWidth));
        
    %disp([actualAreaPerBoundsArea actualPerimeterRatio aspectRatio]);
    
    if aspectRatio > constAspectRatio && aspectRatio < (1/constAspectRatio) ...
        && actualHeight < constMaxHeight && actualHeight > constMinHeight ...
        && actualWidth < constMaxWidth && actualWidth > constMinWidth...
        && actualAreaPerBoundsAreaRatio < constMaxAreaPerBoundsAreaRatio...
        && actualAreaPerBoundsAreaRatio > constMinAreaPerBoundsAreaRatio...
        && actualPerimeterRatio < constMaxPerimeterRatio...
        && actualPerimeterRatio > constMinPerimeterRatio
    
        rectangle('Position', boundingBox, 'EdgeColor', 'r', 'LineWidth',2);
        tmp = imcrop(normalized, boundingBox);
        %get hog features
        [features, vis]= extractHOGFeatures(tmp, 'CellSize', [8 8], 'BlockSize', [4 4],'NumBins',9);
        figure, plot(vis);
        %TODO : get shape by shaperecognizer
        
        %TODO : get table by tablerecognizer
    end
    
end

end
