zamanda median filtre uygulama temelli bgmodel-bgextract çalışması

## Rapor

önce elimizde renkli video vardı,

![giriş video](https://github.com/19bal/shadow/raw/master/7-medfilt-bgmodel/assets/surveillance.gif)

sonra zamanda yürüyen median filtre yardımıyla [bgmodeli](http://cloud.github.com/downloads/19bal/shadow/bg_model.png) elde ettik, bunu kullanarak basit eşiklemeyle bw görüntüler elde edildi,

![bw](https://github.com/19bal/shadow/raw/master/7-medfilt-bgmodel/assets/bw.gif)

bw görüntülerdeki insan dışı bileşenler temizlendikten sonrasında silüet elde edildi,

![siluet](https://github.com/19bal/shadow/raw/master/7-medfilt-bgmodel/assets/siluet.gif)

silüetlerden soldaki alınıp 64x64 alana hapsedilince de,

![64x64](https://github.com/19bal/shadow/raw/master/7-medfilt-bgmodel/assets/64x64.gif)

Şimdi sırada `8-iwashita10-shadow-separation` çalışması yardımıyla shadow un body den ayrılması kaldı.
