#
# CatterPlots
#
# Copyright (c) 2016 David L Gibbs
# email: gibbsdavidl@gmail.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


#' Make a cat plot
#'
#' @param xs a vector of numbers
#' @param ys another vector of numbers
#' @param size the size of the cat (0.1 is a good starting point)
#' @param cat the cat model, 1 through 12
#' @param catcolor a modifier vector to the png matrix (try c(1,0,0,1))
#' @param linecolor color of plotted lines
#' @param type the type of plot ... justcats, or line
#' @param canvas the plotting area
#' @param ... additional parameters to pass to plot()
#'
#' @return a cat plot object... to plot more cats.
#' @examples
#' x <- -10:10
#' y <- -x^2 + 10
#' purr <- catplot(xs=x, ys=y, cat=3, catcolor=c(0,1,1,1))
#' cats(purr, -x, -y, cat=4, catcolor=c(1,0,1,1))'
#' @export
catplot <- function(xs, ys,
					size=0.1, cat=1,
					catcolor = '#000000FF',
					linecolor=1, type="justcats",
					canvas=c(0,1.1,0,1.1), ...) {

	args <- list(...)

	plot(x=xs, y=ys, col=0, xaxt="n", yaxt="n", ...)
	par(usr=canvas)

	img <- catdat[[cat]]

	scaledData <- scaleData(xs,ys,args)
	xscale <- scaledData$xscale
	yscale <- scaledData$yscale

	xat = seq(min(xscale), max(xscale), length.out=length(xscale))
	yat = seq(min(yscale), max(yscale), length.out=length(yscale))
	xaxtlab = round(seq(min(xs), max(xs),length.out=length(xat)),1)
	yaxtlab = round(seq(min(ys), max(ys),length.out=length(xat)),1)
	axis(side=1, at=xat, labels=xaxtlab)
	axis(side=2, at=yat, labels=yaxtlab)

	# modify the cat image
	imgMod <- colorMod(img, catcolor)

	if (type == "line") {
		points(x=xscale, y=yscale, col=linecolor, type="l")
	}
	rasterImage(imgMod, xscale-(size/2), yscale-(size/2), xscale+(size/2), yscale+(size/2), interpolate=TRUE)
	list(xs=xs, ys=ys, args=args, canvas=canvas)
}



#' Plot more cats!
#'
#' @param obj a catplot object, returned from catplot
#' @param xs a vector of numbers
#' @param ys another vector of numbers
#' @param size the size of the cat (0.1 is a good starting point)
#' @param cat the cat model, 1 through 12
#' @param catcolor a modifier vector to the png matrix (try c(1,0,0,1))
#' @param linecolor color of plotted lines
#' @param type the type of plot ... justcats, or line
#'
#' @return a cat plot object... to plot more cats.
#' @examples
#' x <- -10:10
#' y <- -x^2 + 10
#' purr <- catplot(xs=x, ys=y, cat=3, catcolor=c(0,1,1,1))
#' cats(purr, -x, -y, cat=4, catcolor=c(1,0,1,1))'
#' @export
cats <- function(obj=NULL, xs, ys, size=0.1, cat=1, catcolor = '#000000FF',
										linecolor=1, type="justcats") {
	# needs a plot already up, and the catObj returned from it.
	if(is.null(obj)) {
		print("Please feed the cats!  cat_food <- catplot(...);  cats(cat_food, ...)")
	}

	img <- catdat[[cat]]

	scaledData <- catsScaleData(obj,xs,ys)
	xscale <- scaledData$xscale
	yscale <- scaledData$yscale

	# modify the cat image
	imgMod <- colorMod(img, catcolor)

	if (type == "line") {
		points(x=xscale, y=yscale, col=linecolor, type="l")
	}
	rasterImage(imgMod, xscale-(size/2), yscale-(size/2),
	            xscale+(size/2), yscale+(size/2), interpolate=TRUE)
}


colorMod <- function(img, col='#000000FF') {
  # applies color to non-transparent areas of img
  colorVec = col2rgb(col, alpha = T) / 255
  array(t(sapply(pmin(apply(img, c(1,2), sum), 1),
                 function(x){x * colorVec})),
        dim=c(nrow(img), ncol(img), 4))
}


scaleData <- function(xs,ys,args) {
	# first shift the data to the positive region
	xscale <- xs + (-min(c(0,xs)))
	yscale <- ys + (-min(c(0,ys)))
	xscale <- xscale/max(xscale)
	yscale <- yscale/max(yscale)

	if ("xlim" %in% names(args)) {
		xscale <- xs + (-min(c(args$xlim,xs)))
		xscale <- xscale/max(args$xlim)
	}
	if ("ylim" %in% names(args)) {
		yscale <- ys + (-min(c(args$ylim,ys)))
		yscale <- yscale/max(args$ylim)
	}
	list(xscale=xscale, yscale=yscale)
}


catsScaleData <- function(obj,xs,ys) {
	args <- obj$args

	# first shift the data to the positive region
	xscale <- xs + (-min(c(0,xs)))
	yscale <- ys + (-min(c(0,ys)))
	# put it in the frame of the previous plot
	objxscale <- obj$xs + (-min(c(0,obj$xs)))
	objyscale <- obj$ys + (-min(c(0,obj$ys)))
	xscale <- xscale/max(objxscale)
	yscale <- yscale/max(objyscale)

	if ("xlim" %in% names(args)) {
		xscale <- xs + (-min(c(args$xlim,xs)))
		xscale <- xscale/max(args$xlim)
	}
	if ("ylim" %in% names(args)) {
		yscale <- ys + (-min(c(args$ylim,ys)))
		yscale <- yscale/max(args$ylim)
	}
	list(xscale=xscale, yscale=yscale)
}


yeOldColorMod <- function(img, colorVec=c(0,0,0,1)) {
  #
  # Just to remember how things used to be, back in the day.
  #
	# the cat pngs are 72x72x4, where each of those 4 layers
	# represents one component of the RGB color space.
	# this function takes the last, black layer, and creates
	# a new vector, multiplying colorVec by that c(0,0,0,x)

	for (i in 1:72) {
		for (j in 1:72) {
				imgSum <- min(sum(img[i,j,1:4]), 1)
				if (imgSum > 0.0) {
					val <- img[i,j,4]
					img[i,j,1:4] <- colorVec
					img[i,j,1:4] <- img[i,j,1:4] * imgSum
				} else {
					img[i,j,1:4] <- c(0,0,0,0)
				}
		}
	}
	img
}
