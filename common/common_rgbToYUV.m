function [YUV] = common_rgbToYUV(RGB)

R = RGB(:,:,1);
G = RGB(:,:,2);
B = RGB(:,:,3);
plot_flag=1;
%Conversion Formula
Y = 0.299   * R + 0.587   * G + 0.114 * B;
U =128 - 0.168736 * R - 0.331264 * G + 0.5 * B;
V =128 + 0.5 * R - 0.418688 * G - 0.081312 * B;

if (plot_flag==1)       %plot figures
    figure();
    subplot(1,3,1);imshow(Y);title('Y');
    subplot(1,3,2);imshow(U);title('U');
    subplot(1,3,3);imshow(V);title('V');
end

YUV=cat(3,Y,U,V);

end