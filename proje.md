# Başlık

Gölgeden Kimlik Tespiti

# Yol haritası

**14.ekim.2010** a kadar hazırlanmalı.

# Amaç

Yürüyüş analizi bilgisayarla görüde son yıllarda çalışılan en yeni konulardan
biridir. Onun biometrik kimlik saptama, medikal tanı ve tedavisel araçları
içeren çeşitli alanlarda uygulama potansiyeli mevcuttur.  Havadan çekilen
görüntülerde ise yürüyüş analizinin gereksinim duyduğu silüete ait baş ve omuz
dışında bilgi bulunmamakta ve bu yapı kimlik tespitini engellemektedir. Fakat
insan gölgesi silüetin bir yansımasıdır. Son zamanlarda gölgeden de kimlik
tespiti yapılabileceğine dair fikirler ortaya çıkmış ve bu konuda NASA başta
olmak üzere önemli kurumlar ciddi araştırmalar yapmaya başlamıştır.  Yürüyüş
analizi yöntemleriyle işledikten sonra videodan türetilen insan gölge
silüetindeki biometrik bilgiden (gölge biometrisi) yararlanmak, uzaktan
biometride yeni bir kulvardır.  Bu çalışmada, insan ve davranışlarını tanımlama
için gölge ve gölge dinamiklerinin kullanımına odaklanılacaktır.  Yukarıdan
yapılan, doğrudan gözlemden çok daha fazla bilgi (daha geniş resim alanı ve
daha fazla davranışa ait ipuçları) gölge yardımıyla elde edilir.  Gölge
biometrisi vücuda ait bilgi olmaksızın veya ek bir perspektiften ikinci kamera
kullanıyormuşcasına kombine ederek gölge bilgisini kullanır.  Gölge
karakteristik verisi kullanılarak insan ve davranışını tanımak,
kimliklendirmekdoğrulamak mümkün olmaktadır. Böylece, gölge biometriği,
yukarıdan uzaktan biometriği aktive eder. Böylelikle gelecekte
uzay/uçak/İHA'ların görüntüleme sistemleri gölge dinamiklerini (ör.  gait)
analiz ederek şüphelileri (ör. terörist) tanıyabilir ve takip edebilecek.
İnsan tanımanın ötesinde, hareket dinamikleri, intihar bombacısı, gösterici
veya diğer agresif kişilikler gibi spesifik davranış türüne dair bilgi de
sağlabilir.  Bu çalışmada güneş ışınlarının düşme açısı da göz önüne alınarak
gölgeden affine dönüşümü yardımıyla silüeti elde etmek ve sonrasında silüetten
kimlik tespiti sağlamaktır.

# Keywords

gait analysis, shadow biometric, airbone image

# Konu ve Kapsam
# Literatür Özeti
http://fortune.is.kyushu-u.ac.jp/~yumi/pdf/BLISS_3AS_eXpress.pdf 

SHADOW IDENTIFICATION AND CLASSIFICATION USING INVARIANT COLOR MODELS

http://docs.google.com/viewer?a=v&q=cache:UWpsBpoemEEJ:citeseerx.ist.psu.edu/viewdoc/download%3Fdoi%3D10.1.1.10.6641%26rep%3Drep1%26type%3Dpdf+shadow+classification&hl=tr&gl=tr&pid=bl&srcid=ADGEESjCDYUJWK26_O7OzBEbhqcPKdT7oDtEa03IgYHxQi60r4-9qnfxVMyvOmdjCQ8c_ep_XA4k2bhTa-4O1yzcpwywdOpkI4ZyAkZACY2YMoCDrV28JQGyN-VtgT1h9iMJiyy4FUmj&sig=AHIEtbQix-sxI0fcFA6EqGUawDLMsDAJ4Q 

1.	gait analysis ile ilgili makaleler
Determining Height and Gender of a Subject Using Gait
http://www.ece.umd.edu/RITE/archives/merit2007/merit_fair07_reports/report_02_Kuhlman.pdf

farklı bi makale
Human Identiﬁcation Based on Gait,Springer-Verlag New York,Inc.Secaucus,NJ,USA,2006.  

2.	shadow detection ile ilgili makaleler
http://www.google.com.tr/search?hl=tr&client=firefox-a&hs=Rr0&rls=org.mozilla:en-US:official&&sa=X&ei=eKh8TMazGMneONWn-YIE&ved=0CBkQvwUoAQ&q=shadow+detection&spell=1
3. aerial image human detection/recognition/identification/tracking ile ilgili makaleler
http://server.cs.ucf.edu/~vision/news/Reilly_ECCV_2010_Geometric.pdf
4. Kaynakçada yer alan (ve varsa diğer ilgili) shadow biometric ile ilgili makaleler

# Özgün değer

1. Havadan çekilen videolardan kimlik tespiti mümkün olacaktır. 
2. Var olan çalışmalardan farklı olaraktan önerilen yöntem sayesinde var olan gait recognition yöntemleri kullanılabilecektir
 
# Yöntem
###shape based
Shape var. Based .....pdf makale
##madole based
Silhoueete based human identification ... pdf makale


####yöntem
a-segmentasyon
b-silüet stabdartlaştırma
c-her bir frame deki uzaysal özlellikleri çıkarma
d-frekans analizi ve sınıflandırma



1. Havadan çekilen videolardan kimlik tespiti mümkün olacaktır. 
2. Var olan çalışmalardan farklı olaraktan önerilen yöntem sayesinde var olan gait recognition yöntemleri kullanılabilecektir
 
# Yöntem

1. [4] de tarif edilen Shadow gait database i oluşturmak. Figure 2 de ki deneysel ortamı oluşturmak.

2. background extraction: daha önceki derlemelerimiz buraya

3. human shadow detection: "shadow detection" ile ilgili makale mevcut fakat gölge insana mı ait için araştırmak/geliştirmek gerekecek.

4. shadow->silüet: gölgeden insan silüetine dönüşüm. gölge içerisinden miheng noktaları belirlenerek affine dönüşümü yardımıyla görüntüden silüet çıkarılır. [4] ün 3.2 maddesine de bak.

5. shadow gait recognition: bundan sonrası standart gait recognition olacak

# araştırma olanakları

1. BALLAB kapsamında temin edilmiş olan Workstation
2. gait recognition la ilgili yapılmış ön çalışmalar (db ler, MTI,GaTech yaklaşımı)

# yaygın etki ve katma değer

1. güvenlik/askeri

# çalışma takvimi

- iş paketi adı = yöntemdeki aşama
- bu aşamalar ne kadar süre alacak?
- toplamda 1,5 yıla yayabiliriz

# b planı

- yöntemdeki aşamaların gerçekleştirilebilirliğini sına

- db oluşturmada güneş etkisi / kısıtlamalar (daha önce mail olarak geçtiğim böyle bir makale vardı oradan alıntılar yap)

- B planı kendi db mizi oluşturup, onun üzerinde düz gait recognition yapmış oluruz

# Kaynaklar

1. Towards Recognition of Humans and their Behaviors from Space and Airborne
Platforms: Extracting the Information in the Dynamics of Human Shadows

http://ieeexplore.ieee.org/ielx5/4595777/4595778/04595808.pdf?tp=&arnumber=4595808&isnumber=4595778

2. Elemanın patent dosyası

http://ip.com/pdf/patapp/US20100111374.pdf

3. Human Identity Recognition in Aerial Images

http://www.cs.ucf.edu/~oreifej/papers/WRM_CVPR2010.pdf

4. Gait Recognition using Shadow Analysis

http://fortune.is.kyushu-u.ac.jp/~yumi/pdf/BLISS_3AS_eXpress.pdf
