function []= own_showWithFraming(minx, miny, img, temp)
[rows, cols] = size(img);
[trows, tcols] = size(temp);
result = zeros([rows, cols, 3],'uint8');
result(:,:,1) = img;
result(:,:,2) = img;
result(:,:,3) = img;

result(minx, miny:miny + tcols - 1, 1) = 255;
result(minx + trows - 1, miny:miny + tcols - 1,1) = 255;
result(minx:minx + trows - 1, miny,1) = 255;
result(minx:minx + trows - 1, miny + tcols - 1, 1) = 255;
figure(1);
imshow(result, []);

end