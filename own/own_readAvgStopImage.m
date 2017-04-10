function [img] = own_readAvgStopImage()


files = dir('stop/stopt*.*');

disp(length(files));
img = zeros(50, 50, 3);


for i=1:length(files)
    temps = imread(strcat('stop/',files(i).name));
    temps = imresize(temps, [50 50]);
    
    img = img + double(temps);
    clear temps
end
img = img / length(files);
img = uint8(img);

end

