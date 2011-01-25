function bboxs = db_bbox(dbnm, dbg)
% function bboxs = db_bbox(dbnm, dbg)
%
% 'dbnm' icerisindeki tum resimlerin (*.png), bbox'larin hesaplayip, ayni
% dizine 'bbox.mat' olarak kaydeder. Resimdeki en buyuk alanliyi bbox'a
% hapseder.
%
% Usage
%   bboxs = db_bbox(pathos('_db/bw/'), true)

fnm_bkp = strcat(dbnm, 'bbox.mat');

if exist(fnm_bkp),
    load(fnm_bkp);      % load: bboxs
    return
end

DIR = dir(strcat(dbnm, '*.png'));
sz = length(DIR);

for f=1:sz
    if dbg, fprintf('%d. frame isleniyor...\n', f); end

    frm = imread(strcat(dbnm, DIR(f).name));

    bboxs(f, :) = bobox(frm);

    if dbg
        figure(11)
        imshow(frm);
        hold on
        rectangle('Position', bboxs(f, :),'EdgeColor', 'g', 'LineWidth', 1);
        hold off
    end
end

save(fnm_bkp, 'bboxs');

