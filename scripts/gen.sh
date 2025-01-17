#!/bin/bash

# Made by Innovative Inventor at https://github.com/innovativeinventor.
# If you like this code, star it on GitHub!
# Contributions are always welcome.

# MIT License
# Copyright (c) 2017 InnovativeInventor

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Usage: bash scripts/gen.sh

sort -u words.txt -o words.txt
# words_alpha (only alphabet chars, no numbers or punctuation)
grep -v '[[:digit:]|[:punct:]]' words.txt > words_alpha.txt
python3 scripts/create_json.py words_alpha.txt > words_dictionary.json
# words_alpha_apos (words_alpha, but apostrophes are allowed)
cp words_alpha.txt temp.txt
grep "'" words.txt >> temp.txt
grep -v '-' temp.txt > words_alpha_apos.txt
rm temp.txt
python3 scripts/create_json.py words_alpha_apos.txt > words_dictionary_apos.json
# zip files
rm *.zip
find . -type f -name "words*" -maxdepth 1 -execdir sh -c 'zip "${0%.*}.zip" "$0"' {} \;
