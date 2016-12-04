#!/bin/sh

# actors.list.gz and actresses.list.gz are copyrighted by IMDB. Do not
# redistribute the results of this script without permission from IMDB.

# USAGE:
# gzip -d actors.list.gz
# gzip -d actresses.list.gz
# ./actorsListToJSON.sh actors.list
# ./actorsListToJSON.sh actresses.list

# The MIT License (MIT)
# Copyright (c) <2016> <Brandon Cheng>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Trim file beginning comments and replace it with open map tag {
perl -i -0777 -pe 's/(.|\n)*Name\s{2,}Titles\s{2,}-{4}\s{2,}-{6}/{/' $1

# Truncate file end comments and replace it with close close tag }
perl -i -0777 -pe 's/\n-{5,}\nSUBMITTING UPDATES(.|\n)*/}/' $1

# Escape backslash and double quotes.
perl -i -pe 's/\\/\\\\/g' $1
perl -i -pe 's/"/\\"/g' $1

# Put movies in quotes and add a comma after it.
perl -i -pe 's/^\t+(.*)/\"$1\",/mg' $1

# Put key in quotes and start an array. Fix first movie.
perl -i -pe 's/^(.*?)\t+(.*)/\"$1\": [\n\"$2\",/mg' $1

# Remove TV shows and actors that were only in TV shows. They are commented out
# for now since this feature is a work in progress.
# perl -i -pe 's/"\\".*",\n//g' $1
# perl -i -0777 -pe 's/".*": \[\n\n//g' $1

# Fix end of all arrays.
perl -i -0777 -pe 's/",\n\n/"\n],\n/mg' $1

# Fix end of file/map.
perl -i -0777 -pe 's/",\n}/"\n]\n}/' $1

# Remove (credit)  [character]  <billing pos> to movies match
perl -i -pe 's/  .*"/"/g' $1
