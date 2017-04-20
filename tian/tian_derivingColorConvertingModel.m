function [] = tian_derivingColorConvertingModel(img)

red = img(:,:,1);
green = img(:,:,2);
blue = img(:,:,3);

normalizedFactor = red + green + blue;

cr = max(0, ...
         min(((red - green)./normalizedFactor), ...
             ((red - blue)./normalizedFactor)));

cb = max(0, ...
         min(((blue - green)./normalizedFactor), ...
             ((blue - red)./normalizedFactor)));

cy = max(0, ...
         min(((red - blue)./normalizedFactor), ...
             ((green - blue)./normalizedFactor)));

cr = imgaussfilt(cr);
cb = imgaussfilt(cb);
cy = imgaussfilt(cy);         
         
figure; 
subplot(3,3,1), imshow(cr,[]), title('Red');
subplot(3,3,2), imshow(cb,[]), title('Blue');
subplot(3,3,3), imshow(cy,[]), title('Yellow');

[rmag, rdir] = imgradient(cr);
[bmag, bdir] = imgradient(cb);
[ymag, ydir] = imgradient(cy);

subplot(3,3,4), imshow(rdir,[]), title('RedGrad');
subplot(3,3,5), imshow(bdir,[]), title('BlueGrad');
subplot(3,3,6), imshow(ydir,[]), title('YellowGrad');


cre = tian_nonMaximaSuppression(cr, 1);
cbe = tian_nonMaximaSuppression(cb, 1);
cye = tian_nonMaximaSuppression(cy, 1);

subplot(3,3,7), imshow(1-cre,[]), title('RedNM');
subplot(3,3,8), imshow(1-cbe,[]), title('BlueNM');
subplot(3,3,9), imshow(1-cye,[]), title('YellowNM');


frd = frst2d(rdir,40,2,0.1,'bright');
frm = frst2d(rmag,40,2,0.1,'bright');
figure;
subplot(1,2,1), imshow(frd,[]);
subplot(1,2,2), imshow(frm,[]);

frd = frst2d(bdir,40,2,0.1,'bright');
frm = frst2d(bmag,40,2,0.1,'bright');
figure;
subplot(1,2,1), imshow(frd,[]);
subplot(1,2,2), imshow(frm,[]);

frd = frst2d(ydir,40,2,0.1,'bright');
frm = frst2d(ymag,40,2,0.1,'bright');
figure;
subplot(1,2,1), imshow(frd,[]);
subplot(1,2,2), imshow(frm,[]);


end