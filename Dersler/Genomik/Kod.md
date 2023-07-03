# Genomics Pratigi:

Asagidaki kodlari tek tek terminalinize kopyalayip yapistiracaksiniz. Sondaki noktalari unutmak, tirnak isaretlerindeki duzeltmeler hataya sebep olur. Mutlaka ayni seyi yapitirdiginiza emin olun. 

- Ilk olarak terminali acin. 
- Once asagidaki kodu kullanarak ssh ile bizim truba hesabimiza baglanin:
 ```
			ssh 
``` 
- Trubaya baglaninca ilk olarak kendinize ait bir dizin olusturun. Zaten ilk dersete oluturduysaniz da onu kullanin. Icine genomik diye baska bir dizin olusturun. cd dedikten sonra <isminiz> kismini silip kendi isminize actiginiz dizin ismini yazin.

```
			cd <isminiz>
			mkdir Genomik
			cd Genomik

```
- Programlari hesabiniza yuklemek icin asagidaki satiri girin:
```
			 
```
- Okumalarinizi indirin fastq-dump'i kullanarak:  

```
			fastq-dump -I --split-files SRR1583053
			cp SRR1583053_1.fastq reads.fastq
  ```  
  # Filtreleme
 
 - Okumalarinizin kalitesine bakin. Burada okumalarinizi kendi sisteminize kopyalayip fastqc'yi oradan kullanmaniz gerekebilir.
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
