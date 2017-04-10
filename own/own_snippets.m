
%%Snippet
%%Segmenting red parts

dimension = size(img);

segmented = zeros(dimension(1), dimension(2));

segmented((img(:, :, 1) - img(:, :, 2) > 40) & (img(:, :, 1) - img(:, :, 3) > 40)) = 1;

se = strel('disk', 3);

closedAndSegmented = imclose(segmented,se);

imshow(closedAndSegmented)



%%searching circles on the image


[center, radius] = imfindcircles(img, [10 100]);

imshow(img); 
h = viscircles(center, radius);


%%picture of table

tableImage = imcrop(img, [(center(1) - radius) (center(2) - radius) (2 * radius) (2 * radius)]);
imshow(tableImage)



%%compute integral for a grayscale image
dimensions = size(img);
img_i = integralImage(rgb2gray(img));
img_i = img_i(2:dimensions(1) + 1, 2:dimensions(2) + 1);

%normalization

img_i=double(img_i) / max(img_i(:));