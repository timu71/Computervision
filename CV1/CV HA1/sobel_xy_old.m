function [Fx,Fy] = sobel_xy(Image)
% In dieser Funktion soll das Sobel-Filter implementiert werden, welches
% ein Graustufenbild einliest und den Bildgradienten in x- sowie in
% y-Richtung zur�ckgibt.
    image_replicate = padarray(Image,[1 1],'replicate');
    sobel_x = [1 0 -1 ; 2 0 -2 ; 1 0 -1];
    sobel_y = [1 2 1 ; 0 0 0; -1 -2 -1];
    image_replicate = im2double(image_replicate);
    Fx_pre = conv2(image_replicate,sobel_x,'same');
    Fy_pre = conv2(image_replicate,sobel_y,'same');
    size_Fx_prex = size(Fx_pre(1:end,1)); 
    size_Fx_prey = size(Fx_pre(1,1:end));
    size_Fy_prex = size(Fy_pre(1:end,1)); 
    size_Fy_prey = size(Fy_pre(1,1:end));
    disp('hallo')
    for a = 2:(size_Fx_prex(1)-1)
        for b = 2:(size_Fx_prey(2)-1)
            if Fx_pre(a,b) < 0.4
                Fx_pre(a,b) = 0;
            end
        end
    end
    for a = 2:(size_Fy_prex(1)-1)
        for b = 2:(size_Fy_prey(2)-1)
            if Fy_pre(a,b) < 0.4
                Fy_pre(a,b) = 0;
            end
        end
    end
    Fx = Fx_pre;
    Fy = Fy_pre;
   
end

