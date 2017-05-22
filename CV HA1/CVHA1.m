%  Gruppennummer:M29
%  Gruppenmitglieder: Timucin Aykut, Lukas Püttner, Salim Bassy , Serkan
%  Sevincli

%% Hausaufgabe 1
%  Einlesen und Konvertieren von Bildern sowie Bestimmung von 
%  Merkmalen mittels Harris-Detektor. 

%  F�r die letztendliche Abgabe bitte die Kommentare in den folgenden Zeilen
%  enfernen und sicherstellen, dass alle optionalen Parameter �ber den
%  entsprechenden Funktionsaufruf fun('var',value) modifiziert werden k�nnen.

%% festen wert bestimmen
   rng('default');
   rng(1);

%% Bild laden
    Image = imread('szene.jpg');
    IGray = rgb_to_gray(Image);

    [Fx,Fy] = sobel_xy(IGray); %sinnlos, da es nicht mehr verwendet wird?!
  
  %%figure, imshow(Fx);

%% Harris-Merkmale berechnen
    tic;
    Merkmale = harris_detektor(IGray,'do_plot',true,'segment_length', 3,'tau',0.1,'sigma',1,'k',0.05,'tile_size',[12 12],'min_dist',4);
    
    fprintf('Es wurden %d Merkmale detektiert!\n',size(Merkmale,1));
    toc;