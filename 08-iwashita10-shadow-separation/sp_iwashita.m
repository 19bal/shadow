% sp_iwashita
close all;  clear all;  clc;

%%%%%%%%%%%%%%%% D O   N O T   E D I T   M E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LIB_PATH = sprintf('..%slib%s', filesep,filesep);                         %
addpath(LIB_PATH,'-end');                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dbg = true;

dbnm   = pathos('_db/bw/');    % ../07-medfilt-bgmodel/runme.m

DIR = dir(strcat(dbnm, '*.png'));
sz = 50;%length(DIR);

dip_initialise('silent');

for f = 1:sz,
    fprintf('kare %04d/%04d isleniyor ...\n', f, sz);

    imgnm = DIR(f+50).name;    
    bw = imread(strcat(dbnm, imgnm));
    
    bw2 = bwareaopen(bw, 35);
    % bwN(:,:,f) = bw;
     
    a = dip_image(bw2);
    a_f = fillholes(a);
    a_fc = bclosing(a_f,1,-1,1);
    a_fcf = fillholes(a_fc);
    b = brmedgeobjs(a_fcf, 1);
    bw3 = logical(b);
    
    if dbg
        figure(1);  imshow(bw3);
        drawnow;
    end     
 
end

% t = 1:64;
% 
% bwm  = uint8(255 * mean(double(bwN), 3));
% bwem = uint8(255 * mean(double(bweN), 3));
% bwem = (bwem > 0);
% bwm_x = sum(bwm, 2);
% bwem_x = sum(bwem, 2);
% 
% figure(2), 
% subplot(221),   imshow(bwm)
% subplot(222),   plot(bwm_x, t)
% subplot(223),   imshow(bwem)
% subplot(224),   plot(bwem_x, t)
% 
% bwN_y = sum(double(bwN), 1);
% bwN_x = sum(double(bwN), 2);
% 
% bwN_x_mn = mean(bwN_x, 3);
% bwN_y_mn = mean(bwN_y, 3);
% 
% figure(3),  
% 
% subplot(221),  
% hold on
% for f=1:sz
%     plot(t, bwN_x(:,1,f), 'k');
% end
% hold off
% 
% subplot(223),   plot(bwN_x_mn);
% 
% subplot(222),   
% hold on
% for f=1:sz
%     plot(bwN_y(1,:,f), t, 'k');
% end
% hold off
% 
% subplot(224),   plot(bwN_y_mn, t);
% 
% 
% 
% 
