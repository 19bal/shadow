function err = error_metric(y_bws, y_gt)
% function err = error_metric(y_bws, y_gt)

% error metrikleri
err.mse = mse(double(y_bws), double(y_gt));
err.mae = mae(double(y_bws), double(y_gt));
err.mre = mre(double(y_bws), double(y_gt + 1e-3));
err.lfmse = lfmse(double(y_bws), double(y_gt));