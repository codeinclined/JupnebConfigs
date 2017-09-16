#!/bin/sh

################################################################################
# Copyright 2017 Joshua Taylor <taylor.joshua88@gmail.com>
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
################################################################################

if [ $# -gt 0 ]; then
    MENU_DIR="$1"
else
    MENU_DIR="$HOME"
fi

rofi -version &> /dev/null

if [ $? -ne 0 ]; then
    MENU_CMD="dmenu"
    MU_ARGS=
else
    MENU_CMD="rofi"
    MENU_ARGS=("-dmenu")
fi

while [ -d $MENU_DIR ]; do
    MENU_INPUT="$(ls -a1 $MENU_DIR | $MENU_CMD ${MENU_ARGS[@]} -p $MENU_DIR/)"

    if [ $? -ne 0 ]; then
        exit
    fi

    MENU_DIR="$(readlink -f $MENU_DIR/$MENU_INPUT)"
done

echo $MENU_DIR
