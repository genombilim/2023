# Giriş

Bu proje kapsamında Jensen et al. 2019 makalesinde belirtilen 5700 yıllık antik sakızlardan elde edilen antik DNA dizlerini metagenomik bir bakış açısıyla inceleyceğiz ve örnek içerisindeki bakteriyel içeriğini tespit edeceğiz.

Ardından, bu örnek içerisinde bulunan bazı bakterilere ait DNA dizlerini alarak, antk DNA onayalama süreçlerinden geçirerek, deaminasyon profillerini elde edeceğiz.


## Proje adımları

Projede kullanılacak *fastq* okumalarını indirmek için aşağıdaki komutu kullanacağız:

```bash
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR325/004/ERR3250144/ERR3250144.fastq.gz
```

Daha sonra, bu *fastq* dosyası içerisinde bulunan fastq okumalarını, Kraken2 (Wood and Salzberg, 2014) isimli araç yardımıyla sınıflandıracağız.

Elimizdeki taksonomik içeriği R istatistiksel paketi ile görselleştirmeye çalışacağız.

Ardından, ağız mikrobiyotasına ait olan *Streptococcus pneumoniae* ile eşleşmiş DNA okumalarını elde edeceğiz.

Son olarak, *bwa* (Li and Durbin, 2009) programı ile bu okumaları *S. pneumoniae* referans genomuna hizalayacağız ve *mapDamage2* (Jónsson et al., 2013) isimli programla deaminasyon profillerini elde edeceğiz.

## Metdoloji


### Kraken2 veri tabanı

Çalışmada kullanılacak veri tabanını [şu bağlantıdan](https://genome-idx.s3.amazonaws.com/kraken/k2_standard_08gb_20230605.tar.gz) indirebilirsiniz. Ya da terminal üzerinden aşağıdaki satırı yazalım:

```bash
wget https://genome-idx.s3.amazonaws.com/kraken/k2_standard_08gb_20230605.tar.gz
```

Arından veri tabanını açalım:

```bash
tar -xzf https://genome-idx.s3.amazonaws.com/kraken/k2_standard_08gb_20230605.tar.gz

```

Bu veri tabanı NCBI RefSeq veri tabanında bulunan Arke, Bakteri, Viral diziler, ve Mantarları içeren ve 8GB olacak şekilde organize edilmiştir. Bu sayede en fazla 8GB hafızası bulunan sistemlerde kullanabilirsiniz.

Aynı zamanda Kraken2 veri tabanı aşağıdaki klasör içerisinde de bulunmaktadır:

```
/truba/home/egitim/evogen/Emrah/anmet4evogen/proje-1/data/databases/kraken2
```



## Kaynakça

Jensen, Theis Z. T., Jonas Niemann, Katrine Højholt Iversen, Anna K. Fotakis, Shyam Gopalakrishnan, Åshild J. Vågene, Mikkel Winther Pedersen, et al. “A 5700 Year-Old Human Genome and Oral Microbiome from Chewed Birch Pitch.” Nature Communications 10, no. 1 (December 17, 2019): 5520. https://doi.org/10.1038/s41467-019-13549-9.

Wood, Derrick E., and Steven L. Salzberg. “Kraken: Ultrafast Metagenomic Sequence Classification Using Exact Alignments.” Genome Biology 15, no. 3 (March 3, 2014): R46. https://doi.org/10.1186/gb-2014-15-3-r46.

Jónsson, Hákon, Aurélien Ginolhac, Mikkel Schubert, Philip L. F. Johnson, and Ludovic Orlando. “mapDamage2.0: Fast Approximate Bayesian Estimates of Ancient DNA Damage Parameters.” Bioinformatics 29, no. 13 (July 1, 2013): 1682–84. https://doi.org/10.1093/bioinformatics/btt193.

Li, Heng, and Richard Durbin. “Fast and Accurate Short Read Alignment with Burrows–Wheeler Transform.” Bioinformatics 25, no. 14 (July 15, 2009): 1754–60. https://doi.org/10.1093/bioinformatics/btp324.

