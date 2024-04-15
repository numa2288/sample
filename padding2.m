function [padded_Array, My, Mx, Ny, Nx] = padding2(input, flag, parameter)
%paramter = [height, width]
[height, width] = size(input);

if flag == 0
    %padding
    Nx = max([height, width]);
    Ny = max([height, width]);
    signal_sq = double(zeros(Ny, Nx));
    paddingSize_sq1 = ceil(max(Nx - [width, height])/2);
    paddingSize_sq2 = floor(max(Nx - [width, height])/2);
    if height > width
        signal_sq(:, (paddingSize_sq1+1):(Nx-paddingSize_sq2)) = input;
    elseif(height < width)
        signal_sq((paddingSize_sq1+1):(Ny-paddingSize_sq2), :) = input;
    else            
        signal_sq = input;%もともとサイズが等しい
    end
    Mx = 2*Nx;
    My = 2*Ny;
    padded_Array = zeros(My, Mx);
    paddingSize1 = ceil(My/4);
    paddingSize2 = floor(My/4);
    padded_Array((paddingSize1+1):(My-paddingSize2), (paddingSize1+1):(Mx-paddingSize2)) = signal_sq;
else
    if nargin < 3
        disp("error!");
    end
    %inv padding
    height = parameter(1);
    width = parameter(2);
    Nx = max([height, width]);
    Ny = max([height, width]);
    Mx = 2*Nx;
    My = 2*Ny;
    paddingSize_sq1 = ceil(max(Nx - [width, height])/2);
    paddingSize_sq2 = floor(max(Nx - [width, height])/2);
    paddingSize1 = ceil(My/4);
    paddingSize2 = floor(My/4);
    %取り出し
    or_sq = input((paddingSize1+1):(My-paddingSize2), (paddingSize1+1):(Mx-paddingSize2));
    if height > width
        padded_Array = or_sq(:, (paddingSize_sq1+1):(Mx/2-paddingSize_sq2));
        clear o2_sq;
    elseif(height < width)
        padded_Array = or_sq((paddingSize_sq1+1):(My/2-paddingSize_sq2), :);
        clear o2_sq;
    else
        padded_Array = or_sq;%もともとサイズが等しい
        clear o2_sq;
    end
end

end