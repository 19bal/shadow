close all;  clear all;  clc;

%%%%%%%%%%%%%%%% D O   N O T   E D I T   M E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LIB_PATH = sprintf('..%slib%s', filesep,filesep);                         %
addpath(LIB_PATH,'-end');                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dbg = true;

dbnm = pathos('_db/iskelet/');
dbnm_septs = pathos('_db/septs/');      mkdir(dbnm_septs);

DIR = dir(strcat(dbnm, '*.png'));
sz = length(DIR);

dip_initialise('silent');

for f = 1:sz,
    fprintf('kare %04d/%04d isleniyor ...\n', f, sz);

    imgnm = DIR(f).name;    
    bw = imread(strcat(dbnm, imgnm));
    
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
    
    % BUG FIX: her birisi icin ekstra kontrol yap
    % yakin/benzer degilse ele
    
    % egri uydur: body, shadow
    % iki egrinin kesim noktasi = ayrim noktasidir
    
    bws = ismember(L, [id_body id_shadow]);
    imwrite(bws, strcat(dbnm_septs, imgnm));
    sp = separation_point(bws, dbg);
    
    if dbg
        figure(1);
            subplot(121),   imshow(bw),        title('iskelet');
            subplot(122),   imshow(bws),        title('');
            hold on;
            plot(sp(1), sp(2), 'rs');
            hold off;
        drawnow;
    end     
end
