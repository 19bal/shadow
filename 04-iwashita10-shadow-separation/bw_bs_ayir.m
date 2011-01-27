function [bwb, bws] = bw_bs_ayir(bw, sp, dbg)
% function [bwb, bws] = bw_bs_ayir(bw, sp, dbg)

bwb = bw(1:sp-1,     :);
bws = bw(sp:end, :);

bwb = imcrop(bwb, bobox(bwb));
bws = imcrop(bws, bobox(bws));