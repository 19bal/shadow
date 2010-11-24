%%%%%%%%%%%%%%%% D O   N O T   E D I T   M E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LIB_PATH = sprintf('..%slib%s', filesep,filesep);                         %
addpath(LIB_PATH,'-end');                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dbg = true;

dbnm = pathos(strcat(DB_ROOT(LIB_PATH), 'gait/surveillance/'));
dbnm_bw = pathos('_db/bw/');

if ~exist((pathos('_bkp/bg_model.png'))),
    bg = bg_model(dbnm, 200, dbg);
else
    bg = imread(pathos('_bkp/bg_model.png'));
end

if length(dir(strcat(dbnm_bw, '*.png'))) < 1
    dbnm_bw = frm2bw_db(dbnm, bg, dbg);
end

DIR = dir(strcat(dbnm_bw, '*.png'));
sz = length(DIR);

for f = 1:135,
    fprintf('kare %04d/%04d isleniyor ...\n', f, sz);
    
    imgnm = DIR(f).name;    
    bw = double(imread(strcat(dbnm_bw, imgnm)));
    
    bwr = insanlar(bw, false);
    
    if dbg
        figure(1);
            subplot(121),   imshow(bw),     title('bw');
            subplot(122),   imshow(bwr),     title('bwr');
        drawnow;
    end           
    
end