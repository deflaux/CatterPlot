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

#' Rainbows!  Even more colors.
#'
#' @param xs a vector of numbers
#' @param ys another vector of numbers
#' @param ptsize control the size.
#' @param yspread the vertical spread of the rainbow
#' @param xspread the horizontal spread of rainbow particles
#' @param cat what cat shall make thine rainbow? nyan is 11
#' @param catshiftx get your cat connected to the rainbow!
#' @param catshifty get your cat connected to the rainbow!
#' @param canvas you are probably going to want to zoom in and out (x1,x2,y1,y2)
#' @param spar the smoothness of the rainbow.
#'
#' @return a rainbow!
#' @examples
# see also tests/rainbow_test.R
#' x <- -10:10
#' y <- -x^2 + 10
#' rainbowCats(x, y, yspread=0.05, xspread=0.05, ptsize=2,
#'             catshiftx=0.5, catshifty=-0.2, canvas=c(-0.5,1.5,-1,1.5))
#' @export
rainbowCats <- function(xs, ys, ptsize=0.1, yspread=0.1, xspread=0.1,
                        cat=11, catshiftx=0, catshifty=0, spar=NA, canvas=c(-0.5,1.5,-1,1.5)) {
    if (is.na(spar)) {
        sm <- smooth.spline(ys~xs)
    } else {
        sm <- smooth.spline(ys~xs, spar=spar)
    }
    max_x <- max(xs)
    min_x <- min(xs)
    z <- predict(sm, x=seq(min_x,max_x,by=xspread))

    cp <- multipoint(xs=z$x, ys=z$y, ptsize=ptsize, catcolor='#FFFFFF', canvas=canvas)

    #cols <- colorRamp(rainbow(7))(seq(0.0,1,by=0.12)) / 255
    cols <- rainbow(9, end=.8)
    mults <- seq(-4,4) * yspread

    for (i in 1:length(cols)) {
        morepoints(cp, xs=z$x, ys=z$y, ptsize=ptsize, catcolor=cols[i], yshift=mults[i])
    }

    print(paste(z$x[length(z$x)], "  ", z$y[length(z$y)], "\n\n"))
    morecats(cp, xs=z$x[length(z$x)], ys=z$y[length(z$y)],
             xshift=catshiftx, yshift=catshifty, size=1, cat=cat, color=FALSE)
}
