function bg = bg_model(dbnm, N, dbg);
% function bg = bg_model(dbnm, N, dbg);

DIR = dir(strcat(dbnm, '*.png'));
DIR = DIR(1:N);
bg = bg_color(DIR, dbnm, dbg);
imwrite(bg, pathos('_bkp/bg_model.png'));