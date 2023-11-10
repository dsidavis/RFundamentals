The aim of this sequence of workshops is to help participants understand the
relatively small but fundamental computational model underlying the R
language. This will help you reason about code before you write
and run it and to debug it if it doesn't do what you want.  A sound
understanding of this computational model makes programming in R much
easier and more productive, and ultimately less frustrating, or positively put,
more enjoyable.  Basically, we want you to understand how
the R interpreter works.

Importantly, one needs to be confident and correct to write  code quickly.
When one is uncertain and guessing about what will happen, it leads to slow, frustrating
code development and often with unidentified errors.

Imagine writing an essay/report/thesis/dissertation without knowing the language.
You may build from sample sentences, adapting them to say what you mean in this particular context.
You have to find the elements to change, insert new words or terms. You are limited by the
structure of the sample sentences.  As you create new sentences, the focus is on th grammar,
not what you are trying to convey.
Once you become proficient with writing grammatically correct sentences, your focus switches
to the content and how to convey it. You are confident in the structure and not distracted by it.


# Active learning, constant questions.
This mini-course is intended as an active engagement and not a passive
lecture series.  We want you to come to each session with questions
about why some things worked and others didn't, and to actively learn.


### Non-standard Evaluation, tidyverse, etc.
We won't focus much on the tidyverse, pipes, etc.
They are fine packages. However, they use a lot of non-standard evaluation and
so the computational model is similar but different from R. This 
unfortunately complicates rather than simplifies matters and can make reasoning
about them  challenging at best. Furthermore,
the paradigm provided by the tidyverse packages strongly favor working 
with data frames. This is appropriate in 90-95% of situations, but
leaves us without the appropriate approaches and tools in the remainder.
Often, we will force these remaining computations into this familiar framework making
them more complex to implement, inefficient to run, and hard to reason
about and maintain.

Learning the fundamentals gets you the tools you can use in all situations
and provides strong foundation to learn other layers on top of this.



## Topics include (but we can discuss more)

+ What is a REPL
     + parsing and evaluation
     + errors in each stage.
+ The Global workspace/environment
+ Variables and Assignment (=, <- )
+ search() path
+ Basic data types - vectors
  + Hierarchy of data types and implicit coercion
  + c(TRUE, 1L, 3.1415, "abc")
+ Querying an object:  class, typeof, length, dim, names, str  
+ Lists
+ Data Frames
   + Matrices
+ Subsetting rules
  + integer indexing, negative indices, names, logical vectors, 
  + Subsetting in 2-Dimensions
    +  matrices, 2-column matrices
  + partial name matching
+ Categorical data - factors
+ Vectorization and element-wise functions
  + Rinaldo's example.
  + match()
  + factors
+ Recycling
+ Aggregate functions - sum, mean, summary, table,
+ Apply functions
+ How function calls work
+ Functional Programming - "no" side effects.
+ Writing Functions
   + parameter default values 
   + lazy evaluation
      + substitute(), deparse() to get expression of an argument.
   + 'Hoisting'
   + Extensibility
   + Good Design
+ on.exit
   + non-functional programming - fixing/resetting side effects
+ Scoping Rules
   + Nested functions, Closures
+ Debugging
   + call stack
   + recover(), browser(), ....
+ try/tryCatch() and errors, warnings and conditions, withCallingHandlers, 
  + 
+ non-standard evaluation
  + eval()
  + examples: weights in lm(), %>%, ggplot2, ...
+ code analysis and analytical meta-programming 
+ constructive meta programming


+ loops
+ conditions
+ ifelse()n

# Inefficiencies
+ concatenation versus  preallocation
+ Vectorize()

### Possible Additional Topics

+ Formulae
+ S3 class system
+ Writing Packages
+ NAMESPACE files
+ S4 class system

+ Character Encoding


# Introduction

This version of this workshops is the first since we suspended 
the last in-person  early March 2020.  I know how hard this last 2 years have been
for all of us.  Let us truly appreciate how hard this has been and continues to be.

I am the Associate Dean for Graduate Programs, and with my marvelous colleage Ellen
Hartigan-O'Connor who  is the Associate Dean for Graduate Students and Postdoctoral Scholars,
we truly care about you, your well-being, your success and careers. 
We are always here to address any of your concerns. And we know only too well how many concerns
you have in this situation. Reach out to us with general suggestions and personal issues. 
(And if you are an undergraduate, email me also and I will try to address your concern.)

I had such a difficult time this last month making peace that this would  be remote
as I love the live/in-person interaction
+ getting when people understand an idea, 
+ reacting when most in the room is "WHAT!"
So please help us recreate that with the same expressions.  I beg you!

On the incentivzing side, we instructors do better when we have active parcipation.
I know it is so much easier to not have your camera on.  On one group call recently, the host turned my
camera off as I was walking around the room clearly doing other things (My Bad!!). But if you are looking at the
screen/camera, it is so helpful for us to see your face. So we ask that you actively participate. We
understand when you can't and no guilt involved.     
