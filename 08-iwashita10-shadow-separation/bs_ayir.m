function [bwb, bws] = bs_ayir(bw, dbg)
% function [bwb, bws] = bs_ayir(bw, dbg)

% body
[r, c] = find(bw);

[sr, si] = sort(r);
sc = c(si);

p = [sr sc];

fark = abs(p(1:end-1, :) - p(2:end, :));

fark2 = fark - repmat([1 0], length(fark), 1);
fark3 = fark2(:,1) + fark2(:,2);

id = find(fark3 == 0);

ri = r(si(id));
ci = c(si(id));

bwb = boolean(zeros(size(bw)));
sz = length(ri);
for i=1:sz
    bwb(ri(i), ci(i)) = true;
end

bwb = bwareaopen(bwb, 5);

% shadow
bws = boolean(bw - bwb);
bws = bwareaopen(bws, 5);

