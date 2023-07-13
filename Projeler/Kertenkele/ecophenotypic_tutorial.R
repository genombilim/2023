#### heremites sexual dimorphism and geographic variation

### bringing data to working script
hvdata <- read.csv('/Users/user/Desktop/derffff/hv_all.csv', sep = ";")
hvdata

# Exploring the lizard data set 

print(head(hvdata, 10))
print(str(hvdata))



Check that your observations are independent.
Sample sizes:
  In case of small samples, test the normality of residuals:
  If normality is assumed, test the homogeneity of the variances:
  If variances are equal, use ANOVA.
If variances are not equal, use the Welch ANOVA.
If normality is not assumed, use the Kruskal-Wallis test.
In case of large samples normality is assumed, so test the homogeneity of the variances:
  If variances are equal, use ANOVA.
If variances are not equal, use the Welch ANOVA.

# Assess the normality of the data in R
Case of large sample sizes
If the sample size is large enough (n > 30), we can ignore the distribution of the data and use parametric tests.

The central limit theorem tells us that no matter what distribution things have, the sampling distribution tends to be normal if the sample is large enough (n > 30).

However, to be consistent, normality can be checked by visual inspection [normal plots (histogram), Q-Q plot (quantile-quantile plot)] or by significance tests].
# Visual methods
set.seed(1234)
install.packages("ggpubr")
library(ggpubr)
ggdensity(hvdata$SVL, 
          main = "Density plot of SVL",
          xlab = "SVL")
Normality test
Visual inspection, described in the previous section, is usually unreliable. 
It’s possible to use a significance test comparing the sample distribution to a normal one in order to ascertain whether data show or not a serious deviation from normality.

There are several methods for normality test such as Kolmogorov-Smirnov (K-S) normality test and Shapiro-Wilk’s test.

#checking if the variables are normally distributed or not

In shapiro test, The null hypothesis is states that the population is normally distributed 
i.e if the p-value is greater than 0.05, then the null hypothesis is accepted.


shapiro.test(hvdata$SVL)
shapiro.test(hvdata$HL)
shapiro.test(hvdata$HW)
shapiro.test(hvdata$HH)
shapiro.test(hvdata$FLL)
shapiro.test(hvdata$HLL)
shapiro.test(hvdata$EL)
shapiro.test(hvdata$NED)
shapiro.test(hvdata$EED)
shapiro.test(hvdata$IORD)
shapiro.test(hvdata$SW)
shapiro.test(hvdata$TD)
shapiro.test(hvdata$TOL)
shapiro.test(hvdata$FIL)
shapiro.test(hvdata$FIPL)
shapiro.test(hvdata$IPW)
shapiro.test(hvdata$PW)
shapiro.test(hvdata$PL)
shapiro.test(hvdata$MSOL)
shapiro.test(hvdata$SDLT)
shapiro.test(hvdata$SDLF)
shapiro.test(hvdata$NSL)
shapiro.test(hvdata$NIL)
shapiro.test(hvdata$NDS)
shapiro.test(hvdata$NVS)
shapiro.test(hvdata$RVS)
shapiro.test(hvdata$NEE)

# the histogram shows that the curve is mildly left skewed in nature shapiro.test(data_2) 
# As the test returns a p-value lower than 0.05, 
we reject the null hypothesis and conclude that the population data is not normally distributed.#

#Levene's Test for Homogeneity of Variance (center = median)

library(car)

leveneTest(HW ~ GROUP, data = hvdata)
leveneTest(HH ~ GROUP, data = hvdata)
leveneTest(FLL ~ GROUP, data = hvdata)
leveneTest(HLL ~ GROUP, data = hvdata)
leveneTest(EL ~ GROUP, data = hvdata)
leveneTest(IORD ~ GROUP, data = hvdata)
leveneTest(TD ~ GROUP, data = hvdata)
leveneTest(TOL ~ GROUP, data = hvdata)
leveneTest(FIL ~ GROUP, data = hvdata)
leveneTest(PW ~ GROUP, data = hvdata)
leveneTest(PL ~ GROUP, data = hvdata)

#anova
set.seed(1234)
dplyr::sample_n(hvdata, 10)
# Show the levels
levels(hvdata$GROUP)
library(dplyr)


#Visualize your data
install.packages("ggpubr")
# Box plots
# ++++++++++++++++++++
# Plot weight by group and color by group
library("ggpubr")
ggboxplot(hvdata, x = "GROUP", y = "HW", 
          color = "GROUP", 
          order = c("Arabian_male", "Arabian_female", "Anatolian_male", "Anatolian_female"),
          ylab = "HW", xlab = "Group")
# Mean plots
# ++++++++++++++++++++
# Plot weight by group
# Add error bars: mean_se
# (other values include: mean_sd, mean_ci, median_iqr, ....)

library("ggpubr")

ggline(hvdata, x = "GROUP", y = "HW", 
       add = c("mean_se", "jitter"), 
       order = c("Arabian_male", "Arabian_female", "Anatolian_male", "Anatolian_female"),
       ylab = "HW", xlab = "Group")

# Compute the analysis of variance

res.aov <- aov(HW ~ GROUP, data = hvdata)
res.aov <- aov(HH ~ GROUP, data = hvdata)
res.aov <- aov(FLL ~ GROUP, data = hvdata)
res.aov <- aov(HLL ~ GROUP, data = hvdata)
res.aov <- aov(EL ~ GROUP, data = hvdata)
res.aov <- aov(IORD ~ GROUP, data = hvdata)
res.aov <- aov(TD ~ GROUP, data = hvdata)
res.aov <- aov(TOL ~ GROUP, data = hvdata)
res.aov <- aov(FIL ~ GROUP, data = hvdata)
res.aov <- aov(PW ~ GROUP, data = hvdata)
res.aov <- aov(PL ~ GROUP, data = hvdata)

# Summary of the analysis
summary(res.aov)

#The output includes the columns F value and Pr(>F) corresponding to the p-value of the test.
As the ANOVA test is significant, we can compute Tukey HSD (Tukey Honest Significant Differences, R function: TukeyHSD()) for performing multiple pairwise-comparison between the means of groups.

The function TukeyHD() takes the fitted ANOVA as an argument.

TukeyHSD(res.aov)
diff: difference between means of the two groups
lwr, upr: the lower and the upper end point of the confidence interval at 95% (default)
p adj: p-value after adjustment for the multiple comparisons.

# Compute the analysis of variance in non-normalized data
#Compute Kruskal-Wallis test
We want to know if there is any significant difference between the average weights of plants in the 3 experimental conditions.

The test can be performed using the function kruskal.test() as follow:
  
kruskal.test(SVL ~ GROUP, data = hvdata)
kruskal.test(HL ~ GROUP, data = hvdata)
kruskal.test(HLL ~ GROUP, data = hvdata)
kruskal.test(NED ~ GROUP, data = hvdata)
kruskal.test(EED ~ GROUP, data = hvdata)
kruskal.test(SW ~ GROUP, data = hvdata)
kruskal.test(FIPL ~ GROUP, data = hvdata)
kruskal.test(MSOL ~ GROUP, data = hvdata)
kruskal.test(IPW ~ GROUP, data = hvdata)
kruskal.test(SDLT ~ GROUP, data = hvdata)
kruskal.test(SDLF ~ GROUP, data = hvdata)
kruskal.test(NSL ~ GROUP, data = hvdata)
kruskal.test(NIL ~ GROUP, data = hvdata)
kruskal.test(NDS ~ GROUP, data = hvdata)
kruskal.test(NVS ~ GROUP, data = hvdata)
kruskal.test(RVS ~ GROUP, data = hvdata)
kruskal.test(NEE ~ GROUP, data = hvdata)


Interpret
As the p-value is less than the significance level 0.05, we can conclude that there are significant differences between the treatment groups.

Multiple pairwise-comparison between groups
From the output of the Kruskal-Wallis test, we know that there is a significant difference between groups, but we don’t know which pairs of groups are different.

It’s possible to use the function pairwise.wilcox.test() to calculate pairwise comparisons between group levels with corrections for multiple testing.

pairwise.wilcox.test(hvdata$SVL, hvdata$GROUP,
                     p.adjust.method = "BH")





df <- hvdata
head(df)


# PCA heremites #

d <- hvdata[c(7,8,11,12,14,19,22,23)]
d
pca_mod <- prcomp(d)
pca_mod
summary(pca_mod)
?prcomp
?princomp
?prcomp

# Data frame of principal components ----------------------

df_pc <- data.frame(pca_mod$x)
df_pc
##

## BETTER INTERFACE
# alternative USE IT

hv_pca <- prcomp(hvdata[,c(7,8,11,12,14,19,20,22,23)], center = TRUE,scale. = TRUE)
summary(hv_pca)
str(hv_pca)


hv.pr <- prcomp(hvdata[c(7,8,11,12,14,22,23)], center = TRUE)
summary(hv.pr)
screeplot(hv.pr, type = "l", npcs = 7, main = "Screeplot of 7 PCs")
abline(h = 1, col="red", lty=5)
legend("topright", legend=c("Eigenvalue = 1"),
       col=c("red"), lty=5, cex=0.6)
cumpro <- cumsum(hv.pr$sdev^2 / sum(hv.pr$sdev^2))
plot(cumpro[0:6], xlab = "PC #", ylab = "Amount of explained variance", main = "Cumulative variance plot")
abline(v = 3, col="blue", lty=5)
abline(h = 0.995, col="blue", lty=5)
legend("topleft", legend=c("Cut-off @ PC3"),
       col=c("blue"), lty=5, cex=0.6)
plot(hv.pr$x[,1],hv.pr$x[,2], xlab="PC1 (97.13%)", ylab = "PC2 (1.8%)", main = "PC1 / PC2 - plot")


# Eigenvalues
library(factoextra)
eig.val <- get_eigenvalue(hv_pca)
eig.val
fviz_eig(hv_pca)

# Results for Variables
res.var <- get_pca_var(hv_pca)
res.var$coord          # Coordinates
res.var$contrib        # Contributions to the PCs
res.var$cos2           # Quality of representation 
# Results for individuals
res.ind <- get_pca_ind(hv_pca)
res.ind$coord          # Coordinates
res.ind$contrib        # Contributions to the PCs
res.ind$cos2           # Quality of representation


#BIPLOT

library("factoextra")
fviz_pca_biplot(hv_pca, geom.ind = "point", pointshape = 21, geom.var = c("arrow", "text"),
                pointsize = 2, xlab="PC1 (61.13%)", ylab="PC2 (12.11%)",
                fill.ind = hvdata$GROUP,
                col.ind = "black", 
                palette = "lancet", 
                addEllipses = TRUE,
                label = "var",
                col.var = "black",
                repel = TRUE,
                legend.title = "GeographyxSex") +
  ggtitle("2D PCA-biplot from 9 feature dataset") +
  theme(plot.title = element_text(hjust = 0.5))

#

###




