function [result] = own_getOwn(img, level)

redGreenBlueCode = [1 2 4];

result = [];

width = size(img,1);
height = size(img,2);

for part = 1:level
    
    lvlResult = [];
        visualize = zeros(width, height,3);
        for i = 1:part
            
            
            
            for j = 1:part
                
                wSize = width / part;
                hSize = height / part;
                
                x = ceil(((i - 1) * wSize + 1)) : floor(i * wSize);
                y = ceil(((j - 1) * hSize + 1)) : floor(j * hSize);
                
                imgWindow = img(x,y,:);
                
                RSum = sum(sum(imgWindow(:,:,1)));
                GSum = sum(sum(imgWindow(:,:,2)));
                BSum = sum(sum(imgWindow(:,:,3)));
                
                actualDominantChannels = [RSum GSum BSum] == max([RSum GSum BSum]);
                
                dominantChannelsCodeSum = uint8(redGreenBlueCode * actualDominantChannels');
                lvlResult = cat(2, lvlResult, dominantChannelsCodeSum);
                
                visualize(x,y,actualDominantChannels) = 255;
            end
         
        end
        imshow(visualize);
    
    %lvlResult = sort(lvlResult);
    result = cat(2,result, lvlResult);
end

end