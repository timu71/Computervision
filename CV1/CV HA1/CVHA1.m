%  Gruppennummer:
%  Gruppenmitglieder:

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
  
  [Fx,Fy] = sobel_xy(IGray);
  
  %%figure, imshow(Fx);

%% Harris-Merkmale berechnen
tic;
Merkmale = harris_detektor(IGray,'do_plot',true,'segment_length', [10 10],'tau',0.5,'sigma',4);
toc;
fprintf('Es wurden %d Merkmale detektiert!\n',size(Merkmale,1));
