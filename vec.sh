#! /bin/bash

function vAssert() {
	v=$(eval echo "\$\{$1[@]\}")
	all=$(eval echo "$v")
	v=$(eval echo "\$\{$1[0]\}")
	name=$(eval echo "$v")
	v=$(eval echo "\$\{#$1[@]\}")
	len=$(eval echo "$v")
	if [ "${name}" != "VEC" ]; then
		echo \( ${all} \)is not Vector: $name
		exit -1
	fi
	if [ $len -ne 5 ]; then
		echo \( ${all} \) not Vector: length: $len
		exit -1
	fi
}

function vAdd {
	in1=($(eval echo $(eval echo "\$\{$1[@]\}")))
	in2=($(eval echo $(eval echo "\$\{$2[@]\}")))
	vAssert in1
	vAssert in2
	out=(VEC \
			`expr ${in1[1]} + ${in2[1]}`\
			`expr ${in1[2]} + ${in2[2]}`\
			`expr ${in1[3]} + ${in2[3]}`\
			`expr ${in1[4]} + ${in2[4]}`\
			)
	eval "$3=(${out[@]})"
}
function vSub {
	in1=($(eval echo $(eval echo "\$\{$1[@]\}")))
	in2=($(eval echo $(eval echo "\$\{$2[@]\}")))
	vAssert in1
	vAssert in2
	out=(VEC \
			`expr ${in1[1]} - ${in2[1]}`\
			`expr ${in1[2]} - ${in2[2]}`\
			`expr ${in1[3]} - ${in2[3]}`\
			`expr ${in1[4]} - ${in2[4]}`\
			)
	eval "$3=(${out[@]})"
}
function vDiv {
	in1=($(eval echo $(eval echo "\$\{$1[@]\}")))
	in2=$2
	vAssert in1
	out=(VEC \
			`expr ${in1[1]} \* $FACTOR \/ ${in2}`\
			`expr ${in1[2]} \* $FACTOR \/ ${in2}`\
			`expr ${in1[3]} \* $FACTOR \/ ${in2}`\
			`expr ${in1[4]} \* $FACTOR \/ ${in2}`\
			)
	eval "$3=(${out[@]})"
}
function vMul {
	in1=($(eval echo $(eval echo "\$\{$1[@]\}")))
	in2=$2
	vAssert in1
	out=(VEC \
			`expr ${in1[1]} \* ${in2} \/ $FACTOR`\
			`expr ${in1[2]} \* ${in2} \/ $FACTOR`\
			`expr ${in1[3]} \* ${in2} \/ $FACTOR`\
			`expr ${in1[4]} \* ${in2} \/ $FACTOR`\
			)
	eval "$3=(${out[@]})"
}
function vDot {
	in1=($(eval echo $(eval echo "\$\{$1[@]\}")))
	in2=($(eval echo $(eval echo "\$\{$2[@]\}")))
	vAssert in1
	vAssert in2
	out=$(expr \( \
			${in1[1]} \* ${in2[1]} +\
			${in1[2]} \* ${in2[2]} +\
			${in1[3]} \* ${in2[3]} +\
			${in1[4]} \* ${in2[4]}\
			\) \/ $FACTOR)
	eval "$3=(${out[@]})"
}
