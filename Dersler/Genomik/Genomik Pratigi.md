# Bioenformatik:

Yeni nesil dizileme (NGS) metotlari o kadar buyuk bir veri uretiyor ki bunu analiz etmek projeler icin onemli bir zorluk teskil ediyor. Arastirmacilar bu buyuklukteki verilerle basa cikabilmek icin oldukca guclu bilgisayarlara ve isletim sistemlerine ihtiyac duyuyorlar. Biyoinformatik bu ihtiyaclari karsilamak amaciyla cikmis bir araclar ve yaklasimlar butunudur. Biyoinformatikci, biyoloji ve bilgisayar bilimi arasinda kopru gorevi gorur. Gunumuzde pek cok universite bu konuda lisans veya yuksek lisans programlari sunsa da biyoinformatik aslen kendi cabamizla da ogrenebilecegimiz bir branstir. 

Bu okulda son yillarda biyoinformatigin en ihtiyac duyuldugu alan olan dizilemedeki kullanimlarini ogrenecegiz. Bu amacla herkes bir bireyin kisa mitogenom dizilerini insan referans genomuna gore hizalayacak, ve mutasyonlari bulacak.

Bu islemleri yapmak icin hal-i hazirda pek cok biyoinformatik araci zaten internette mevcut. Bu araclarin onemli bir kismi terminal dedigimiz komut satirlarindan calistirilabiliyor. Bu da ancak linux/unix bazli isletim sistemlerinde mumkun. Dolayisiyla okulumuz surecinde linux isletim sisteminde calisacagiz. 

# Haydi Baslayalim: Genomik Dosyamizi Olusturalim

Asagidaki kodlari tek tek terminalinize kopyalayip yapistiracaksiniz. Sondaki noktalari unutmak, tirnak isaretlerindeki duzeltmeler hataya sebep olur. Mutlaka ayni seyi yapitirdiginiza emin olun. 

- Ilk olarak terminali acin. 
- Once asagidaki kodu kullanarak ssh ile bizim truba hesabimiza baglanin:
 ```
			ssh egitim20@193.140.99.61 -p 1212
			şifre: 

			Levrek1'e yönlendirilmek için;

			ssh egitimXX@levrek1
			Şifre: sana verilen şifre

``` 
- Trubaya baglaninca ilk olarak kendinize ait bir dizin olusturun. Zaten ilk derste oluturduysaniz da onu kullanin. Icine genomik diye baska bir dizin olusturun. cd dedikten sonra <isminiz> kismini silip kendi isminize actiginiz dizin ismini yazin.

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

Bu komut iki tane dosya indirecek: one dogru diziler icin SRR…_1.fastq ve arkaya dogru diziler icin SRR…_2.fastq. Iki tane dosya olmasinin sebebi dizilerin paired-end teknolojisiyle uretilmis olmasi.  Paired-end, asagida da gordugun gibi bir fragmanin iki ucundan dizilenmesini saglar, bu sayede cok daha yuksek kalitede bir dizi elde edilir. Biz kolaylik acisindan bu derste sadece one dogru uzanan dizilerle calisacagiz.

![paired-end1](https://github.com/genombilim/2023/assets/37342417/3a672293-bb62-41b7-a361-0877512b8519)

Haydi indirdigimiz dosyaya bakalim. Neler dikkatinizi cekiyor? 
```
			head reads.fastq
  ```
![Screen-Shot-2018-01-07-at-3 40 32-PM-1024x354](https://github.com/genombilim/2023/assets/37342417/1a2bed3d-f76d-442d-b74d-bf32657b3c3b)

  # Filtreleme
 
Okumalarinizin kalitesinden bahsettik. Nedir bu kalite? Bir bazin  Phred kalite skoru, Q, o bazin hatali okunma ihtimali P’nin logaritmasidir.

 - 
 kalitesine bakin. Burada okumalarinizi kendi sisteminize kopyalayip fastqc'yi oradan kullanmaniz gerekebilir. Fastqc okuma kalitelerine bakabilelim diye yapilmis bir program. 
```
			fastqc
  ```
  
- Okumalarinizi kesip filtreleyecegiz. 
```
			fastx_trimmer -f 20 -l 240 -i reads.fastq -o reads_trimmed.fastq
			fastq_quality_filter -q 30 -p 95 -i reads_trimmed.fastq -o reads_filtered.fastq
  ```    
- Komut -h yazarak her bir komutun ne yaptigina bakin.
-  Simdi de bu websitesine bakin yaninizdaki kisi ile : http://hannonlab.cshl.edu/fastx_toolkit/commandline.html Listeden isinize yarayabilecek iki komut bulup sinifta paylasin. 
 
- Kesilmis ve filtrelenmis dosyalariniza da fastqc ile bakin. Ne goruyorsunuz?
```
			fastqc
  ```
  
  # Referans Genomuna Hizalamak
- Mitokondri icin refereans genomunu indirecegiz. Bunun icin UCSC genome browser'ina gidin, Download kismindan sirasiyla Human, Chromosomes Chromosome M'i bulun.. Link yazan kisma buldugunuz dosyanin linkini kopyalayin:
```
			wget ‘link’
			gunzip chrM.fa.gz
			cp chrM.fa ref.fasta
  ```    
- Referansa hizalayalim:
```
			bowtie2-build ref.fasta ref
			bowtie2 -x ref -q reads_filtered.fastq -S alignment.sam
			samtools faidx ref.fasta
			samtools view -bt ref.fasta.fai alignment.sam > alignment.bam
			samtools sort alignment.bam -o alignment_sorted.bam
			samtools index alignment_sorted.bam
 ```    
 
- Bakalim:
 ```   
			samtools tview -d C alignment_sorted.bam ref.fasta
 ```   
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
- Bulalim:
```
			bcftools mpileup -f ref.fasta alignment_sorted.bam | bcftools call -mv -Ov -o calls.vcf
			bcftools mpileup -f ref.fasta alignment_sorted.bam | bcftools call -mv -Oz -o calls.vcf.gz
  ```    
- Generate your first consensus sequence. Name it after yourself by replacing the <name> with your own.
```
			bcftools index calls.vcf.gz
			bcftools consensus calls.vcf.gz -f ref.fasta -o consensus.fasta
			fasta_formatter -i consensus.fasta -w 70 -o consensus_short.fasta
			cat consensus_short.fasta | sed -e 's/chrM/<name>/g' > <name>.fasta
  ```     
  # Draw a pylogenetic Tree
- Create a genomes files including yours and the population one:
```
			cat <your name>.fasta genomes/* > genomes.fasta
 ```     
- Create a phylogenetic tree
```
			clustalo -i genomes.fasta --outfmt=phylip -o genomes.phy
			dnaml
			figtree
```
To understand how dnaml works, go to its webiste https://evolution.genetics.washington.edu/phylip/doc/dnaml.html read through its assumptions. With a partner, discuss for each assumption how realistic they are and share what you discussed.
