function [results] = malik(img)

results =  [];
[r g b y] = malik_preProcessing(img);

dimensions = size(r);
r=imgaussfilt(r);
logicalImg = logical(mod(r,2));

labeledImg = bwlabel(logicalImg);

numberOfLabels = size(unique(labeledImg))-1;

figure, imshow(img), hold on

constAspectRatio = 0.65;
constMaxHeight = dimensions(1) * .90;
constMinHeight = dimensions(1) * .05;

constMaxWidth = dimensions(2) * .90;
constMinWidth= dimensions(2) * .05;

    for i=1:numberOfLabels
        bounds = regionprops(labeledImg == i, 'BoundingBox');

        actualHeight = bounds.BoundingBox(3);
        actualWidth = bounds.BoundingBox(4);

        aspectRatio = actualHeight/actualWidth;
        
        if aspectRatio > constAspectRatio && aspectRatio < (1/constAspectRatio) ...
           && ~isempty(bounds) ...
           && actualHeight < constMaxHeight && actualHeight > constMinHeight ...
           && actualWidth < constMaxWidth && actualWidth > constMinWidth
       
            rectangle('Position', bounds.BoundingBox, 'EdgeColor','r','LineWidth',2);  
            results = cat(3, results ,bounds.BoundingBox);  
            actualPart = imresize(imcrop(r, bounds.BoundingBox), [128 128]);
            
            figure, imshow(actualPart), hold on
            points = detectSURFFeatures(actualPart);
            [features, valid_points] = extractFeatures(actualPart, points);
            plot(valid_points.selectStrongest(6), 'showOrientation', true);
        end
    end

end