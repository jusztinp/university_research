function [normalized] = greenhalgh_normalize(img)

red =double( img(:,:,1));
green = double(img(:,:,2));
blue = double(img(:,:,3));

normalizedFactor = double(red + green + blue);

normalized = max ( red ./ normalizedFactor, blue ./ normalizedFactor);

end