---
title: "Antik Metagenomik Pratik"
author: "Emrah Kırdök, Ph.D."
date: "2023-07-12"

---

## Giriş

Öncelikle proje klasörümüz oluşturalım:

```bash
mkdir AnMet-Proje
mkdir -p AnMet-Proje/data
mkdir -p AnMet-Proje/results

cd AnMet-Proje
```

Şimdi de `${PATH}` değişkenini ayarlayalım. Pratik kapsamında kullanacağımız programlara bu şekilde erişebiliriz. Kullanacağımız betiklere de öncelikle bu satırı eklemeliyiz:

```bash
export PATH=/truba/home/egitim/miniconda3/envs/anmet4evogen/bin:${PATH}
```

## Metaphlan3 veri tabanı

Çalışmada kullanacağımız belirteç veri tabanı aşağıdaki klasördedir:

```bash
ls /truba/home/egitim/evogen/Emrah/anmet4evogen/proje-1/data/databases/metaphlan_databases
```

## DNA okumaları

Pratik kısımda kullanacağımız DNA okumaları aşağıda bulunmaktadır. Bu dosyaları kendi klasörümüze kopyalayalım:

```bash
ls /truba/home/egitim/evogen/Emrah/anmet4evogen/pratik/data
```

Dosyaları kopyalayalım:

```bash
cp /truba/home/egitim/evogen/Emrah/anmet4evogen/pratik/data/*gz data

ls data
```

şimdi ise Metaphlan sonuç klasöürmüzü oluşturalım. Biyoinformatik projelerinde bu önemlidir:

```bash
mkdir -p results/metaphlan
```

## Metapham3 kullanımı

Aşağıdaki komut ile bir dosyayı çalıştırabiliriz:


```bash
metaphlan data/SRS014459-Stool.fasta.gz \
        --input_type fasta \
        --bowtie2db /truba/home/egitim/evogen/Emrah/anmet4evogen/proje-1/data/databases/metaphlan_databases \
        -x mpa_v30_CHOCOPhlAn_201901 \
        --bowtie2out results/metaphlan/SRS014459-Stool.bowtie2out \ 
        -s results/metaphlan/SRS014459-Stool.sam > results/metaphlan/SRS014459-Stool.txt
```

Ancak metagenomik araçlar genellikle fazla hafıza ve işlemci gücü kullanırlar. O yüzden bu komutları bir `sbatch` dosyası ile çalıştırsak daha iyi olur:

```bash
cp /truba/home/egitim/evogen/Emrah/anmet4evogen/scripts/metaphlan.sh .
sbatch metaphlan.sh
```

Oluşan dosyalara bakalım. Önce rapor dosyası:

```bash
less results/metaphlan/SRS014459-Stool.txt
```

Şimdi de sam dosyası:

```bash
less results/metaphlan/SRS014459-Stool.sam
```

Şimdi ise diğer dosyaları için bu işi yapalım. Kolaylık olsun diye sbatch dosyasını modifiye ettim. Bu sayede aynı anda diğer okumaları da kuyruğa gönderebiliriz:

```bash
cp /truba/home/egitim/evogen/Emrah/anmet4evogen/scripts/metaphlan_param.sh .

```

Nasıl bir sbatch dosyası acaba bu?

```bash
less metaphlan_param.sh
```

Burada DNA okumalarının isimlerini bir komut satırı parametresi haline getirdik.

Diğer dosyaları da ardı arkasına gönderelim:

```bash
sbatch metaphlan_param.sh SRS014464-Anterior_nares
sbatch metaphlan_param.sh SRS014470-Tongue_dorsum
sbatch metaphlan_param.sh SRS014472-Buccal_mucosa
sbatch metaphlan_param.sh SRS014476-Supragingival_plaque
sbatch metaphlan_param.sh SRS014494-Posterior_fornix
```

İşimiz bitti mi acaba? 

```bash
squeue

```

Bittiğinde kontrol edelim:

```bash
ls results/metaphlan
```

## Tabloların birleştirilmesi

Elimizdeki frekans tablolarını birleştirelim şimdi

```bash
merge_metaphlan_tables.py results/metaphlan/*txt > results/merged-table.txt
```

Şimdi de sadece tür profillerini alalım:

```bash
  grep -E "s__|clade" merged-table.txt | sed 's/^.*s__//g'\ | cut -f1,3-8 | sed -e 's/clade_name/body_site/g' > merged_abundance_table_species.txt
```

## Isı haritası elde edelim

```bash
 hclust2.py -i merged_abundance_table_species.txt -o abundance_heatmap_species.png --f_dist_f braycurtis --s_dist_f braycurtis --cell_aspect_ratio 0.5 -l --flabel_size 10 --slabel_size 10 --max_flabel_len 100 --max_slabel_len 100 --minv 0.1 --dpi 300

 ```

 Bir ısı haritası elde edebiliriz bu şekilde.
