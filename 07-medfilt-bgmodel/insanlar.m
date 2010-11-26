function bwr = insanlar(bw, dbg)
dip_initialise('silent');

bw = logical(bw);

a = dip_image(bw);
b = bskeleton(a,0,'natural');

bw2 = logical(b);
L = bwlabel(bw2,8);
Lv = L(:);

% L icerisindekileri frekansina gore sirala
sz = max(Lv);
for i=1:sz
    N(i) = length(find(Lv == i));
end

ind = 1:length(N);

if dbg
    figure(11), plot(ind, N, '*')
end

[v, iv] = sort(N, 'descend');

T = 10;
indk = iv(v > T);

% skeleton
bws = zeros(size(bw));
for i=1:length(indk),
    t = bw;
    k = indk(i);
    t(L ~= k) = 0;
    t(L == k) = 1;
    
    bws = bws + t;
end

% maske
a = dip_image(logical(bw));
b = dip_image(logical(bws));
c = bdilation(b, 8,-1,0);
bwr = logical(a * c);




