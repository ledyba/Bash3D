#! /bin/bash

. 3d.sh

function main()
{
	echo "Running..."
	width=`tput cols`
	height=`tput lines`
	glFrustum `expr -$FACTOR \* 16 / 9` `expr $FACTOR \* 16 / 9` `to 1` `to -1` `to 2` `to 10`
	glLoadIdentity
	for ((i=0; i<720; ++i)); do
		glClear
		glTranslate `to 0` `to 0` `to 2`

		glLine `to -1` `to -1` `to 1` `to  1` `to -1` `to 1`
		glLine `to  1` `to -1` `to 1` `to  1` `to  1` `to 1`
		glLine `to  1` `to  1` `to 1` `to -1` `to  1` `to 1`
		glLine `to -1` `to  1` `to 1` `to -1` `to -1` `to 1`

		glLine `to -1` `to -1` `to 3` `to  1` `to -1` `to 3`
		glLine `to  1` `to -1` `to 3` `to  1` `to  1` `to 3`
		glLine `to  1` `to  1` `to 3` `to -1` `to  1` `to 3`
		glLine `to -1` `to  1` `to 3` `to -1` `to -1` `to 3`

		glLine `to -1` `to -1` `to 1` `to -1` `to -1` `to 3`
		glLine `to  1` `to -1` `to 1` `to  1` `to -1` `to 3`
		glLine `to  1` `to  1` `to 1` `to  1` `to  1` `to 3`
		glLine `to -1` `to  1` `to 1` `to -1` `to  1` `to 3`

		glSwap
		glTranslate `to 0` `to 0` `to -4`
		glRotate `expr 43643578047 \* $FACTOR / 100000000000` `expr 87287156094 \* $FACTOR / 100000000000` `expr 21821789023 \* $FACTOR / 100000000000` 1
		glTranslate `to 0` `to 0` `to 2`
	done
}

main
tput cup `tput lines` 0

