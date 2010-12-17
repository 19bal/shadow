close all;  clear all;  clc;

%%%%%%%%%%%%%%%% D O   N O T   E D I T   M E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LIB_PATH = sprintf('..%slib%s', filesep,filesep);                         %
addpath(LIB_PATH,'-end');                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dbg = true;

dbnm_64x64   = pathos('_db/64x64/');    % ../07-medfilt-bgmodel/runme.m
dbnm_iskelet = pathos('_db/iskelet/');  mkdir(dbnm_64x64);
dbnm_septs   = pathos('_db/septs/');    mkdir(dbnm_septs);

iskelet_db(dbnm_64x64, dbnm_iskelet, dbg);

DIR = dir(strcat(dbnm_iskelet, '*.png'));
sz = length(DIR);

dip_initialise('silent');

for f = 1:sz,
    fprintf('kare %04d/%04d isleniyor ...\n', f, sz);

    imgnm = DIR(f).name;    
    bw = imread(strcat(dbnm_iskelet, imgnm));
    
    figure(2),  imshow(bw)
    
    bw = buda(bw, dbg);
    [bwb, bws, ky] = bs_ayir(bw, dbg);
    
    % BUG FIX: her birisi icin ekstra kontrol yap
    % yakin/benzer degilse ele
    
    % egri uydur: body, shadow
    % iki egrinin kesim noktasi = ayrim noktasidir
    
    % imwrite(bws, strcat(dbnm_septs, imgnm));
    %sp_ht = sp_hough(bws, dbg);
    sp_fe = sp_fitellipse(bwb, bws, ky, dbg);
        
    if dbg
        figure(1);
            imshow(bw)
            hold on;
            plot(1:size(bw, 2), ky*ones(size(bw,2)), 'r');
            plot(1:size(bw, 2), sp_fe(2)*ones(size(bw,2)), 'b');
             %legend('hough', 'fitellipse');
            hold off;
        drawnow;
    end     
 
end
