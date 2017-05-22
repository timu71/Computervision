function [Gray_image] = rgb_to_gray(Image)
% Diese Funktion soll ein RGB-Bild in ein Graustufenbild umwandeln. Falls
% das Bild bereits in Graustufen vorliegt, soll es direkt zur�ckgegeben werden.
Image = im2double(Image);
    if ismatrix(Image)
        Gray_image = Image;
    else
        Gray_image = 0.299 * Image(1:end,1:end,1) + 0.587 * Image(1:end,1:end,2) + 0.114 * Image(1:end,1:end,3);
    end
end
