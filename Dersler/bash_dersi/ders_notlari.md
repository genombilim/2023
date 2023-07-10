# Bash'e giris

Asagidaki kodlari tek tek terminalinize kopyalayip yapistiracaksiniz. Sondaki noktalari unutmak, tirnak isaretlerindeki duzeltmeler hataya sebep olur. Mutlaka ayni seyi yapitirdiginiza emin olun. 

- Ilk olarak terminali acin. 
- TRUBA sunucularına bağlanmak için once Ana dizindeki truba hesaplar excel dosyasindan kendi kullanici isminizi ve sifrenizi not alin.
  
• Kullanıcı İsmi: egitimXX
• Şifre: 

- Sonra da aşağıdaki kodu terminal ekranınıza yazmanız gerekecek. Eğer, bu sunucuda ilk defa bağlanıyorsanız bir uyarı alabilirisiniz. Yes diye cevap vermeniz gerekmektedir.

Şifrenizi yazarken ekranda hiç bir imleç belirmez. Endişe etmeyin.
 ```
			ssh egitimXX@levrek1.ulakbim.gov.tr
			şifre: adiniza verilen şifre

``` 
- Trubaya baglaninca ilk olarak kendinize ait bir dizin olusturun. Kendi ilk isminiz kucuk harflerle ve bitisik olarak.
```
			mkdir <isminiz>
			cd <isminiz>

```

Home directory (konum/altdizin): bash'i baslattiginizda bulundugunuz ilk konum.

bulundugunuz konumu/altdizini gorunteleyin:
```
			pwd
```
			
## Nasil bir ust dizine gidecegiz?
```
			cd ../
```
			
## Listele komutu:
```
			ls
```
			
Soru: komut neden acikca 'list' olarak kullanilmiyor da 'ls' olarak kullaniliyor?
Cevap: kisaltma ~ zaman

## Nasil bir altdizine gidecegiz?
```
			cd <isminiz>
```
			
## Bir seyi ekrana yazdırmak icin:
```
			echo merhaba
```
			
## Ekrani temizlemek icin:
```
			clear
```

Komut satirlarinda eski yazdiklarini gormek icin, bazen eski komutlari tekrar calistirmak icin vs 'yukari & 'asagi' oklari kullanabilirsiniz.

Satir basina gitmek icin Ctrl + a ya basin, sona gitmek icin ya saga ok, ya da yukari asagi oklar.


## Cok onemli bir ozellik - komut tarihcesi (history):
```
			history
```
			
dersin sonunda bunu tekrar komutlayip yeni dosyaya kaydedebilirsiniz.

## Yeni bir dizin olustur:
```
			mkdir bash_dersi
			ls
```
			
## Tek adimda istenilen dizine gitmek:
once bir geri cikalim:

```
			cd ../
```
			
sonra olusturdugumuz dosyanin icine girelim:

```
			cd /<isminiz>/bash_dersi/
```
			
 '/' altdizin oldugunu belirtiyor & farkli altdizinleri hiyerarsiye gore diziyor – ust konumdan alt konuma dogru.

Bir dizinden/konumdan 'home-directory'ye gecmenin kisa yolu:
```
			cd ~
```
			
## Peki ilgili arac icin bulunan seceneklere dair nereden bilgi alabiliriz?
Man sayfasi ilgili araci calistiracak komutlar uzerine bilgi verir:

```
			man ls
```
			
koseli parantez icinde verilen secenekler opsiyoneldir. Komut o secenekler olmadan da caisir. Fakat secenekler size cok faydali calismanizda yardimci olur. Secenekleri gozden gecirmeniz (man ile) cok faydali.

'man' sayfasindan ‘q’ ile cikabiliriz.

## Yeni Dosya uretmek 1:

```
			cd <isminiz>/bash_dersi/
   			echo bu benim ilk dosyam > ilk_dosyam.txt
```
			
> isareti oncesindeki icerigi sonrasindaki dosyaya kaydeder. - uzerine yaziyor, dikkat!

'>>' yine yonlendiriyor fakat eger o dosya ismi veri iceriyorsa sonuna ekler.

isminizi tasiyan dizinin icinde ilk_dosyam adinda bir dosya olusturduk. Icine de bu benim ilk dosyam yazdik.

Dosya isimlendirmelerinizin mantikli, anlasilabilir, birbirleri ile iliskili olmasi cok ama cok onemli!

Dosya isimlendirmelerine bosluk vermekten ve /, ‘, “, >, .  isartetlini kullanmaktan kacinalim. Bunlar komut satirinin kullandigi harfler oldugu icin dosya/dizin ismina koyarsak karisirlar.

Dosyanin icine bakmak:
```
			cat ilk_dosyam.txt
```
			
cat komutu sonrasinda yazili olan dosyanin (dosyalarin) icergini gosterir. Bir kac dosya icerigini tek bir dosya kaydetmek icin de kullanabilecegi icin ismi concatanate’ten gelir. 
Dosya ismini girerken mutlaka TAB kullanın! TAB'in zaman kazandirmasi disinda en onemli ozelligi hatali isimlendirmeyi onler, yanlis dosya uzer

## Yeni Dosya uretmek 2:
```
			vim ikinci_dosyam.txt
```
Dosyanin icine girdiniz. I yazip icine bu benim ikinci dosyam yazin. Kaydedip cikmak icin once escape'e basin, sonra iki nokta ust uste yazip x yazin (:x). Kaydedip cikmis olacaksiniz.
```
   			ls
			cat ikinci_dosyam.txt
```
			
dosya isimlerine txt eklersek word’de acabiliriz. Sart degil, genelde ihtiyac yok cunku buna. 

## SORT ile veri dosyasi icerigini duzenlemek / istenilen sutuna gore siralamak:
```
			cd ../../
			ls
			ls | sort
			ls | sort -r
			ls | sort --random-sort
```
			


Dosya silmek:
```
			rm ikinci_dosyam.txt birinci_dosyam
```
tum silmek istediklerimizi rm’un arkasina yazip tek tusla silebiliriz. 

Dizin silmek:
```
			mkdir test_dizini
   			ls
   			rm -r test_dizini
```
			
# Buyuk text verileri ile calisma yontemleri (dizi verisini buyuk bir text verisi olarak dusunebilirsiniz):

Veri cok buyuk oldugundan text icin kullandiginiz grafik arayuzlu programlarin veriyi 'memory' uzerinde tutmasi cok masrafli olur. Gb buyuklugunde iki FASTA dosyasini birlestirmek isterseniz, birini acip kopyalayip-yapistirirken cok fazla memory'yi isgal etmis olursunuz, ayrica mouse ile bu islemi yaparken bir kismini silebilir, tumunu secemeyebilirsiniz vb. Sonunda yapacaginiz analiz & bulacaginiz sonuclar hatali olacaktir. Shell bu durumlarda hem memory'de yer tutmadan hem de sizden kaynaklanan hataya yol acmadan cozmenizi saglar.


Once buyuk_veri diye bir dizinin olusturun ve o dizine gecin. Simdi o dizinimizi olusturalim.

## Dosyalari kopyalamak:
```
			cp ../../bash_dersi_dosyalari/tb1-protein.fasta .
   			cp ../../bash_dersi_dosyalari/tga1-protein.fasta .
   			ls
```
			
cp kendisinden sonra yazilan tum dosyalari en sondaki dizinin icine kopyalar. Nokta isareti icinde bulundugumuz dizini isaret eder.

## Dosyalari bir dizinden digerine tasimak:
```
			mkdir data
```
			
## Dosyalari data dizinine tasiyalim:
```
			mv tb1-protein.fasta data
   			mv tga1-protein.fasta data
   			ls
```
			
## Dosyalari tek bir dosyada toplamak:
```
			cd data
  			cat *protein.fasta > proteins.fasta
```
			
yildiz isareti joker gibidir, herhangi bir harf ve harf dizisi anlamina gelir.
kaydetti mi kontrol ediyoruz:
```
			cat proteins.fasta
```
			
## Dosya icinden hizlica bilgi almak:
Mesela sadece protein ismini görmek istiyoruz nasıl yapabiliriz?
```
			grep protein tb1-protein.fasta
```
			
grep komutu dosyanin icinde belli bir karakteri aratmanizi saglar. Tum satiri verir.
Ya da
```
			grep -v "^>" proteins.fasta
```
			
grep man ile bakabiliriz: 
Ilk is FASTA dosyasinda 'header'i iceren satirlari islem disi birakmak (-v).
" " isareti kullanarak ilgili kalibi grep'e tanittik.
 '^'isareti aranan pattern'i sadece satir basi ile sinirliyor.

Not: grep'in cok hizli olmasinin nedenlerinden biri, bir kalibi buldugunda, o satirin gerisini
arastirmayi birakmasi! -o secenegini inceleyin:
```
			grep -o CRGEG proteins.fasta
```

   
Simdi de DNA fastası acalim.
```
			cp ../../../bash_dersi_dosyalari/tb1.fasta .
			cat tb1.fasta
```
			
Icine kısaca bakalım:

```
			head tb1.fasta
			cat tb1.fasta
			tail tb1.fasta
			wc tb1.fasta
			wc -l tb1.fasta
```
			
COK ONEMLI UYARI: wc gibi islemlerde data formatinin duzgun oldugu sanisi uzerinden hareket ediyoruz.
Eger .txt dosyasi 3 adet bos satir iceriyorsa (whitespace) wc veriye dair 3 fazla satir bilgisi verir!
 
Bu dosyanın icinde ATCG olmayan bir nükleotitler var mi?

```
			grep -v A tb1.fasta
			grep -v ATCG tb1.fasta
			grep --color -i "[^ATCG]" tb1.fasta
```
'^' sembolu [] icinde kullanilinca yaninda oldugu karakterlerin disindaki (!) karakterleri ariyor. Yani [^ATCG], A, T, C, ve T olmayan karakterler ile eslesiyor.

'-i' buyuk-kucuk harf ayrimini ortadan kaldiriyor, eger a, t, g, ve c olarak kaydedilen nukleotidler var ise onlari da dahil etmek dusuncesi ile...

grep'in --color secenegi bulunan karakterleri renkli olarak gosteriyor.

ATCG disinda bir harf var belli ki ama illa genin ismi olan satir da yaziliyor ekrana. Bundan nasil kurtulabiliriz?
   
# Pipeline'a giris:

Pipeline olusturmak Linux-bash'in en guclu ozelliklerinden birisidir. Ornegin 3 farkli program ile bir sekans datasini analiz edeceksiniz. Diyelim ki ilk adim alignment, ikinci adim filogenetik agac olusturmak, ucuncu adim ise atasal DNA dizisi olusturmak. Tek tek adimlari sira ile uygulayabilirsiniz. Veya bir pipeline olusturarak tek bir komut ile islemi hizla gerceklestirebilirsiniz! Ayrica, ornegin birinci ve ikinci islemlerin sonunda olusan ciktiyi bilgisayariniza kaydetmeden pipeline sadece son islemin ciktisini verir. Ozetle pipeline, ilk islemin ciktisini (output) '|' isaretinden sonra gelen ikinci islemde kullanilan araca girdi (input) olarak verir.


Ornek: tb1.fasta dosyasinda nukleotid disinda bulunan diger karakterleri pipeline ile arayalim.

```
			grep  --color -i "[^ATCG]" tb1.fasta | grep -v "^>" 
```

  oldu ama rengi kaybettik. Ne yapsak?
  ```
			grep -v "^>" tb1.fasta |  grep --color -i "[^ATCG]"
```

'|' pipe ile ciktiyi (output) diger bir bash islemine/programina aktaran pipeline isareti.

pipeline ara-cikti (output) sonuclarini dosyaya yazdirmaz! Boylece disk'e yuk olmaz. 

```
			grep -v "^>" tb1.fasta | grep --color -i "[^ATCG]" > results.txt
```
			
# Islemleri arka-planda yurutmek:

Shell'de komutu yazip enter'a basinca, bu shell iletisine ulasim kapanir. Eger terminalde baska islem yapmak isterseniz yeni terminal acmak tekrar istediginiz altdizine gitmek zorunda kalirsiniz. Ki bu ideal bir yontem degil. Eger isleminiz uzun suren bir islem ise, islemi baslattiktan sonra islemin bitmesini beklemeden komut dizininde komut islemlerine devam etmek icin uzun olan islemi arka planda calistirabilirsiniz. Boylece diger komutlari yazmaya devam edebilirsiniz.

(&) komutun arkasina yazildiginda, komut, arka-planda calisir:

```
			grep -v "^>" tb1.fasta | grep --color -i "[^ATCG]" > results.txt &
			jobs
```
			
islemin nasil gittigini gosterir.

NOT: terminalin kapatilmasi islemi durdurur!

Bilgisayarinizda hangi programlar calisiyor:
```
			top
```
			
size PID'yi verecek - process ID bilgisi veriyor
"Kill" komutu:
```
			kill 20352
```
			
process ID'su 20352 olan devam eden bir islemi sonlandirir.


## Sutun verisi ile calismak:

Surekli sadece belli sutunlarda bulunan verilerle calisip diger sutunlari analizimiz disinda birakmamiz gereken durumlar oluyor. Sadece ilgilendigimiz sutunlari almak mumkun. 

Diyelim ki protein isimlerini elde etmek istiyoruz:

```
			grep '>' proteins.fasta | cut -d ' ' -f 1
```
			

SON
