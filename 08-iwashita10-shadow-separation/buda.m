function [bwr] = buda(bw, dbg)
% function [bwr] = buda(bw, dbg)

a = dip_image(bw);
a_lp = getlinkpixel(a);

bw_lp = boolean(a_lp);
L = bwlabel(bw_lp);
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

bwr = ismember(L, [id_body, id_shadow]);

if dbg
    figure(21)
    subplot(221),  imshow(bw),          title('bw')
    subplot(222),  imshow(bw_lp),       title('link pixel')
    
    bw_body   = ismember(L, id_body);
    bw_shadow = ismember(L, id_shadow);
    
    subplot(223),  imshow(bw_body),     title('body')
    subplot(224),  imshow(bw_shadow),   title('shadow')
end

