function g = contraharmonic_filter(image, wSize, Q)
% This function applies the contraharmonic mean filter to an image.
%
% wSize: the size of the window used to filter the image, must be odd
% Q: the order of the filter
%
% newImage is the filtered image
f = cast(image, 'double'); % casting the image to 'double'
[M, N] = size(f);      % reading the size of the image
g = f;                 % the new filtered image
% applying the contraharmonic filter
for x = ((wSize - 1)/2 + 1) : (M - (wSize - 1)/2 - 1)
    for y = ((wSize - 1)/2 + 1) : (N - (wSize - 1)/2 - 1)
        sum1 = 0;
        sum2 = 0;
        for s = (1- wSize)/2 : (wSize - 1)/2
            for t = (1- wSize)/2 : (wSize - 1)/2
                sum1 = sum1 + f(x+s, y+t) ^ (Q+1);
                sum2 = sum2 + f(x+s, y+t) ^ (Q  );
            end
        end
        g(x,y) = sum1 / sum2;
    end
end
g = cast(g, 'uint8');
