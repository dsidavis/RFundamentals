+ How are the arguments matched to the parameters  in the following call:
```r
scatter.smooth(mtcars$mpg, mtcars$wt, family = "gaussian", x = "Weight of car", y = "Miles per Gallon")
```


+ I was looking for a function in one of the packages that come with R
that had a ... parameter and that also had a parameter that came after the ...
How did I find scatter.smooth() programmatically?

```r
o = ls("package:stats")
i = sapply(o, function(x){ 
                 f = get(x, "package:stats"); 
                 if(is.function(f)) { 
				     p = names(formals(f)); 
					 ("..." %in% p && match("...", p) < length(p))
	             } else 
				    FALSE
	          })
```
