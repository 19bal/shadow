% function sp_analiz(dbg)
close all;  clear all;  clc;

%%%%%%%%%%%%%%%% D O   N O T   E D I T   M E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LIB_PATH = sprintf('..%slib%s', filesep,filesep);                         %
addpath(LIB_PATH,'-end');                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dbg = true;

dbnm   = pathos('_db/insan/');              % iwashita_insan_db.m
dbnm_gtruth = pathos('_db/gtruth/');        % https://github.com/downloads/19bal/shadow/surveillance_gtruth.tar.gz

% bboxs
load(strcat(dbnm, 'bbox.mat'));             % db_bbox.m

% sp: runme.m
load(pathos('_bkp/sp_our_ky_real.mat'));    % 'SP_ky_r'
load(pathos('_bkp/sp_our_fe_real.mat'));    % 'SP_fe_r'
load(pathos('_bkp/sp_iwashita_real.mat'));  % 'SP_iw_r'

DIR = dir(strcat(dbnm, '*.png'));
DIR_gtruth = dir(strcat(dbnm_gtruth, '*.png'));
sz = length(DIR);

for f=1:sz
    if dbg, fprintf('%d. frame isleniyor...\n', f); end

    gtruth = load('_db/gtruth/bbox.mat');   % as gtruth.bboxs
    gtruth.img = imread(strcat(dbnm_gtruth, DIR_gtruth(f).name));

    frm = imread(strcat(dbnm, DIR(f).name));
    bw = imcrop(frm, bboxs(f, :));

    sp = round(SP_fe_r(f) - bboxs(f, 2) + 1);

    bwb = bw(1:sp,   :);
    bws = bw(sp:end, :);

    if dbg,
        figure(11),
        subplot(221),   imshow(bw);                                         title('bw');
        subplot(222),   imshow(edge(double(gtruth.img), 'canny'));          title('gtruth');
        subplot(223),   imshow(edge(double(bwb), 'canny'));                 title('body');
        subplot(224),   imshow(edge(double(bws), 'canny'));                 title('shadow');
        drawnow
    end
end
