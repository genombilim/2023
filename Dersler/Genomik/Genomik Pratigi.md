# Bioenformatik:

Yeni nesil dizileme (NGS) metotlari o kadar buyuk bir veri uretiyor ki bunu analiz etmek projeler icin onemli bir zorluk teskil ediyor. Arastirmacilar bu buyuklukteki verilerle basa cikabilmek icin oldukca guclu bilgisayarlara ve isletim sistemlerine ihtiyac duyuyorlar. Biyoinformatik bu ihtiyaclari karsilamak amaciyla cikmis bir araclar ve yaklasimlar butunudur. Biyoinformatikci, biyoloji ve bilgisayar bilimi arasinda kopru gorevi gorur. Gunumuzde pek cok universite bu konuda lisans veya yuksek lisans programlari sunsa da biyoinformatik aslen kendi cabamizla da ogrenebilecegimiz bir branstir. 

Bu okulda son yillarda biyoinformatigin en ihtiyac duyuldugu alan olan dizilemedeki kullanimlarini ogrenecegiz. Bu amacla herkes bir bireyin kisa mitogenom dizilerini insan referans genomuna gore hizalayacak, ve mutasyonlari bulacak.

Bu islemleri yapmak icin hal-i hazirda pek cok biyoinformatik araci zaten internette mevcut. Bu araclarin onemli bir kismi terminal dedigimiz komut satirlarindan calistirilabiliyor. Bu da ancak linux/unix bazli isletim sistemlerinde mumkun. Dolayisiyla okulumuz surecinde linux isletim sisteminde calisacagiz. 

# Haydi Baslayalim: Genomik Dosyamizi Olusturalim

Asagidaki kodlari tek tek terminalinize kopyalayip yapistiracaksiniz. Sondaki noktalari unutmak, tirnak isaretlerindeki duzeltmeler hataya sebep olur. Mutlaka ayni seyi yapitirdiginiza emin olun. 

- Ilk olarak terminali acin. 
- TRUBA sunucularına bağlanmak için once Ana dizindeki truba hesaplar excel dosyasindan kendi kullanici isminizi ve sifrenizi bulun yine.
  
• Kullanıcı İsmi: egitimXX
• Şifre: 

- Sonra da aşağıdaki kodu terminal ekranınıza yazmanız gerekecek. Eğer, bu sunucuda ilk defa bağlanıyorsanız bir uyarı alabilirisiniz. Yes diye cevap vermeniz gerekmektedir.

Şifrenizi yazarken ekranda hiç bir imleç belirmez. Endişe etmeyin.
 ```
			ssh egitimXX@levrek1.ulakbim.gov.tr
			şifre: adiniza verilen şifre

``` 
- Trubaya baglaninca ilk olarak kendinize ait olan dizine gecin. Icine genomik diye baska bir dizin olusturun. cd dedikten sonra <isminiz> kismini silip kendi isminize actiginiz dizin ismini yazin.

```
			cd <isminiz>
			mkdir Genomik
			cd Genomik

```
- Programlari hesabiniza yuklemek icin asagidaki satiri girin:
```
			source /truba/home/egitim20/.bashrc	 
```

# SRA'den Okumalari Indirelim

SRA yani kisa dizi arsivi ozellikle yeni dizileme teknolojileri kullanilarak uretilmis genelde 1000 bazdan kisa dizilerin depolandigi bir veri tabanidir. SRA arastirmacilara kisa dizilerini kullanima acik olarak depolayabilecekleri bir yer gorevi gormekle kalmayip ayni zamanda aranilan diziye ve diziyle ilgili detayli deneysel bilgiye hizli bir erisime olanak verir. https://www.ncbi.nlm.nih.gov/sra

sra'in kendi araci olan sra toolkit'in icinden fastq-dump konutuyla bir kisa okuma indirelim. https://hpc.nih.gov/apps/sratoolkit.html

- Okumalarinizi fastq-dump'i kullanarak indirin:  

```
			fastq-dump -I --split-files SRR1583053
			cp SRR1583053_1.fastq reads.fastq
  ```

![Steps-in-next-generation-sequencing-A-Extracted-DNA-is-randomly-broken-into-1000-bp](https://github.com/genombilim/2023/assets/37342417/6b4693c3-77b5-46e3-b74d-467425c933f8)

Bu komut iki tane dosya indirecek: one dogru diziler icin SRR…_1.fastq ve arkaya dogru diziler icin SRR…_2.fastq. Iki tane dosya olmasinin sebebi dizilerin paired-end teknolojisiyle uretilmis olmasi.  Paired-end, asagida da gordugun gibi bir fragmanin iki ucundan dizilenmesini saglar, bu sayede cok daha yuksek kalitede bir dizi elde edilir. Biz kolaylik acisindan bu derste sadece one dogru uzanan dizilerle calisacagiz.

![paired-end1](https://github.com/genombilim/2023/assets/37342417/3a672293-bb62-41b7-a361-0877512b8519)

Haydi indirdigimiz dosyaya bakalim. Neler dikkatinizi cekiyor? 
```
			head reads.fastq
  ```
![Screen-Shot-2018-01-07-at-3 40 32-PM-1024x354](https://github.com/genombilim/2023/assets/37342417/1a2bed3d-f76d-442d-b74d-bf32657b3c3b)

  # Filtreleme
 
Okumalarinizin kalitesinden bahsettik. Nedir bu kalite? Bir bazin  Phred kalite skoru, Q, o bazin hatali okunma ihtimali P’nin logaritmasidir.
![Screen-Shot-2018-01-07-at-1 36 09-PM-1024x713](https://github.com/genombilim/2023/assets/37342417/05a343ee-eed5-472c-86c0-08c1afa838ae)


 - Haydi okumalarinizin kalitesine bakin. Burada okumalarinizi kendi sisteminize kopyalayip fastqc'yi oradan kullanmaniz gerekebilir. Fastqc okuma kalitelerine bakabilelim diye yapilmis bir program. https://www.bioinformatics.babraham.ac.uk/projects/fastqc/

```
			fastqc
  ```

Neler bakabilirsiniz ve sizce niye bunlara bakmak isteriz?

- Okumalarinizi kesip filtreleyecegiz. 
```
			fastx_trimmer -f 20 -l 240 -i reads.fastq -o reads_trimmed.fastq
			fastq_quality_filter -q 30 -p 95 -i reads_trimmed.fastq -o reads_filtered.fastq
  ```    
- Komut -h yazarak her bir komutun ne yaptigina bakin.
-  Simdi de bu websitesine bakin yaninizdaki kisi ile : http://hannonlab.cshl.edu/fastx_toolkit/commandline.html Listeden isinize yarayabilecek iki komut bulup sinifta paylasin. 
 
- Kesilmis ve filtrelenmis dosyalariniza da fastqc ile bakin. Ne goruyorsunuz?
Neden bu adimlara gerek var?
Neden once kestik, sonra filtreledik?
```
			fastqc
  ```
  
  # Referans Genomuna Hizalamak: Insan Metgenomu
- Mitokondri icin referans genomunu indirecegiz. Bunun icin UCSC genome browser'ina gidin, Download kismindan sirasiyla Human, Chromosomes Chromosome M'i bulun.. Link yazan kisma buldugunuz dosyanin linkini kopyalayin:
```
			wget ‘link’
			gunzip chrM.fa.gz
			cp chrM.fa ref.fasta
  ```    
Dizileri yerlestirmek eslestirmece oyunu gibi dusunulebilir. Amac kisa dizilerin aynilarini (veya benzerlerini) buyuk dizide yani genomda bulmaktir. 
![image003](https://github.com/genombilim/2023/assets/37342417/e78cd5cd-4c55-4a0c-ac11-53b8b45e6a6b)

Bu islemi kolaylastirmak icin biyoinformatik araclari indexleme denilen bir teknik kullanirlar. Bu islem sayesinde cok hizli bir sekilde kisa diziler genom uzerinde yerlerini bulurlar. 
<img width="578" alt="index_kmer" src="https://github.com/genombilim/2023/assets/37342417/aa5fae6f-a6b0-4cc0-a2fc-12feddf0c7f9">

Biz yerlestirme icin bowtie2 programini kullanacagiz. 

- Referansa hizalayalim:
```
			bowtie2-build ref.fasta ref
			bowtie2 -x ref -q reads_filtered.fastq -S alignment.sam
			samtools faidx ref.fasta
			samtools view -bt ref.fasta.fai alignment.sam > alignment.bam
			samtools sort alignment.bam -o alignment_sorted.bam
			samtools index alignment_sorted.bam
 ```    
Bu islem 5-10 dakika icinde bir ilk once SAM (Sequence Alignment/Map) dosyasi uretecek. SAM dosyasi insan gozunun okuyabilecegi text formatinda bir dosyadir ve icinde her bir dizi icin bir baslik bir de yerlestirmeyle ilgili detaylarin yer aldigin bir kisim vardir. Dosyanin ilk satirlarini acip icine bir goz atabilirsin. Yandaki link dosya icerigiyle ilgili daha detayli bilgi verir: https://samtools.github.io/hts-specs/SAMv1.pdf
Yerlestirme bitince ekranda kisa bir rapor belirecek. 

SAM dosyasini analiz etmek icin SAMTools programini kulliyoruz. Her programin kendi indexleme sekli oldugundan referans genomumuzu asagidaki komutu kullanarak tekrar indexlememiz gerek. Bu ref.fasta.fai. isimli bir dosya uretti. 
Son olarak SAM dosyamizi BAM (Binary Alignment/Map)’e cevirdik.

Bu formatin icerigiyle ilgili daha fazla bilgi icin yandaki linke goz atabilirsin: http://samtools.sourceforge.net/samtools.shtml

- Bakalim:
 ```   
			samtools tview -d C alignment_sorted.bam ref.fasta
 ```   
  # Derinlik ve Kapsam
Peki elimizdeki diziler genomun yuzde kacini kapsiyor? Ve de kapsadigi yerler hakkinda ne kadar kesin konusabiliriz? 

Bu sorularin cevabini vermek icin dizilerimizin kapsam (coverage) ve derinlik, yani bir noktayi kac kere kapsadigi (depth) degerlerini ogrenmemiz gerekir. 

- Derinligi incelemek icin python kullanacagiz. Bunun icin asagidaki python kodunu biliyorsaniz kendiniz python'da bilmiyorsaniz birlikte google colab'de calistiracagiz. Once samtools kullanarak derinlik dosyasini uretin. Gerekiyorsa onu sisteminize kopyalayin.
```
			samtools depth alignment_sorted.bam > depth.csv

			# bu kisim python'da
			import matplotlib.pyplot as plt
			import numpy as np
			import pandas as pd
			dataset = pd.read_csv('depth.csv', sep='\t', names=["Chr", "Position", "Depth"])
			dataset
 ```     
  # Varyantlari bulmak

Varyantlari tespit demek referans genom ve elimizdeki dizi arasindaki mutasyonlari bulacağız demek. Bunun icin bcftools’u kullanacagiz. 

Kullandigimiz yerlestirme teknikleri kisa dizileri dogru yerlerine her zaman cok yuksek kesinlikte yerlestiremeyebilir. Ornegin, referans genomda uzun bir tekrar dizisinin icinde yer alan kisa bir dizi pekala tekrar dizisinin baska yerlerine de yerlesebilir. Bu durumda kullandigimiz program uygun yerlerden herhangi birini rastgele secmek durumunda kalir. Bu da yerlestirme guvenilirligini azaltir. Yerlestirme programlari yerlestirme guvenilirliklerini tipki dizileme kaliteleri gibi skorlarlar. Yerlestirme skoru 10 olan bir dizinin yanlis yere yerlestirilmis olma ihtimali yuzde ondur. Dolayisiyla dizileme kalitesine gore degil yerlestirme kalitesine gore de filtreleme yapmamiz gerekebilir. 

- Varyantlari bulalim:
```
			bcftools mpileup -f ref.fasta alignment_sorted.bam | bcftools call -mv -Ov -o calls.vcf
			bcftools mpileup -f ref.fasta alignment_sorted.bam | bcftools call -mv -Oz -o calls.vcf.gz
  ```

 Eger vaktin varsa, vcf dosyani acip yandaki link yardimiyla icerigini anlamaya calisabilirsin: http://samtools.github.io/hts-specs/VCFv4.2.pdf
 
- VCF dosyasini analiz etmek icin varyantlarin indexlenmesi gerekebilir. Bunun icin asagidaki komutu girecegiz:
```
			bcftools index calls.vcf.gz
		
  ```     
  # Varyantlara ilk Analiz
  
- VCF dosyasinin icinde ne var? Bcftools’un çok yararlı bir istatistik komutu bize bunu soyleyebilir: 
```
			bcftools stats calls.vcf.gz
 ```     
