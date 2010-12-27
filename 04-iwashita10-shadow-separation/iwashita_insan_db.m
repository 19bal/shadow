function iwashita_insan_db(dbnm, dbnm_insan, dbg)
% function iwashita_insan_db(dbnm, dbnm_insan, dbg)
mkdir(dbnm_insan);

if length(dir(strcat(dbnm_insan, '*.png'))) > 1,  return,     end
    
DIR = dir(strcat(dbnm, '*.png'));
sz = length(DIR);

dip_initialise('silent');

for f = 1:140 %1:sz,
    fprintf('kare %04d/%04d isleniyor ...\n', f, sz);

    imgnm = DIR(f).name;    
    bw = imread(strcat(dbnm, imgnm));
    
    % ele
    bw2 = bwareaopen(bw, 35);
    
    % onisle
    a = dip_image(bw2);
    a_f = fillholes(a);
    a_fc = bclosing(a_f,1,-1,1);
    a_fcf = fillholes(a_fc);
    b = brmedgeobjs(a_fcf, 1);
    bw3 = logical(b);
    
    % sec
    L = bwlabel(bw3);
    s = regionprops(L, {'area', 'centroid'});
    areas = cat(1, s.Area);
    cents = cat(1, s.Centroid);

    [y, si] = sort(areas, 'descend');

    si = si(1:2);                   % FIXME: iki insan var!
    [y, ci] = min(cents(si, 1));    % en soldaki (min(x))

    ti = si(ci);
    bwm = ismember(L, ti);
    
    % maske altindan bak
    bwt = bw & bwm;

    imwrite(bwt, strcat(dbnm_insan, imgnm));
    if dbg
        figure(111);  imshow(bw);
        drawnow;
    end     
 
end

