
Be very careful of the idiom 
```r
1:length(x)
```
What if x has length 0?
Then this is 1:0 and we get two elements.
So
y[1:length(x)] 
would  yeild
y[c(1, 0)]
and give the first element.

What about
```r
for(i in 1:length(x)) {
 ...
}
```
This would give two iterations where i is 1 and then 0.


Instead, we nearly always want
```r
seq(along = x)
```
