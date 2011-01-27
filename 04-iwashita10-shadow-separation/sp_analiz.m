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

DIR = dir(strcat(dbnm, '*.png'));
DIR_gtruth = dir(strcat(dbnm_gtruth, '*.png'));
sz = length(DIR);

for f=1:sz
    if dbg, fprintf('%d. frame isleniyor...\n', f); end

    gtruth = load('_db/gtruth/bbox.mat');   % db_bbox(pathos('_db/gtruth/'), true); % as gtruth.bboxs
    gtruth.img = imcrop(imread(strcat(dbnm_gtruth, DIR_gtruth(f).name)), gtruth.bboxs(f, :));

    frm = imread(strcat(dbnm, DIR(f).name));
    bw = imcrop(frm, bboxs(f, :));

    [bwb, bws] = bw_bs_ayir(bw, round(SP_fe_r(f) - bboxs(f, 2) + 1), dbg);
    [y_gt, y_bws] = shadow_cakistir(gtruth.img, bws, dbg);
   
    % error metrikleri
    err.mse = mse(double(y_bws), double(y_gt));
    err.mae = mae(double(y_bws), double(y_gt));
    err.mre = mre(double(y_bws), double(y_gt + 1e-3));
    err.lfmse = lfmse(double(y_bws), double(y_gt))
    
    if dbg,
        figure(1),
        t_bs = uint8(overlay(y_bws, edge(double(y_gt), 'canny'),  [255 0 0]));
        imshow(t_bs);   
        title('bws uzerine kirmizi: gtruth')
        pause(0.3); drawnow
    end
end
