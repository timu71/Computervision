function  Merkmale = harris_detektor(Image,varargin) 
    
%%  parser
    P = inputParser;


    
    P.addRequired('Image',@(x)isnumeric(x));

%% optional params:

%-segment_length
% default: square(3)
P.addOptional('segment_length',[3,3],@(x)isnumeric(x) && size(x,1)*size(x,2)==2 || isnumeric(x) && size(x,1)*size(x,2)==1);

%-sigma 
%default 1
P.addOptional('sigma',1,@(x)isnumeric(x));

% default = 0.05;
P.addOptional('k', 0.05, @(x) x>= 0.04  && x<= 0.06); 



%-threshold
% default = 0.2
P.addOptional('tau',0.2,@(x) x>0);

%-tile_size
% default [8,8]
P.addOptional('tile_size', [8 8], @(x)isnumeric(x)&& size(x,1)*size(x,2)==1 || isnumeric(x) && size(x,1)*size(x,2)==2);

%-N as number of features
% default 5
P.addOptional('N', 5, @(x) x > 0);

%-minimal distance between features
% default 4
P.addOptional('min_dist', 4, @(x) x > 0);

%-do_plot
P.addOptional('do_plot',true,@(x)islogical(x));

%read input parser
P.parse(Image,varargin{:});


Image = P.Results.Image;

%optional params
do_plot = P.Results.do_plot;

if size(P.Results.segment_length,1)*size(P.Results.segment_length,2) == 1
    segment_length = [P.Results.segment_length, P.Results.segment_length];
else
    segment_length = P.Results.segment_length;
end

sigma = P.Results.sigma;
tau = P.Results.tau;
k = P.Results.k;




N = P.Results.N;

min_dist = P.Results.min_dist;

%% 2.1



    [rows, columns, color] = size(Image);
  

    if (size(P.Results.tile_size,2) ~= 1)
        tile_size = [P.Results.tile_size(1) P.Results.tile_size(2)];
    else
        tile_size = [P.Results.tile_size P.Results.tile_size];
    end
    
    %rremain = mod(rows,tile_size);
    %cremain = mod(columns,tile_size);
    %merkmal_temp = cell(1,1,1);
   
    
    if (color == 1)
        % Create Gauss Filter
        %dimension = max(1,fix(6*sigma));
        [gx,gy]=meshgrid(round(-(segment_length(1)-1)/2):round((segment_length(1)-1)/2), round(-(segment_length(2)-1)/2):round((segment_length(2)-1)/2));
        
        gauss = exp(-gx.^2/(2*sigma^2)-gy.^2/(2*sigma^2));
        gauss = gauss./sum(gauss(:));

        % Sobelfilter Image
        [Fx,Fy] = sobel_xy(Image);

        % Filtering matrices with gauss
        Fxg = conv2(Fx.^2, gauss, 'same');
        Fyg = conv2(Fy.^2, gauss, 'same');
        Fxyg = conv2(Fx.*Fy, gauss, 'same');

        % Calculate Harris
        H =  (Fxg.*Fyg - Fxyg.^2)-k*(Fxg+Fyg).^2;
        
        % Pick values based on threshold
        H(H <= tau) = 0;
        
        H2 = padarray(H, [min_dist min_dist]);
        
        % Go through pic with stepsize tile_size
        for tile_y = 1+min_dist:tile_size(1):(size(Image,1)-min_dist)
            for tile_x = 1+min_dist:tile_size(2):(size(Image,2)-min_dist)
                M = 0;
                window = H2(tile_y:tile_y+tile_size(1)-1,tile_x:tile_x+tile_size(2)-1);
                while(M < N)
                    maxharris = max(max(window));
                    if (maxharris > 0)
                        [y,x] = find(window==maxharris);
                        H2(tile_y+y-min_dist-1:tile_y+y+min_dist-1, tile_x+x-min_dist-1:tile_x+x+min_dist-1) = 0;
                        H2(tile_y+y-1,tile_x+x-1) = -1;
                    end
                    M = M + 1;
                end
                
                backup = H2(tile_y:tile_y+tile_size(1)-1,tile_x:tile_x+tile_size(2)-1);
                backup(backup~=-1) = 0;
                H2(tile_y:tile_y+tile_size(1)-1,tile_x:tile_x+tile_size(2)-1) = backup;
            end
        end
        H2 = H2(1+min_dist:end-min_dist,1+min_dist:end-min_dist);
    
  
        [r,c] = find(H2==-1);
        [r2,c2] = find(H);
  
        
        % show result
        if (do_plot)
            figure, imagesc(Image), axis image, colormap(gray), hold on
            plot(c,r,'yx'), title('Harris');
            figure, imagesc(Image), axis image, colormap(gray), hold on
            plot(c2,r2,'rx'), title('Harris2');
        end

        Merkmale = [r,c];
    else
        disp('ERROR: Image is not greyscaled!');
    end
    
end