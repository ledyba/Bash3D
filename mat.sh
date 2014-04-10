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

function mMul() {
	in1=($(eval echo $(eval echo "\$\{$1[@]\}")))
	in2=($(eval echo $(eval echo "\$\{$2[@]\}")))
	mat=0
	mZero mat
	mAssert in1
	mAssert in2
	for (( i=0; i<4; ++i ));do
		for (( j=0; j<4; ++j ));do
			s=$(expr \( \
					$(mGet in1 $i 0) \* $(mGet in2 0 $j) \+\
					$(mGet in1 $i 1) \* $(mGet in2 1 $j) \+\
					$(mGet in1 $i 2) \* $(mGet in2 2 $j) \+\
					$(mGet in1 $i 3) \* $(mGet in2 3 $j)\
					\) \/ $FACTOR)
			mSet mat $i $j $s mat
		done
	done
	eval "$3=(${mat[@]})"
}
