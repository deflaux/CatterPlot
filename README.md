# CatterPlots
One stop shopping for cat themed scatter plots.

*NEW*
Rainbow plots.

# Making a parabola rainbow.

```
library(CatterPlots)
x <- -10:10
y <- -x^2 + 10
rainbowCats(x, y, yspread=0.05, xspread=0.05, ptsize=2, catshiftx=0.5, catshifty=-0.2, canvas=c(-0.5,1.5,-1,1.5))
```

<img src="https://github.com/Gibbsdavidl/CatterPlot/blob/master/examples/nyan_cat_plot.png" width="600">

And...

<img src="https://github.com/Gibbsdavidl/CatterPlot/blob/master/examples/catplot_ex_6.png" width="600">
<img src="https://github.com/Gibbsdavidl/CatterPlot/blob/master/examples/random_cats.png" width="600">

Go ahead, treat yourself! There's over 10 cat models now!

Well, exactly 11, actually. Eleven types of cats.

To install, either:
```
library(devtools)
install_github("Gibbsdavidl/CatterPlots")
```
Or git clone the repo and then install using:
```
R CMD INSTALL CatterPlots
```

In R:

```
library(CatterPlots)
x <- -10:10
y <- -x^2 + 10
purr <- catplot(xs=x, ys=y, cat=3, catcolor='#000000FF')
cats(purr, -x, -y, cat=4, catcolor='#FF0000')

# for more fun ...
meow <- multicat(xs=x, ys=y, cat=c(1,2,3), catcolor=list('#33FCFF','#FF0000'), canvas=c(-0.1,1.1, -0.1, 1.1))
morecats(meow, x, 10*sin(x)+40, size=0.05, cat=c(4,5,6), catcolor=list('#0495EE','#EE7504'), type="line")

# random cats
meow <- multicat(xs=x, ys=rnorm(21),
                 cat=c(1,2,3,4,5,6,7,8,9,10),
                 catcolor=list('#33FCFF'),
                 canvas=c(-0.1,1.1, -0.1, 1.1),
                 xlab="some cats", ylab="other cats", main="Random Cats")

```
