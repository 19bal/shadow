% function bwr = insanlar(bw, dbg)
dip_initialise('silent');

bw = logical(bw);

a = dip_image(bw);
b = bskeleton(a,0,'natural');

bw2 = logical(b);
L = bwlabel(bw2);

% L icerisindekileri frekansina gore sirala
Lv = L(:);
N = hist(Lv, max(Lv));
N = N(2:end);   % 0 arkaplanini cikart

if dbg
    figure(11), plot(N)
end

[lmv, ind] = lmax(N);
[v, ind] = sort(lmv, 'descend');

T = 5;
indk = ind(v > T) + 1;  % "0 arkaplanini cikart"tigimizdan "1" ekledik

bwr = zeros(size(bw));

for i=1:length(indk),
    t = bw;
    k = indk(i);
    t(L ~= k) = 0;
    t(L == k) = 1;
    
    bwr = bwr + t;
end

bwr = logical(bwr);
