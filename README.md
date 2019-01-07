
<!-- icon: https://iconscout.com/icon/hot-soup-3 -->
kaspeR: a*nother* s*afety* p*roviding* e*valuator* *in* R <img src="man/figures/logo.png" align="right" alt="" />
-----------------------------------------------------------------------------------------------------------------

[![](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental) [![](https://img.shields.io/badge/language-R-blue.svg)](https://cran.r-project.org/)

This package allows to safely evaluate strings in R using something more sophisticated than

``` r
code <- "x <- 1"
eval(parse(text = code))
```

by applying a whitelisting logic. The "whitelist" contains safe commands which won't be able to hurt your system when the `code` is sent by a client.

### Installation

``` r
## install from github
devtools::install_github("GregorDeCillia/kaspeR")
```

### Usage

Create a new evaluator with the `new()` method.

``` r
library(kaspeR)
myEvaluator <- evaluator$new()
```

Evaluate strings with the `eval()` method.

``` r
myEvaluator$eval("
x <- 1
x <- x + 1
x
x - 1
")
```

No outputs? Don't worry they are all captured in the `myEvaluator` object.

``` r
myEvaluator$replay()
```

    ## > 
    ## > x <- 1
    ## > x <- x + 1
    ## > x
    ## [1] 2
    ## > x - 1
    ## [1] 1

### Error handling

Errors are just part of the output for the repay function. They will not interrupt the evaluation.

``` r
myEvaluator$eval("
y
2 + 2
")
myEvaluator$replay()
```

    ## > 
    ## > y

    ## Error in eval(expr, envir, enclos): object 'y' not found

    ## > 2 + 2
    ## [1] 4

### The whitelist

An error also occurs if the user try to perform anything that is not whitelisted. Functions like `system()` are not available and trated as though they do not exist.

``` r
myEvaluator$eval("system('mkdir testdir')")
myEvaluator$replay()
```

    ## > system('mkdir testdir')

    ## Error in system("mkdir testdir"): could not find function "system"

To display all whitelisted commands, use `getWhiteList()`.

``` r
myEvaluator$getWhiteList()
```

    ##  [1] "exp"      "log1p"    "trigamma" "cumprod"  "%%"       "log"     
    ##  [7] "atanh"    "sinh"     "tanpi"    "<"        "!="       "<="      
    ## [13] "tan"      ">"        "lgamma"   "gamma"    "digamma"  "expm1"   
    ## [19] "floor"    "log2"     "cos"      "abs"      "trunc"    "sqrt"    
    ## [25] "x"        "cosh"     "cummax"   "asinh"    "sinpi"    "{"       
    ## [31] "=="       "sin"      "atan"     "log10"    "acos"     "%/%"     
    ## [37] "ceiling"  "("        "tanh"     "acosh"    "cospi"    "*"       
    ## [43] "+"        "cumsum"   ">="       "-"        "<-"       "sign"    
    ## [49] "asin"     "cummin"   "^"        "/"
