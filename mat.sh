#! /bin/bash

function mAssert() {
	v=$(eval echo "\$\{$1[@]\}")
	all=$(eval echo "$v")
	v=$(eval echo "\$\{$1[0]\}")
	name=$(eval echo "$v")
	v=$(eval echo "\$\{#$1[@]\}")
	len=$(eval echo "$v")
	if [ "${name}" != "MAT" ]; then
		echo \( ${all} \)is not Matrix: $name
		exit -1
	fi
	if [ $len -ne 17 ]; then
		echo \( ${all} \) not Matrix: length: $len
		exit -1
	fi
}

function mZero()
{
	v1=(MAT\
			0 0 0 0\
			0 0 0 0\
			0 0 0 0\
			0 0 0 0\
			)
	eval "$1=(${v1[@]})"
}
function mIdent()
{
	v1=(MAT\
			$FACTOR 0 0 0\
			0 $FACTOR 0 0\
			0 0 $FACTOR 0\
			0 0 0 $FACTOR\
			)
	eval "$1=(${v1[@]})"
}

function mScale()
{
	v1=(MAT\
			$(expr $1 \* $FACTOR) 0 0 0\
			0 $(expr $2 \* $FACTOR) 0 0\
			0 0 $(expr $3 \* $FACTOR) 0\
			0 0 0 $FACTOR\
			)
	eval "$4=(${v1[@]})"
}

function mTrans()
{
	v1=(MAT\
			$FACTOR 0 0 $(expr $1 \* $FACTOR)\
			0 $FACTOR 0 $(expr $2 \* $FACTOR)\
			0 0 $FACTOR $(expr $3 \* $FACTOR)\
			0 0 0 $FACTOR\
			)
	eval "$4=(${v1[@]})"
}

function mIndex() {
	i=$1
	j=$2
	index=$(expr 1 \+ $i \* 4 \+ $j)
	echo $index
}

function mGet() {
	in1=($(eval echo $(eval echo "\$\{$1[@]\}")))
	mAssert in1
	index=$(mIndex $2 $3)
	echo ${in1[$index]}
}
function mSet() {
	in1=($(eval echo $(eval echo "\$\{$1[@]\}")))
	mAssert in1
	index=$(mIndex $2 $3)
	in1[$index]=$4
	eval "$5=(${in1[@]})"
}

function mvMul()
{
	in1=($(eval echo $(eval echo "\$\{$1[@]\}")))
	in2=($(eval echo $(eval echo "\$\{$2[@]\}")))
	mAssert in1
	vAssert in2
eval <<- EOF $3=\(VEC \
\$\(expr \\\( ${in1[1]} \\\* ${in2[1]} \\\+ ${in1[2]} \\\* ${in2[2]} \\\+ ${in1[3]} \\\* ${in2[3]} \\\+ ${in1[4]} \\\* ${in2[4]} \\\) \\\/ $FACTOR \) \
\$\(expr \\\( ${in1[5]} \\\* ${in2[1]} \\\+ ${in1[6]} \\\* ${in2[2]} \\\+ ${in1[7]} \\\* ${in2[3]} \\\+ ${in1[8]} \\\* ${in2[4]} \\\) \\\/ $FACTOR \) \
\$\(expr \\\( ${in1[9]} \\\* ${in2[1]} \\\+ ${in1[10]} \\\* ${in2[2]} \\\+ ${in1[11]} \\\* ${in2[3]} \\\+ ${in1[12]} \\\* ${in2[4]} \\\) \\\/ $FACTOR \) \
\$\(expr \\\( ${in1[13]} \\\* ${in2[1]} \\\+ ${in1[14]} \\\* ${in2[2]} \\\+ ${in1[15]} \\\* ${in2[3]} \\\+ ${in1[16]} \\\* ${in2[4]} \\\) \\\/ $FACTOR \) \)
EOF
}

function mMul() {
	in1=($(eval echo $(eval echo "\$\{$1[@]\}")))
	in2=($(eval echo $(eval echo "\$\{$2[@]\}")))
	mAssert in1
	mAssert in2
	eval <<-EOF $3=\(MAT \
\$\(expr \\\( ${in1[1]} \\\* ${in2[1]} \\\+ ${in1[2]} \\\* ${in2[5]} \\\+ ${in1[3]} \\\* ${in2[9]} \\\+ ${in1[4]} \\\* ${in2[13]} \\\) \\\/ $FACTOR \) \
\$\(expr \\\( ${in1[1]} \\\* ${in2[2]} \\\+ ${in1[2]} \\\* ${in2[6]} \\\+ ${in1[3]} \\\* ${in2[10]} \\\+ ${in1[4]} \\\* ${in2[14]} \\\) \\\/ $FACTOR \) \
\$\(expr \\\( ${in1[1]} \\\* ${in2[3]} \\\+ ${in1[2]} \\\* ${in2[7]} \\\+ ${in1[3]} \\\* ${in2[11]} \\\+ ${in1[4]} \\\* ${in2[15]} \\\) \\\/ $FACTOR \) \
\$\(expr \\\( ${in1[1]} \\\* ${in2[4]} \\\+ ${in1[2]} \\\* ${in2[8]} \\\+ ${in1[3]} \\\* ${in2[12]} \\\+ ${in1[4]} \\\* ${in2[16]} \\\) \\\/ $FACTOR \) \
\$\(expr \\\( ${in1[5]} \\\* ${in2[1]} \\\+ ${in1[6]} \\\* ${in2[5]} \\\+ ${in1[7]} \\\* ${in2[9]} \\\+ ${in1[8]} \\\* ${in2[13]} \\\) \\\/ $FACTOR \) \
\$\(expr \\\( ${in1[5]} \\\* ${in2[2]} \\\+ ${in1[6]} \\\* ${in2[6]} \\\+ ${in1[7]} \\\* ${in2[10]} \\\+ ${in1[8]} \\\* ${in2[14]} \\\) \\\/ $FACTOR \) \
\$\(expr \\\( ${in1[5]} \\\* ${in2[3]} \\\+ ${in1[6]} \\\* ${in2[7]} \\\+ ${in1[7]} \\\* ${in2[11]} \\\+ ${in1[8]} \\\* ${in2[15]} \\\) \\\/ $FACTOR \) \
\$\(expr \\\( ${in1[5]} \\\* ${in2[4]} \\\+ ${in1[6]} \\\* ${in2[8]} \\\+ ${in1[7]} \\\* ${in2[12]} \\\+ ${in1[8]} \\\* ${in2[16]} \\\) \\\/ $FACTOR \) \
\$\(expr \\\( ${in1[9]} \\\* ${in2[1]} \\\+ ${in1[10]} \\\* ${in2[5]} \\\+ ${in1[11]} \\\* ${in2[9]} \\\+ ${in1[12]} \\\* ${in2[13]} \\\) \\\/ $FACTOR \) \
\$\(expr \\\( ${in1[9]} \\\* ${in2[2]} \\\+ ${in1[10]} \\\* ${in2[6]} \\\+ ${in1[11]} \\\* ${in2[10]} \\\+ ${in1[12]} \\\* ${in2[14]} \\\) \\\/ $FACTOR \) \
\$\(expr \\\( ${in1[9]} \\\* ${in2[3]} \\\+ ${in1[10]} \\\* ${in2[7]} \\\+ ${in1[11]} \\\* ${in2[11]} \\\+ ${in1[12]} \\\* ${in2[15]} \\\) \\\/ $FACTOR \) \
\$\(expr \\\( ${in1[9]} \\\* ${in2[4]} \\\+ ${in1[10]} \\\* ${in2[8]} \\\+ ${in1[11]} \\\* ${in2[12]} \\\+ ${in1[12]} \\\* ${in2[16]} \\\) \\\/ $FACTOR \) \
\$\(expr \\\( ${in1[13]} \\\* ${in2[1]} \\\+ ${in1[14]} \\\* ${in2[5]} \\\+ ${in1[15]} \\\* ${in2[9]} \\\+ ${in1[16]} \\\* ${in2[13]} \\\) \\\/ $FACTOR \) \
\$\(expr \\\( ${in1[13]} \\\* ${in2[2]} \\\+ ${in1[14]} \\\* ${in2[6]} \\\+ ${in1[15]} \\\* ${in2[10]} \\\+ ${in1[16]} \\\* ${in2[14]} \\\) \\\/ $FACTOR \) \
\$\(expr \\\( ${in1[13]} \\\* ${in2[3]} \\\+ ${in1[14]} \\\* ${in2[7]} \\\+ ${in1[15]} \\\* ${in2[11]} \\\+ ${in1[16]} \\\* ${in2[15]} \\\) \\\/ $FACTOR \) \
\$\(expr \\\( ${in1[13]} \\\* ${in2[4]} \\\+ ${in1[14]} \\\* ${in2[8]} \\\+ ${in1[15]} \\\* ${in2[12]} \\\+ ${in1[16]} \\\* ${in2[16]} \\\) \\\/ $FACTOR \) \)
EOF
}
