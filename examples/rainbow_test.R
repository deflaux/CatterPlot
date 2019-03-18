

# Making a parabola rainbow.

library(CatterPlots)
x <- -10:10
y <- -x^2 + 10
rainbowCats(x, y, yspread=0.05, xspread=0.05, ptsize=2, catshiftx=0.5, canvas=c(-0.5,1.5,-1,1.5))
