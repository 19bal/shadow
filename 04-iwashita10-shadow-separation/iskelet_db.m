function iskelet_db(dbnm_64x64, dbnm_iskelet, dbg)
% function iskelet_db(dbnm_64x64, dbnm_iskelet, dbg)

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

    a_f = fillholes(a);
    a_fc = bclosing(a_f,1,-1,1);
    a_fcf = fillholes(a_fc);

    a_fcf_skeleton = bskeleton(a_fcf,0,'natural');
    bws = logical(a_fcf_skeleton);

    imwrite(bws, strcat(dbnm_iskelet, imgnm));
    
    if dbg
        figure(11);
            subplot(221),   imshow(bw),                 title('64x64');
            subplot(222),   imshow(logical(a_f)),       title('fillholes');
            subplot(223),   imshow(logical(a_fc)),      title('closing');
            subplot(224),   imshow(bws),                title('iskelet');
        drawnow;
    end    

end