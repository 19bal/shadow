function [bws, gt, err] = sp_analiz_helper(bw, gtruth, sp, dbg)
% function [bws, gt, err] = sp_analiz_helper(bw, gtruth, sp, dbg)
% 
% shadow ayir + cakistir + err

[t_bwb, t_bws] = bw_bs_ayir(bw, sp, dbg);
[gt, bws] = shadow_cakistir(gtruth, t_bws, dbg);

err = error_metric(bws, gt);