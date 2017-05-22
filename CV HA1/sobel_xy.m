function [Fx,Fy] = sobel_xy(Image)
% In dieser Funktion soll das Sobel-Filter implementiert werden, welches
% ein Graustufenbild einliest und den Bildgradienten in x- sowie in
% y-Richtung zur�ckgibt.
    sobel_x = [1 0 -1 ; 2 0 -2 ; 1 0 -1];
    sobel_y = [1 2 1 ; 0 0 0; -1 -2 -1];
    image_rep = padarray(Image, [1 1], 'replicate');
    Fx = conv2(image_rep,sobel_x,'same');
    Fy = conv2(image_rep,sobel_y,'same');
    Fx = Fx(2:end-1,2:end-1);
    Fy = Fy(2:end-1,2:end-1);
    
end

