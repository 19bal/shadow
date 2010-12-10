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

for f = 3:sz,
    fprintf('kare %04d/%04d isleniyor ...\n', f, sz);

    imgnm = DIR(f).name;    
    bw = imread(strcat(dbnm, imgnm));
    
    bw = buda(bw, dbg);
    [bwb, bws] = bs_ayir(bw, dbg);
    
    % BUG FIX: her birisi icin ekstra kontrol yap
    % yakin/benzer degilse ele
    
    % egri uydur: body, shadow
    % iki egrinin kesim noktasi = ayrim noktasidir
    
    % imwrite(bws, strcat(dbnm_septs, imgnm));
    %sp_ht = sp_hough(bws, dbg);
    sp_fe = sp_fitellipse(bwb, bws, dbg);
        
    if dbg
        figure(1);
            subplot(221),   imshow(bwb),        title('');
            subplot(222),   imshow(bws),        title('');
            subplot(223),   imshow(bw)
            hold on;
            plot(sp_fe(1), sp_fe(2), 'g^');
             %legend('hough', 'fitellipse');
            hold off;
        drawnow;
    end     
 
end
