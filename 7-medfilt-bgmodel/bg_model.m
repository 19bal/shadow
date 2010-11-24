function bg = bg_model(DIR, N, dbnm, dbg);
% function bg = bg_model(DIR, N, dbnm, dbg);

DIR = DIR(1:N);
bg = bg_color(DIR, dbnm, dbg);
imwrite(bg, pathos('_bkp/bg_model.png'));