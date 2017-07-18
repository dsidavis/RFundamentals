For various reasons, 

```r
f = function(x, y) { y ~ x }
```

```r
form = f(1:10, 101:110)
form
y ~ x
<environment: 0x7fca18b8e788>
```

```r
get("x", environment(form))
[1]  1  2  3  4  5  6  7  8  9 10
```

```r
eval(quote(x), environment(form))
 [1]  1  2  3  4  5  6  7  8  9 10
```

We can evaluate calls
```r
eval(quote(x + y), environment(form))
 [1] 102 104 106 108 110 112 114 116 118 120
```

And  calls that reference variables/symbols from other environments
```r
eval(quote(x + log(y)), environment(form))
 [1] 102 104 106 108 110 112 114 116 118 120
```
