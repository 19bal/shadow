function [R,G,B] = get_average_color(frm)
X = frm(:,:,1);     R = mean(X(:));
X = frm(:,:,2);     G = mean(X(:));
X = frm(:,:,3);     B = mean(X(:));
