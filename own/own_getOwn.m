function [result] = own_getOwn(img, level)
tic
redGreenBlueCode = [1 2 4];

result = [];

width = size(img,1);
height = size(img,2);

while width < level && height < level 
    img = imresize(img, 2);
    width = size(img,1);
    height = size(img,2);
end

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
                
                %32 is the magic number, because it divides the 8bit int value
                %to 8 different part
                Rm = uint8(mean(mean(imgWindow(:,:,1)))/32);
                Gm = uint8(mean(mean(imgWindow(:,:,2)))/32);
                Bm = uint8(mean(mean(imgWindow(:,:,3)))/32);
                
                if Rm == Gm && Gm == Bm && Bm == Rm ...
                       && Rm < 2
                        actualDominantChannels = [ 0 0 0 ];
                else
                
                        actualDominantChannels = [Rm Gm Bm] == max([Rm Gm Bm]);
                
                end
                
                dominantChannelsCodeSum = uint8(redGreenBlueCode * actualDominantChannels');
                lvlResult = cat(2, lvlResult, dominantChannelsCodeSum);
                
                if sum(actualDominantChannels)>0
                    visualize(x,y,actualDominantChannels) = 255;
                end
            end
         
        end
        
        %figure, imshow(visualize);
    
    %lvlResult = sort(lvlResult);
    result = cat(2,result, lvlResult);
end
toc
end
