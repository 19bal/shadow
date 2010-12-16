% function [bwb, bws] = bs_ayir(bw, dbg)
% function [bwb, bws] = bs_ayir(bw, dbg)

% body
[r, c] = find(bw);

[sr, si] = sort(r);
sc = c(si);

% x - eksenindeki degisim
tmp = sc - min(sc);
id = find(tmp < 2);
tmp(id) = 0;

% kirilma noktasi: body-shadow
% tmp in '0' dan farklandigi "ilk" yerdir
id = find(tmp);
id = id(1) - 1;

% koordinat karsiliklari
ky = sr(id);
kx = sc(id);

if dbg    
    figure(31),
    plot(tmp);
    hold on
    plot(id,tmp(id), 'r*')
    hold off
    title('x-yonundeki degisim')
    xlabel('id');   ylabel('degisim')
    grid on
end

return
p = [sr sc];

fark = abs(p(1:end-1, :) - p(2:end, :));

fark2 = fark - repmat([1 0], length(fark), 1);
fark3 = abs(fark2(:,1)) + abs(fark2(:,2));

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

if dbg
    figure(32)
    subplot(221),   imshow(bw), title('bw')
    subplot(222),   imshow(bw), title('')
    subplot(223),   imshow(bwb), title('bwb')
    subplot(224),   imshow(bws), title('bws')
end


