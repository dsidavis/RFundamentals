# Random Variable Functions

The core R installation provides functions for working
with several common random variables.
There are r, d, p and q functions for 
the normal, exponential, cauchy, weibull,
poisson, binomial, ... random variables.
These are functions such as rnorm, rexp, 
dexp, dweibull, qweibull, qcauchy, 
pnorm and pbinom.

+ The r function generates random values from that random variable.
+ The d function evaluates the density/mass function for a value from that random variable
+ The p computes the CDF
+ The q computes the quantiles


# Vectorization

The r functions such as rnorm are vectorized in 
the sense that they return a vector of length n
where n is the number of observations to generate
```r
rnorm(10)
 [1]  0.39566264  0.32571408  1.01428275  0.82040600 -0.99314479
 [6]  0.27022508 -0.20369918  0.09917783 -0.70926140 -0.15798729
```

And similarly, dnorm and pexp are vectorized in their inputs,
i.e. return a vector of the same length as the first parameter.

However rnorm and the other r* functions are vectorized in their
other parameters, namely the parameters of the random variable's distribution.
For R, we can generate n values from different distributions by specifying
vectors for the second and third parameters of rnorm
```r
x = rnorm(10, seq(-50, 50, length = 10), seq(1, 100, length = 10))
```


We can think of this in the following
```r
rnorm(n, mu1, sd1)
         mu2, sd2
		 mu3, sd3
		   ...
	     mun, sdn)
```
The recycling rule applies when either vector has fewer elements than the other.


Similarly,
```r
dnorm(x, seq(-50, 50, length = 10), seq(1, 100, length = 10))
```
computes the density at the actual true mean and SD of the distributions
from which they came, in this example.

This is easier to verify with a smaller SD
```r
x = rnorm(10, seq(-50, 50, length = 10), 1)
dnorm(x, seq(-50, 50, length = 10), 1)
 [1] 0.39877829 0.25938075 0.39194590 0.19242167 0.02508960 0.05584537
 [7] 0.39133469 0.05360063 0.38245356 0.23322550
```

