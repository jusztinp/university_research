function [actualPart] = malik(img, doWithFigures)

results =  [];
[r] = malik_preProcessing(img);

dimensions = size(r);

labeledImg = bwlabel(r);

numberOfLabels = size(unique(labeledImg))-1;
if doWithFigures
    figure, imshow(img), hold on
end
constAspectRatio = 0.65;
constMaxHeight = dimensions(1) * .90;
constMinHeight = dimensions(1) * .03;

constMaxWidth = dimensions(2) * .90;
constMinWidth= dimensions(2) * .03;


    for i=1:numberOfLabels
        bounds = regionprops(labeledImg == i, 'BoundingBox');

        actualHeight = bounds.BoundingBox(3);
        actualWidth = bounds.BoundingBox(4);

        aspectRatio = actualHeight/actualWidth;
        
        if aspectRatio > constAspectRatio && aspectRatio < (1/constAspectRatio) ...
           && ~isempty(bounds) ...
           && actualHeight < constMaxHeight && actualHeight > constMinHeight ...
           && actualWidth < constMaxWidth && actualWidth > constMinWidth
       
            binaryImage = imcrop(r, bounds.BoundingBox);
            
            %[centers, radii] = imfindcircles(binaryImage, [actualWidth*2/3 actualWidth]);
            %[H, theta, rho] = hough(binaryImage);
            %P = houghpeaks(H, 5, 'threshold', ceil(0.3*max(H(:))));
            %lines = houghlines(binaryImage, theta, rho, P, 'FillGap,'5,'MinLength',7);
            
            if doWithFigures
                rectangle('Position', bounds.BoundingBox, 'EdgeColor','r','LineWidth',2); hold on  
            end
            
            actualPart = imresize(imcrop(r, bounds.BoundingBox), [128 128]);
            
            if doWithFigures
                figure, imshow(actualPart), hold on
            end
            
            points = detectSURFFeatures(actualPart);
            
        end
    end
    
    
end