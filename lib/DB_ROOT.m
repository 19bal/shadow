function dbnm = DB_ROOT()

t = textread('.dbroot', '%s');
dbnm = t(1);
