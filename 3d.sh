#! /bin/bash

FACTOR=10000

. vec.sh
. mat.sh

function glClear() {
	tput clear
	return 0
}

v1=(MAT\
		1100000 2100000 3100000 4100000\
		2100000 2200000 3200000 4200000\
		3100000 2300000 3300000 4300000\
		4100000 2400000 3400000 4400000\
		)
function nest() {
	mMul v1 v1 v2
	echo ${v1[@]}
}

nest
