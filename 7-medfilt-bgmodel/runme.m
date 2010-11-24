%%%%%%%%%%%%%%%% D O   N O T   E D I T   M E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LIB_PATH = sprintf('..%slib%s', filesep,filesep);                         %
addpath(LIB_PATH,'-end');                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dbnm = pathos(strcat(DB_ROOT(LIB_PATH), 'gait/surveillance/'));
DIR = dir(strcat(dbnm, '*.png'));
dbg = true;
is_create_bgmodel = false;

if ~exist((pathos('_bkp/bg_model.png'))),
    bg = bg_model(DIR, 200, dbnm, dbg);
else
    bg = imread(pathos('_bkp/bg_model.png'));
end

T = 30;
mc = 25;    Mc = 45;
sz = length(DIR);

for f = 1:sz,
    imgnm = DIR(f).name;    
    cfrm = imread(strcat(dbnm, imgnm));  
    
    fark = uint8(abs(double(cfrm) - double(bg)));
    
    bw = (fark > T);    
    confC = frm2confC(cfrm, bg, mc, Mc, T, false);
    
    
    figure(1);
        subplot(121),   imshow(cfrm)
        subplot(122),   imshow(confC)
    drawnow;
end
