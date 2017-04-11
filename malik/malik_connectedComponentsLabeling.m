function [result] = malik_connectedComponentsLabeling(img)
%%img has to be logical

logicalImg = logical(mod(img,2));

result = bwlabel(logicalImg);

end