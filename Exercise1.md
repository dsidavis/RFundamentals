# Exercises
+ What happens with the command `sum(10, 20, 30 40)`
+ What happens when we enter the command `10/`?
+ Is `1 + +2` a legitimate command?
+ Is `1 + -2` a legitimate command?
+ Is `1 + *2` a legitimate command?
+ `x[[1][2]`
+ `x[[1]][2`

+ `plot(x, y, main = 'Don't do this')`
<!-- Instead, use xlab = "Don't do this" -->
+ `plot(x, y, xlab = "text that is "quoted" can cause problem")`

+ How do we get and print the + function? the while function?

+ What does 
```r
e = parse(text = "T; TRUE")
```
yield?
What is the difference between the two elements?

+ Use the parse() function to parse an expression
```r
scatter.smooth(mtcars[, c("mpg", "wt")], , , , "gaussian", "Weight of car", "Miles per Gallon", 
			   lpars = list(lwd = 2, col = "red"),
			   main = "Motor Trends Data")
```
Explore the call object you get back.

<!-- 
str = 'scatter.smooth(mtcars[, c("mpg", "wt")], , , , "gaussian", "Weight of car", "Miles per Gallon", 
			   lpars = list(lwd = 2, col = "red"),
			   main = "Motor Trends Data")'
e = parse(text = str)
class(e)
length(e)
class(e[[1]])

-->
