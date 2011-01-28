% function sp_analiz(dbg)
close all;  clear all;  clc;
warning off all;

%%%%%%%%%%%%%%%% D O   N O T   E D I T   M E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LIB_PATH = sprintf('..%slib%s', filesep,filesep);                         %
addpath(LIB_PATH,'-end');                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dbg = true;
dip_initialise('silent');

dbnm   = pathos('_db/insan/');              % iwashita_insan_db.m
dbnm_gtruth = pathos('_db/gtruth/');        % https://github.com/downloads/19bal/shadow/surveillance_gtruth.tar.gz

% bboxs
load(strcat(dbnm, 'bbox.mat'));             % db_bbox(pathos('_db/insan/'), true);

% sp: sp_real_koord(true);
load(pathos('_bkp/sp_our_ky_real.mat'));    % 'SP_ky_r'
load(pathos('_bkp/sp_our_fe_real.mat'));    % 'SP_fe_r'
load(pathos('_bkp/sp_iwashita_real.mat'));  % 'SP_iw_r'

% coord: real to bbox => orjinal resim koordinatlar?ndan bbox icerisi koord
SP_ky_r = round(SP_ky_r - bboxs(:, 2) + 1);
SP_fe_r = round(SP_fe_r - bboxs(:, 2) + 1);
SP_iw_r = round(SP_iw_r - bboxs(:, 2) + 1);

DIR = dir(strcat(dbnm, '*.png'));
DIR_gtruth = dir(strcat(dbnm_gtruth, '*.png'));
sz = length(DIR);

for f=1:sz
    if dbg, fprintf('%d. frame isleniyor...\n', f); end

    gtruth = load('_db/gtruth/bbox.mat');   % db_bbox(pathos('_db/gtruth/'), true); % as gtruth.bboxs
    gtruth.img = imcrop(imread(strcat(dbnm_gtruth, DIR_gtruth(f).name)), gtruth.bboxs(f, :));

    frm = imread(strcat(dbnm, DIR(f).name));
    bw = imcrop(frm, bboxs(f, :));
    
    gt = gtruth.img;
    
    [bws_ky, gt_ky, err_ky(f)] = sp_analiz_helper(bw, gt, SP_ky_r(f), dbg);
    [bws_fe, gt_fe, err_fe(f)] = sp_analiz_helper(bw, gt, SP_fe_r(f), dbg);
    [bws_iw, gt_iw, err_iw(f)] = sp_analiz_helper(bw, gt, SP_iw_r(f), dbg);
    
    if dbg,
        figure(1),
        subplot(221)
            t_bs = uint8(overlay(bws_ky, edge(double(gt_ky), 'canny'),  [255 0 0]));
            imshow(t_bs);   
            title('KY')
        subplot(222)
            t_bs = uint8(overlay(bws_fe, edge(double(gt_fe), 'canny'),  [255 0 0]));
            imshow(t_bs);   
            title('FE')
        subplot(223)
            t_bs = uint8(overlay(bws_iw, edge(double(gt_iw), 'canny'),  [255 0 0]));
            imshow(t_bs);   
            title('Iwashita')            
        pause(0.3); drawnow
    end
end

% karsilastirmali sonuclar
karsilastirmali.Etiket = {'KY', 'FE', 'IW'};
karsilastirmali.err.mse = [cat(1, err_ky.mse) cat(1, err_fe.mse) cat(1, err_iw.mse)]';
karsilastirmali.err.mae = [cat(1, err_ky.mae) cat(1, err_fe.mae) cat(1, err_iw.mae)]';
karsilastirmali.err.mre = [cat(1, err_ky.mre) cat(1, err_fe.mre) cat(1, err_iw.mre)]';
karsilastirmali.err.lfmse = [cat(1, err_ky.lfmse) cat(1, err_fe.lfmse) cat(1, err_iw.lfmse)]';

save(pathos('_bkp/sp_err_karsilastirmali.mat'), 'karsilastirmali');

fprintf('SONUCLAR:\n');

fprintf('\tError:\n');
fprintf('\t%s: %.3f +- %.3f\n\t%s: %.3f +- %.3f\n\t%s: %.3f +- %.3f\n\n', ...
   char(karsilastirmali.Etiket(1)), ...
   mean(karsilastirmali.err.mse(1,:)), std(karsilastirmali.err.mse(1,:)), ...
   char(karsilastirmali.Etiket(2)), ...
   mean(karsilastirmali.err.mse(2,:)), std(karsilastirmali.err.mse(2,:)), ...
  char(karsilastirmali.Etiket(3)), ... 
   mean(karsilastirmali.err.mse(3,:)), std(karsilastirmali.err.mse(3,:)));

[mn, idx] = min(karsilastirmali.err.mse);
fprintf('\tENIYILER: toplam %d adet veri var...\n', length(err_ky));
fprintf('\t%s: %d, %s: %d, %s: %d\n\n', ...
        char(karsilastirmali.Etiket(1)), length(find(idx == 1)), ...
        char(karsilastirmali.Etiket(2)), length(find(idx == 2)), ...
        char(karsilastirmali.Etiket(3)), length(find(idx == 3)));
