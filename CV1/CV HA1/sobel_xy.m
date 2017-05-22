function [Fx,Fy] = sobel_xy(Image)
% In dieser Funktion soll das Sobel-Filter implementiert werden, welches
% ein Graustufenbild einliest und den Bildgradienten in x- sowie in
% y-Richtung zur�ckgibt.
    sobel_x = [1 0 -1 ; 2 0 -2 ; 1 0 -1];
    sobel_y = [1 2 1 ; 0 0 0; -1 -2 -1];
    Fx = conv2(Image,sobel_x,'same');
    Fy = conv2(Image,sobel_y,'same');
   
end

