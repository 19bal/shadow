%%%%%%%%%%%%%%%% D O   N O T   E D I T   M E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LIB_PATH = sprintf('..%slib%s', filesep,filesep);                         %
addpath(LIB_PATH,'-end');                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dbg = true;

dbnm = pathos(strcat(DB_ROOT(LIB_PATH), 'gait/surveillance/'));
dbnm_bw = pathos('_db/bw/');
dbnm_siluet = pathos('_db/siluet/');
dbnm_64x64  = pathos('_db/64x64/');

if ~exist((pathos('_bkp/bg_model.png'))),
    bg = bg_model(dbnm, 200, dbg);
else
    bg = imread(pathos('_bkp/bg_model.png'));
end

if length(dir(strcat(dbnm_bw, '*.png'))) < 1
    dbnm_bw = frm2bw_db(dbnm, bg, dbg);
end

DIR = dir(strcat(dbnm, '*.png'));
DIR_bw = dir(strcat(dbnm_bw, '*.png'));
sz = length(DIR_bw);

for f = 1:135,
    fprintf('kare %04d/%04d isleniyor ...\n', f, sz);

    imgnm = DIR(f).name;    
    fr = imread(strcat(dbnm, imgnm));
    
    imgnm_bw = DIR_bw(f).name;    
    bw = double(imread(strcat(dbnm_bw, imgnm_bw)));
    
    bwr = insanlar(bw, false);
    
    frh = fr .* uint8(cat(3, bwr,bwr,bwr));
    if dbg
        figure(1);
            subplot(121),   imshow(bwr),     title('bwr');
            subplot(122),   imshow(frh),    title('insanlar');
        drawnow;
    end

    if length(dir(strcat(dbnm_siluet, '*.png'))) < 1
       imwrite(bwr, strcat(dbnm_siluet, imgnm));
    end
    
    bw64x64 = bwsresize(bwscrop(bw2silh(bwr)));
    imwrite(bw64x64, strcat(dbnm_64x64, imgnm));
end