%%%%%%%%%%%%%%%% D O   N O T   E D I T   M E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LIB_PATH = sprintf('..%slib%s', filesep,filesep);                         %
addpath(LIB_PATH,'-end');                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dbg = true;

dbnm = pathos(strcat(DB_ROOT(LIB_PATH), 'gait/surveillance/'));
mkdir(pathos('_db/'));
dbnm_bw = pathos('_db/bw/');
dbnm_siluet = pathos('_db/siluet/');
dbnm_64x64  = pathos('_db/64x64/');

dbnm_bkp = pathos('_bkp/');

if ~exist((pathos(strcat(dbnm_bkp, 'bg_model.png')))),
    bg = bg_model(dbnm, dbnm_bkp, 200, dbg);
else
    bg = imread(pathos(strcat(dbnm_bkp, 'bg_model.png')));
end

if length(dir(strcat(dbnm_bw, '*.png'))) < 1
    dbnm_bw = frm2bw_db(dbnm, dbnm_bw, bg, dbg);
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
    
    if length(dir(strcat(dbnm_siluet, '*.png'))) < 1
        bwr = insanlar(bw, false);
        imwrite(bwr, strcat(dbnm_siluet, imgnm));
    else
        bwr = imread(strcat(dbnm_siluet, imgnm));
    end
    
    frh = fr .* uint8(cat(3, bwr,bwr,bwr));
    
    if length(dir(strcat(dbnm_64x64, '*.png'))) < 1
        bw64x64 = bwsresize(bwscrop(bw2silh(bwr)));
        imwrite(bw64x64, strcat(dbnm_64x64, imgnm));
    else
        bw64x64 = imread(strcat(dbnm_64x64, imgnm));
    end

    if dbg
        figure(1);
            subplot(221),   imshow(bwr),        title('bwr');
            subplot(222),   imshow(frh),        title('insanlar');
            subplot(223),   imshow(bw64x64),    title('64x64');
        drawnow;
    end    
end