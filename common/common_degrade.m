function [result] = common_degrade(img)

dimensions = size(img);

result = zeros(dimensions(1),dimensions(2),dimensions(3));

for x=1:dimensions(1)
    for y=1:dimensions(2)
        for z=1:dimensions(3)
            result(x,y,z) = floor(img(x,y,z)/25)*10;
        end
    end
end
result = uint8(result);

imshow(result, []);

end