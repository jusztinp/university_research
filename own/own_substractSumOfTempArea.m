function result = own_substractSumOfTempArea(img, temp)
% measuring the time of function
tic;

img=im2double(rgb2gray(img));
temp=im2double(rgb2gray(temp));

[rows, cols] = size(img);
[tempRows, tempCols] = size(temp);

difference = zeros(size(img));

minx= 1; miny = 1; minValue = Inf;

for x=1:rows-tempRows
    for y=1:cols-tempCols
        tempSizedPart = img(x:x + tempRows - 1, y:y + tempCols - 1);
        sumOfDifference = sum(sum(abs((tempSizedPart) - (temp))));
        difference(x, y) = sumOfDifference;
        if(sumOfDifference < minValue)
            minValue = sumOfDifference;
            minx = x;
            miny = y;
        end
    end
end
figure(2);

imshow(difference,[]); 

img=im2uint8(img);
%imshow(img((minx-(tempRows/2)):(minx+(tempRows/2)),(miny-(tempCols/2)):(miny+(tempCols/2))));

result = zeros([rows, cols, 3],'uint8');
result(:,:,1) = img;
result(:,:,2) = img;
result(:,:,3) = img;

result(minx, miny:miny + tempCols - 1, 1) = 255;
result(minx + tempRows - 1, miny:miny + tempCols - 1, 1) = 255;
result(minx:minx + tempRows - 1, miny, 1) = 255;
result(minx:minx + tempRows - 1, miny + tempCols - 1, 1) = 255;
figure(1);
imshow(result, []);



   result = [minx miny minValue toc];
end