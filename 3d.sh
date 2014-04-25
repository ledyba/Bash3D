#! /bin/bash

FACTOR=100000000000

function to
{
	echo `expr $1 \* $FACTOR`
}

. sincos.sh
. vec.sh
. mat.sh

WIDTH=
HEIGHT=
COL=
LINE=
HALF_WIDTH=
HALF_HEIGHT=
SCR_BUFF=
function glInit()
{
	COL=`tput cols`
	LINE=`tput lines`
	WIDTH=$(expr $FACTOR \* $COL)
	HEIGHT=$(expr $FACTOR \* $LINE)
	HALF_WIDTH=`expr $WIDTH \/ 2`
	HALF_HEIGHT=`expr $HEIGHT \/ 2`
}
glInit
function glClear()
{
	size=$(expr $COL \* $LINE)
	SCR_BUFF=$(head -c $size < /dev/zero | tr '\0' '_')
}

function glSwap()
{
	tput clear
	tput cup 0 0
	echo -n $SCR_BUFF | sed "s/_/ /g"
}

MODEL_MAT=
PROJ_MAT=
mIdent MODEL_MAT
mIdent PROJ_MAT

function glLoadIdentity() {
	mIdent MODEL_MAT
}

function glTranslate()
{
	v=
	mTrans $1 $2 $3 v
	mMul v MODEL_MAT MODEL_MAT
}
function glScale()
{
	v=
	mScale $1 $2 $3 v
	mMul v MODEL_MAT MODEL_MAT
}
function glRotate()
{
	v=
	mRotate $1 $2 $3 $4 v
	mMul v MODEL_MAT MODEL_MAT
}

function glFrustum()
{
	mFrustum $1 $2 $3 $4 $5 $6 PROJ_MAT
}

function gToScreen()
{
	in=($(eval echo $(eval echo "\$\{$1[@]\}")))
	eval $2=\$\(expr \\\( ${in[1]} \\\* $HALF_WIDTH  \\\/ ${in[4]} \\\+ $HALF_WIDTH \\\) \\\/ $FACTOR \)
	eval $3=\$\(expr \\\( ${in[2]} \\\* $HALF_HEIGHT \\\/ ${in[4]} \\\+ $HALF_HEIGHT \\\) \\\/ $FACTOR \)
}

function gLine()
{
	if(($1 < $3));then
		dx=`expr $3 - $1`
		sx=1
	else
		dx=`expr $1 - $3`
		sx=-1
	fi
	if(($2 < $4));then
		dy=`expr $4 - $2`
		sy=1
	else
		dy=`expr $2 - $4`
		sy=-1
	fi
	x=$1
	y=$2
	err=`expr $dx - $dy`
	while true; do
		pos=$(expr $y \* $COL \+ $x \+ 1)
		SCR_BUFF="${SCR_BUFF:0:${pos}}*${SCR_BUFF:${pos}+1}"
		if [ $x -eq $3 -a $y -eq $4 ]; then
			return 0
		fi
		e2=`expr 2 \* $err`
		if [ $e2 -gt -$dy ]; then
			err=`expr $err - $dy`
			x=`expr $x \+ $sx`
		fi
		if [ $e2 -lt $dx ]; then
			err=`expr $err + $dx`
			y=`expr $y \+ $sy`
		fi
	done
}

function glLine()
{
	v1=(VEC $1 $2 $3 $FACTOR)
	mvMul MODEL_MAT v1 v1
	mvMul PROJ_MAT v1 v1
	x1=
	y1=
	gToScreen v1 x1 y1
	v2=(VEC $4 $5 $6 $FACTOR)
	mvMul MODEL_MAT v2 v2
	mvMul PROJ_MAT v2 v2
	x2=
	y2=
	gToScreen v2 x2 y2
	gLine $x1 $y1 $x2 $y2
}

