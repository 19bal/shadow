AIT grubunun "shadow removal" calismasi

#### db

- önce [video](http://gps-tsc.upc.es/imatge/_jl/Tracking/challenge.avi) dosyasını indir

- dizin yapısı şöyle olmalıdır,

	shadow/
		a/2-shadow-removal/
		db/surveillance/

- `db/surveillance/` klasörü altına `ffmpeg -i 021a001s00R.dv frame%03d.png` ile kareleri çıkart

- `demo-*.m` i çalıştır.
