# Exercise

+ Preallocating a list (or any vector)
```r
x = vector("list", 10)
for(i in 1:10) 
 x[[ letters[i] ]] = i
```
What will x contain at the end of this?


+ And
```r
x = vector("list", 10)
names(x) = letters[1:10]

for(i in 1:10) 
 x[[ letters[i] ]] = i
```
What will x contain at the end of this?
