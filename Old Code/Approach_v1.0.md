Analysis Approach
========================================================





```r
# Downloading the data
data(mtcars)

#Analyzing data set
str(mtcars)
```

```
## 'data.frame':	32 obs. of  11 variables:
##  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
##  $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
##  $ disp: num  160 160 108 258 360 ...
##  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
##  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
##  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
##  $ qsec: num  16.5 17 18.6 19.4 17 ...
##  $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
##  $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
##  $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
##  $ carb: num  4 4 1 1 2 1 4 2 2 4 ...
```

```r
summary(mtcars)
```

```
##       mpg            cyl            disp             hp       
##  Min.   :10.4   Min.   :4.00   Min.   : 71.1   Min.   : 52.0  
##  1st Qu.:15.4   1st Qu.:4.00   1st Qu.:120.8   1st Qu.: 96.5  
##  Median :19.2   Median :6.00   Median :196.3   Median :123.0  
##  Mean   :20.1   Mean   :6.19   Mean   :230.7   Mean   :146.7  
##  3rd Qu.:22.8   3rd Qu.:8.00   3rd Qu.:326.0   3rd Qu.:180.0  
##  Max.   :33.9   Max.   :8.00   Max.   :472.0   Max.   :335.0  
##       drat            wt            qsec            vs       
##  Min.   :2.76   Min.   :1.51   Min.   :14.5   Min.   :0.000  
##  1st Qu.:3.08   1st Qu.:2.58   1st Qu.:16.9   1st Qu.:0.000  
##  Median :3.69   Median :3.33   Median :17.7   Median :0.000  
##  Mean   :3.60   Mean   :3.22   Mean   :17.8   Mean   :0.438  
##  3rd Qu.:3.92   3rd Qu.:3.61   3rd Qu.:18.9   3rd Qu.:1.000  
##  Max.   :4.93   Max.   :5.42   Max.   :22.9   Max.   :1.000  
##        am             gear           carb     
##  Min.   :0.000   Min.   :3.00   Min.   :1.00  
##  1st Qu.:0.000   1st Qu.:3.00   1st Qu.:2.00  
##  Median :0.000   Median :4.00   Median :2.00  
##  Mean   :0.406   Mean   :3.69   Mean   :2.81  
##  3rd Qu.:1.000   3rd Qu.:4.00   3rd Qu.:4.00  
##  Max.   :1.000   Max.   :5.00   Max.   :8.00
```

```r
#Searching for missing values
table(is.na(mtcars))
```

```
## 
## FALSE 
##   352
```

```r
#creating tidy data set
tidy <- mtcars

#CREATE a matrix scatter plot to show the relationships and indentify which are factor variables
scatterplotMatrix(tidy, spread=FALSE, lty.smooth=2,
                                     main="Scatter Plot Matrix")
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1.png) 

From the above analysis, factor variables are:
1. $cyl
2. $vs
3. $am
4. $gear
5. $carb



```r
# creating factor variables
tidy$am <- as.factor(mtcars$am)
tidy$cyl <- as.factor(mtcars$cyl)
tidy$gear <- as.factor(mtcars$gear)
tidy$carb <- as.factor(mtcars$carb)
tidy$vs <- as.factor(mtcars$vs)

tidy$am <- factor(mtcars$am, levels=c(0,1),
labels=c("Automatic", "Manual"))
```




```r
# Analyzing if automatic vs manual is better for MPG
boxplot(mpg~am, data=tidy, xlab="Transmission Type", ylab="Miles per Gallon (MPG)",
main="MGP by Transmission Type")
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 


```r
meanTransmission <- with(tidy, tapply(mpg,am, FUN=mean))
print(meanTransmission)
```

```
## Automatic    Manual 
##     17.15     24.39
```

We see that miles per gallon is better as estimate = 24.3923.



```r
fit1 <- stepAIC(lm(data=tidy,mpg~.,direction="both",test="F"))
```

```
## Start:  AIC=76.4
## mpg ~ cyl + disp + hp + drat + wt + qsec + vs + am + gear + carb
## 
##        Df Sum of Sq RSS  AIC
## - carb  5     13.60 134 69.8
## - gear  2      3.97 124 73.4
## - am    1      1.14 122 74.7
## - qsec  1      1.24 122 74.7
## - drat  1      1.82 122 74.9
## - cyl   2     10.93 131 75.2
## - vs    1      3.63 124 75.4
## <none>              120 76.4
## - disp  1      9.97 130 76.9
## - wt    1     25.55 146 80.6
## - hp    1     25.67 146 80.6
## 
## Step:  AIC=69.83
## mpg ~ cyl + disp + hp + drat + wt + qsec + vs + am + gear
## 
##        Df Sum of Sq RSS  AIC
## - gear  2      5.02 139 67.0
## - disp  1      0.99 135 68.1
## - drat  1      1.19 135 68.1
## - vs    1      3.68 138 68.7
## - cyl   2     12.56 147 68.7
## - qsec  1      5.26 139 69.1
## <none>              134 69.8
## - am    1     11.93 146 70.6
## - wt    1     19.80 154 72.2
## - hp    1     22.79 157 72.9
## 
## Step:  AIC=67
## mpg ~ cyl + disp + hp + drat + wt + qsec + vs + am
## 
##        Df Sum of Sq RSS  AIC
## - drat  1      0.97 140 65.2
## - cyl   2     10.42 149 65.3
## - disp  1      1.55 141 65.4
## - vs    1      2.18 141 65.5
## - qsec  1      3.63 143 65.8
## <none>              139 67.0
## - am    1     16.57 156 68.6
## - hp    1     18.18 157 68.9
## - wt    1     31.19 170 71.5
## 
## Step:  AIC=65.23
## mpg ~ cyl + disp + hp + wt + qsec + vs + am
## 
##        Df Sum of Sq RSS  AIC
## - disp  1      1.25 141 63.5
## - vs    1      2.34 142 63.8
## - cyl   2     12.33 152 63.9
## - qsec  1      3.10 143 63.9
## <none>              140 65.2
## - hp    1     17.74 158 67.0
## - am    1     19.47 160 67.4
## - wt    1     30.72 171 69.6
## 
## Step:  AIC=63.51
## mpg ~ cyl + hp + wt + qsec + vs + am
## 
##        Df Sum of Sq RSS  AIC
## - qsec  1       2.4 144 62.1
## - vs    1       2.7 144 62.1
## - cyl   2      18.6 160 63.5
## <none>              141 63.5
## - hp    1      18.2 159 65.4
## - am    1      18.9 160 65.5
## - wt    1      39.6 181 69.4
## 
## Step:  AIC=62.06
## mpg ~ cyl + hp + wt + vs + am
## 
##        Df Sum of Sq RSS  AIC
## - vs    1       7.3 151 61.7
## <none>              144 62.1
## - cyl   2      25.3 169 63.2
## - am    1      16.4 160 63.5
## - hp    1      36.3 180 67.3
## - wt    1      41.1 185 68.1
## 
## Step:  AIC=61.65
## mpg ~ cyl + hp + wt + am
## 
##        Df Sum of Sq RSS  AIC
## <none>              151 61.7
## - am    1       9.8 161 61.7
## - cyl   2      29.3 180 63.3
## - hp    1      31.9 183 65.8
## - wt    1      46.2 197 68.2
```

```r
summary(fit1)
```

```
## 
## Call:
## lm(formula = mpg ~ cyl + hp + wt + am, data = tidy, direction = "both", 
##     test = "F")
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -3.939 -1.256 -0.401  1.125  5.051 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  33.7083     2.6049   12.94  7.7e-13 ***
## cyl6         -3.0313     1.4073   -2.15   0.0407 *  
## cyl8         -2.1637     2.2843   -0.95   0.3523    
## hp           -0.0321     0.0137   -2.35   0.0269 *  
## wt           -2.4968     0.8856   -2.82   0.0091 ** 
## amManual      1.8092     1.3963    1.30   0.2065    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.41 on 26 degrees of freedom
## Multiple R-squared:  0.866,	Adjusted R-squared:  0.84 
## F-statistic: 33.6 on 5 and 26 DF,  p-value: 1.51e-10
```

```r
fit2 <- lm(formula = mpg ~ cyl + hp + wt + am , data = tidy)
summary(fit2)
```

```
## 
## Call:
## lm(formula = mpg ~ cyl + hp + wt + am, data = tidy)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -3.939 -1.256 -0.401  1.125  5.051 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  33.7083     2.6049   12.94  7.7e-13 ***
## cyl6         -3.0313     1.4073   -2.15   0.0407 *  
## cyl8         -2.1637     2.2843   -0.95   0.3523    
## hp           -0.0321     0.0137   -2.35   0.0269 *  
## wt           -2.4968     0.8856   -2.82   0.0091 ** 
## amManual      1.8092     1.3963    1.30   0.2065    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.41 on 26 degrees of freedom
## Multiple R-squared:  0.866,	Adjusted R-squared:  0.84 
## F-statistic: 33.6 on 5 and 26 DF,  p-value: 1.51e-10
```

```r
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
plot(fit2)
```

<img src="figure/unnamed-chunk-4.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />

Hence, let's add interactions terms     



```r
fit3 <- lm(formula = mpg ~ cyl + hp + am+ wt + wt*am, data = tidy)
summary(fit3)
```

```
## 
## Call:
## lm(formula = mpg ~ cyl + hp + am + wt + wt * am, data = tidy)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -3.678 -1.568 -0.555  1.153  4.799 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  30.6525     2.9099   10.53  1.1e-10 ***
## cyl6         -2.3806     1.3736   -1.73    0.095 .  
## cyl8         -2.8991     2.1967   -1.32    0.199    
## hp           -0.0178     0.0148   -1.20    0.241    
## amManual      9.8986     4.2857    2.31    0.029 *  
## wt           -2.2069     0.8520   -2.59    0.016 *  
## amManual:wt  -3.1450     1.5848   -1.98    0.058 .  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.28 on 25 degrees of freedom
## Multiple R-squared:  0.884,	Adjusted R-squared:  0.856 
## F-statistic: 31.8 on 6 and 25 DF,  p-value: 1.55e-10
```

```r
anova(fit2,fit3)
```

```
## Analysis of Variance Table
## 
## Model 1: mpg ~ cyl + hp + wt + am
## Model 2: mpg ~ cyl + hp + am + wt + wt * am
##   Res.Df RSS Df Sum of Sq    F Pr(>F)  
## 1     26 151                           
## 2     25 130  1      20.6 3.94  0.058 .
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
plot(fit3)
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-51.png) ![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-52.png) ![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-53.png) ![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-54.png) 

temp

```r
fit3_1 <- lm(formula = mpg ~ hp + am+ wt + wt*am, data = tidy)
summary(fit3_1)
```

```
## 
## Call:
## lm(formula = mpg ~ hp + am + wt + wt * am, data = tidy)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -3.064 -1.332 -0.935  1.218  5.082 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  30.9473     2.7234   11.36  8.5e-12 ***
## hp           -0.0270     0.0098   -2.75   0.0105 *  
## amManual     11.5548     4.0233    2.87   0.0078 ** 
## wt           -2.5156     0.8445   -2.98   0.0061 ** 
## amManual:wt  -3.5779     1.4428   -2.48   0.0197 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.33 on 27 degrees of freedom
## Multiple R-squared:  0.87,	Adjusted R-squared:  0.85 
## F-statistic:   45 on 4 and 27 DF,  p-value: 1.45e-11
```
temp


```r
# Remocing hp
fit4_1 <- lm(formula = mpg ~ cyl + am + wt, data = tidy)
summary(fit4_1)
```

```
## 
## Call:
## lm(formula = mpg ~ cyl + am + wt, data = tidy)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -4.490 -1.312 -0.504  1.416  5.776 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   33.754      2.813   12.00  2.5e-12 ***
## cyl6          -4.257      1.411   -3.02   0.0055 ** 
## cyl8          -6.079      1.684   -3.61   0.0012 ** 
## amManual       0.150      1.300    0.12   0.9089    
## wt            -3.150      0.908   -3.47   0.0018 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.6 on 27 degrees of freedom
## Multiple R-squared:  0.838,	Adjusted R-squared:  0.813 
## F-statistic: 34.8 on 4 and 27 DF,  p-value: 2.73e-10
```

```r
fit4_2 <- lm(formula = mpg ~ cyl + am + wt+ wt*am, data = tidy)
summary(fit4_2)
```

```
## 
## Call:
## lm(formula = mpg ~ cyl + am + wt + wt * am, data = tidy)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -3.541 -1.538 -0.678  1.316  5.283 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   29.775      2.840   10.48  7.9e-11 ***
## cyl6          -2.710      1.357   -2.00   0.0565 .  
## cyl8          -4.776      1.556   -3.07   0.0050 ** 
## amManual      11.569      4.088    2.83   0.0089 ** 
## wt            -2.399      0.844   -2.84   0.0086 ** 
## amManual:wt   -4.068      1.397   -2.91   0.0073 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.3 on 26 degrees of freedom
## Multiple R-squared:  0.877,	Adjusted R-squared:  0.854 
## F-statistic: 37.2 on 5 and 26 DF,  p-value: 4.74e-11
```

```r
anova(fit2,fit3, fit4_1, fit4_2)
```

```
## Analysis of Variance Table
## 
## Model 1: mpg ~ cyl + hp + wt + am
## Model 2: mpg ~ cyl + hp + am + wt + wt * am
## Model 3: mpg ~ cyl + am + wt
## Model 4: mpg ~ cyl + am + wt + wt * am
##   Res.Df RSS Df Sum of Sq    F Pr(>F)   
## 1     26 151                            
## 2     25 130  1      20.6 3.94  0.058 . 
## 3     27 183 -2     -52.5 5.03  0.015 * 
## 4     26 138  1      45.0 8.62  0.007 **
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

Hence its model 4_2 that we choose!

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8.png) 
## Let's analyze outliers


```r
cutoff <- 4/(nrow(tidy)-length(fit4_2$coefficients)-1)
plot(fit4_2, which=4, cook.levels=cutoff)
abline(h=cutoff, col="red")
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9.png) 


```r
influencePlot(fit4_2, id.method="noteworthy", main="Influence Plot",
sub="Circle size is proportional to Cook's distance")
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10.png) 

```
##                StudRes    Hat  CookD
## Fiat 128        2.7046 0.1065 0.3419
## Toyota Corolla  2.2401 0.1520 0.3603
## Maserati Bora   0.8629 0.4222 0.3026
```



```r
removingVal <- rownames(tidy) %in% c("Toyota Corolla", "Fiat 128", "Chrysler Imperial", "Maserati Bora")
tidy2<- tidy
tidy2$Cars <- rownames(tidy2)
tidy2 <- tidy[!removingVal,]
#print(tidy2)
fit5 <- lm(formula = mpg ~ cyl + am+ wt + wt*am , data = tidy2)
summary(fit5)
```

```
## 
## Call:
## lm(formula = mpg ~ cyl + am + wt + wt * am, data = tidy2)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -2.371 -1.029 -0.124  1.110  3.618 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   31.408      2.358   13.32  5.2e-12 ***
## cyl6          -1.715      1.032   -1.66  0.11067    
## cyl8          -4.069      1.173   -3.47  0.00218 ** 
## amManual       8.625      3.522    2.45  0.02275 *  
## wt            -3.058      0.717   -4.27  0.00032 ***
## amManual:wt   -3.485      1.262   -2.76  0.01139 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.7 on 22 degrees of freedom
## Multiple R-squared:  0.912,	Adjusted R-squared:  0.892 
## F-statistic: 45.6 on 5 and 22 DF,  p-value: 6.89e-11
```

```r
plot(fit5)
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-111.png) ![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-112.png) ![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-113.png) ![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-114.png) 

```r
anova(fit4_2, fit5) 
```

```
## Error: models were not all fitted to the same size of dataset
```


```r
#Doing further residual analysis - Normality
qqPlot(fit5, labels=row.names(tidy2), id.method="identify",
simulate=TRUE, main="Q-Q Plot")
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-12.png) 

```r
# Look at verbage around Q-Q plot when writing this up p.193


# residplot <- function(fit, nbreaks=10) {
# z <- rstudent(fit)
# hist(z, breaks=nbreaks, freq=FALSE,
# xlab="Studentized Residual",
# main="Distribution of Errors")
# rug(jitter(z), col="brown")
# curve(dnorm(x, mean=mean(z), sd=sd(z)),
# add=TRUE, col="blue", lwd=2)
# lines(density(z)$x, density(z)$y,
# col="red", lwd=2, lty=2)
# legend("topright",
# legend = c( "Normal Curve", "Kernel Density Curve"),
# lty=1:2, col=c("blue","red"), cex=.7)
# }
# residplot(fit5)
```


```r
# INDEPENDENCE OF ERRORS
durbinWatsonTest(fit5)
```

```
##  lag Autocorrelation D-W Statistic p-value
##    1         -0.1473         2.291   0.634
##  Alternative hypothesis: rho != 0
```
The nonsignificant p-value suggests a lack of autocorrelation, and conversely an independence of errors.



```r
# HOMOSCEDASTICITY
ncvTest(fit5)
```

```
## Non-constant Variance Score Test 
## Variance formula: ~ fitted.values 
## Chisquare = 0.5235    Df = 1     p = 0.4694
```

```r
spreadLevelPlot(fit5)
```

![plot of chunk unnamed-chunk-14](figure/unnamed-chunk-14.png) 

```
## 
## Suggested power transformation:  1.85
```


```r
# Global Validation of the Model
gvmodel<- gvlma(fit5)
summary(gvmodel)
```

```
## 
## Call:
## lm(formula = mpg ~ cyl + am + wt + wt * am, data = tidy2)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -2.371 -1.029 -0.124  1.110  3.618 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   31.408      2.358   13.32  5.2e-12 ***
## cyl6          -1.715      1.032   -1.66  0.11067    
## cyl8          -4.069      1.173   -3.47  0.00218 ** 
## amManual       8.625      3.522    2.45  0.02275 *  
## wt            -3.058      0.717   -4.27  0.00032 ***
## amManual:wt   -3.485      1.262   -2.76  0.01139 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.7 on 22 degrees of freedom
## Multiple R-squared:  0.912,	Adjusted R-squared:  0.892 
## F-statistic: 45.6 on 5 and 22 DF,  p-value: 6.89e-11
## 
## 
## ASSESSMENT OF THE LINEAR MODEL ASSUMPTIONS
## USING THE GLOBAL TEST ON 4 DEGREES-OF-FREEDOM:
## Level of Significance =  0.05 
## 
## Call:
##  gvlma(x = fit5) 
## 
##                     Value p-value                Decision
## Global Stat        1.0699   0.899 Assumptions acceptable.
## Skewness           0.6569   0.418 Assumptions acceptable.
## Kurtosis           0.1788   0.672 Assumptions acceptable.
## Link Function      0.0247   0.875 Assumptions acceptable.
## Heteroscedasticity 0.2096   0.647 Assumptions acceptable.
```


```r
sqrt(vif(fit5))
```

```
##        GVIF    Df GVIF^(1/(2*Df))
## cyl   1.678 1.414           1.138
## am    5.263 1.000           2.294
## wt    1.986 1.000           1.409
## am:wt 4.649 1.000           2.156
```

There could be a VIF problem for am
