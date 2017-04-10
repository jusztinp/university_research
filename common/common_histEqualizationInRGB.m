function [result]=common_histogramEqualizationInRGB(img)

result = zeros(size(img,1),size(img,2),size(img,3));

for i=1:3
   result(:,:,i)=histeq(img(:,:,i));
end

result = uint8(result);

end