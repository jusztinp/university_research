function [] = malik_main(img, classifier, doWithFigures)
%%
[red blue yellow] = malik_preProcessing(img);

if doWithFigures
    figure, imshow(img), hold on
end

malik_onChannel(img, red, classifier, doWithFigures);
malik_onChannel(img, blue, classifier, doWithFigures);
malik_onChannel(img, yellow, classifier, doWithFigures);
    
    
end

function [] = malik_onChannel(img, preprocessedImg, classifier, doWithFigures)

se = strel('rectangle', [1 1]);
dilatedImg = imdilate(preprocessedImg, se);
figure, imshow(dilatedImg), title('Dilated:');
%%
dimensions = size(dilatedImg);
labeledImg = bwlabel(dilatedImg);
numberOfLabels = size(unique(labeledImg))-1;

%%
constAspectRatio = 0.65;
constMaxHeight = dimensions(1) * .97;
constMinHeight = dimensions(1) * .03;

constMaxWidth = dimensions(2) * .97;
constMinWidth= dimensions(2) * .03;


    for i=1:numberOfLabels
        bounds = regionprops(labeledImg == i, 'BoundingBox');

        actualHeight = bounds.BoundingBox(3);
        actualWidth = bounds.BoundingBox(4);

        aspectRatio = actualHeight/actualWidth;
        %%
        if aspectRatio > constAspectRatio && aspectRatio < (1/constAspectRatio) ...
           && ~isempty(bounds) ...
           && actualHeight < constMaxHeight && actualHeight > constMinHeight ...
           && actualWidth < constMaxWidth && actualWidth > constMinWidth
       
            binaryImage = imcrop(preprocessedImg, bounds.BoundingBox);
            grayScaleImage = rgb2gray(imcrop(img, bounds.BoundingBox));
            %[centers, radii] = imfindcircles(binaryImage, [actualWidth*2/3 actualWidth]);
            %[H, theta, rho] = hough(binaryImage);
            %P = houghpeaks(H, 5, 'threshold', ceil(0.3*max(H(:))));
            %lines = houghlines(binaryImage, theta, rho, P, 'FillGap,'5,'MinLength',7);
            
            [labelIdx, scores] = predict(classifier, grayScaleImage);
            result = classifier.Labels(labelIdx)
            %%actualPart = imresize(imcrop(r, bounds.BoundingBox), [128 128]);
            
            %%if doWithFigures
              %  figure, imshow(actualPart), hold on
            %%end
            
            %%points = detectSURFFeatures(actualPart);
            
             if doWithFigures     
                rectangle('Position', bounds.BoundingBox, 'EdgeColor','r','LineWidth',2); hold on  
             end
        end      
    end
end