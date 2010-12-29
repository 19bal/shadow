close all;  clear all;  clc;

%%%%%%%%%%%%%%%% D O   N O T   E D I T   M E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LIB_PATH = sprintf('..%slib%s', filesep,filesep);                         %
addpath(LIB_PATH,'-end');                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dbg = false;

dbnm_64x64   = pathos('_db/64x64/');    % ../07-medfilt-bgmodel/runme.m
dbnm_iskelet = pathos('_db/iskelet/');  mkdir(dbnm_64x64);
dbnm_septs   = pathos('_db/septs/');    mkdir(dbnm_septs);
fnm_annot    = pathos('_db/annot/sp_annot.csv');

iskelet_db(dbnm_64x64, dbnm_iskelet, dbg);

DIR = dir(strcat(dbnm_iskelet, '*.png'));
DIR_64x64 = dir(strcat(dbnm_64x64, '*.png'));

sz = length(DIR);

dip_initialise('silent');

[sp, bbH, bbW] = sp_iwashita(pathos('_db/bw/'), dbg);
sp = sp / bbH * 64;     % H=64 e normalize et!

if ~exist(fnm_annot),    sp_annot();      end;    
sp_annot = csvread(fnm_annot);

for f = 1:60 %sz,
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
            bw_64x64 = imread(strcat(dbnm_64x64, imgnm));
            imshow(bw_64x64)
            hold on;
            plot(1:size(bw, 2), ky*ones(size(bw,2)), 'r');
            plot(1:size(bw, 2), sp_fe(2) * ones(size(bw,2)), 'b');
            plot(1:size(bw, 2), sp       * ones(size(bw,2)), 'g'); 
            plot(1:size(bw, 2), sp_annot(f)*ones(size(bw,2)), 'y');
             %legend('hough', 'fitellipse');
            hold off;
        drawnow;
    end     
 
    SP_ky(f) = ky;
    SP_fe(f) = sp_fe(2);
    
    if dbg
        figure(2),     hold on;    
        plot(1:length(SP_ky), SP_ky, 'r');
        plot(1:length(SP_fe), SP_fe, 'b');
        hold off
        pause(0.5)
    end
end

if dbg
    fid = 1:length(SP_fe);
    
    figure(3),     
    hold on;    
    plot(fid, SP_ky, 'r');
    plot(fid, SP_fe, 'b');
    plot(fid, sp * ones(size(fid)), 'k');    
    plot(fid, sp_annot, 'y');
    legend('our-v1', 'our-v2', 'iwashita10', 'annot');
    title('separation point');
    xlabel('frame indis');      ylabel('y-koordinat degeri');
    hold off   
end

err_iwashita  = sqrt(mean((sp - sp_annot).^2))
err_our_meth1 = sqrt(mean((SP_ky - sp_annot).^2))
err_our_meth2 = sqrt(mean((SP_fe - sp_annot).^2))

