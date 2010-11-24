%%%%%%%%%%%%%%%% D O   N O T   E D I T   M E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LIB_PATH = sprintf('..%slib%s', filesep,filesep);                         %
addpath(LIB_PATH,'-end');                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dbnm = pathos(strcat(DB_ROOT(LIB_PATH), 'gait/surveillance/'));
DIR = dir(strcat(dbnm, '*.png'));
dbg = true;

DIR = DIR(1:200);

% bg-model
bg_med = bg_color(DIR, dbnm, dbg);

imwrite(bg_med, pathos('_bkp/bg_med.png'));
bg_med = imread(pathos('_bkp/bg_med.png'));

T = 30;
mc = 25;    Mc = 45;
sz = length(DIR);

for f = 1:sz,
    imgnm = DIR(f).name;    
    cfrm = imread(strcat(dbnm, imgnm));  
    
    fark = uint8(abs(double(cfrm) - double(bg_med)));
    bw = (fark > T);
    
    confC = frm2confC(cfrm, bg_med, mc, Mc, T, false);
    
    
    figure(1);
        subplot(121),   imshow(cfrm)
        subplot(122),   imshow(confC)
    drawnow;
end
