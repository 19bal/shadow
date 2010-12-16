function iskelet_db(dnm_64x64, dbnm_iskelet, dbg)
% function iskelet_db(dnm_64x64, dbnm_iskelet, dbg)

iscreate_iskelet = length(dir(strcat(dbnm_iskelet, '*.png'))) < 1;

if ~iscreate_iskelet, return,   end

DIR = dir(strcat(dbnm_64x64, '*.png'));
sz = length(DIR);

dip_initialise('silent');

for f = 1:sz,
    fprintf('kare %04d/%04d isleniyor ...\n', f, sz);

    imgnm = DIR(f).name;    
    bw = imread(strcat(dbnm_64x64, imgnm));
    
    a = dip_image(bw);

    a = fillholes(a);
    a = bclosing(a,1,-1,1);
    a = fillholes(a);

    b = bskeleton(a,0,'natural');
    bws = logical(b);

    imwrite(bws, strcat(dbnm_iskelet, imgnm));
    
    if dbg
        figure(1);
            subplot(121),   imshow(bw),        title('64x64');
            subplot(122),   imshow(bws),        title('iskelet');
        drawnow;
    end    

end