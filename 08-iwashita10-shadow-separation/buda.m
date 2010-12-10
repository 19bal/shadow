function [bwb] = buda(bw, dbg)
% function [bwb] = buda(bw, dbg)

a = dip_image(bw);
b = getlinkpixel(a);

b = boolean(b);
L = bwlabel(b);
s = regionprops(L, {'orientation', 'area'});
areas = cat(1, s.Area);
orients = cat(1, s.Orientation);

% body: orientation ~ 90 derece
id_body = find((90 - abs(orients)) < 10)';

% shadow
% idx'deki id_body haricindekilerin
ti = 1:max(L(:));
ti(id_body) = [];                   % id_body lari uzaklastir

sp_areas = areas(ti);               % sp: shadow potential
sp_orients = orients(ti);

[t, idx] = sort(sp_areas, 'descend');

t = sp_orients(idx(1));
idy = find(abs(sp_orients(idx) - t) < 10);

id_shadow = ti(idx(idy));

bwb = ismember(L, [id_body, id_shadow]);