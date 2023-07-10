# Giriş

Acaba chatgpt nasıl çalışıyor? Ya da bir araba kendini nasıl sürüyor? Merak ediyor musununz?

Bir tahmin oyunu oynadığınızı varsayalım. Diyelim ki rastgele bir sayı tuttunuz, ve karşınızdaki kişiden bunu tahmin etmesini istiyorsunuz. Her tahminin sonucunda, sayıya olan yakınlığa bağlı olarak yukarı ve aşağı komutları ile yön veriyorsunuz ve yarışmacı belli bir süre sonra sizin aklınızda tuttuğunuz sayıya yaklaşmaya başlıyor.

Acaba ne oldu burada? 

+ Elimizde bir veri var (tahmin edilen sayı)
+ Tahmin yap 
+ Hatanı ölç (tahmin edilen sayıdan az veya fazla bilgisi)
+ Hatanı azaltacak yönde yeni bir tahmini yap
+ Bu şekilde tahmin edilen sayıyı bulana kadar devam et

Tebrikler, makine öğrenmesinin en önemli kavramlarından birisini öğrenmeye başladınız! 

## Projenin amacı

Bu projede, birbiriyle doğrusal ilişkiye sahip iki veri kümesini kullanacaksınız ve bu iki veri seti arasındaki doğrusal ilişkiyi açıklayan modelin parametrelerini, aşamalı azalış isimli bir yöntem ile optimize etmeye çalışacaksınız. 

Ardından geliştirdiğiniz bu yöntemi bir R fonskiyonu haline getirerek, biyolojik bir veri üzerine uygulayacaksınız.

## İçerik

Kullanacağınız basit veri set bir sonraki şekilde görülmektedir.

![Kullanılacak Veri Seti](fig1.png)

## Kullanılacak veri

Aşağıda simule edilmiş bir veri bulunmaktadır. Bununla işe başlayalım:

```R
library(ggplot2)
set.seed(123)

x <- runif(50, -5, 5)
y <- x + rnorm(50) + 3
df <- data.frame(y,x)

ggplot(data = df, aes(y=y,x=x)) + geom_point()
```


