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


# cat loader

# make sure the cats have transparent backgrounds!

createCatList <- function(dir) {
	fs <- list.files(dir, pattern="png")
	catlist <- vector("list", length(fs))
	for (i in 1:length(fs)) {
		print(fs[i])
		catlist[[i]] <- png::readPNG(source=paste0(dir,fs[i]))
	}
	catlist
}
