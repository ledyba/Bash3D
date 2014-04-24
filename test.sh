#! /bin/bash

FACTOR=1

. sincos.sh
. vec.sh
. mat.sh

function assertV ()
{
	v=$(eval "echo \$$2")
	if [ "$v" = "$3" ]; then
		echo $1  :OK
	else
		echo $1  :NG $2 is not $3 -\> $v
		exit -1
	fi
}
function assertL ()
{
	v=\($(eval echo $(eval echo "\$\{$2[@]\}"))\)
	if [ "${v[@]}" = "$3" ]; then
		echo $1 :OK
	else
		echo $1 :NG $2 is not $3 -\> $v
		exit -1
	fi
}
function main() {
	v1=(VEC 1 2 3 4)
	v2=(VEC 1 2 3 4)
	v3=0
	vDot v2 v2 v3
	assertV vDot v3 30

	v1=(VEC 1 2 3 4)
	v2=(VEC 1 2 3 4)
	v3=0
	vMul v2 2 v3
	assertL vMul v3 "(VEC 2 4 6 8)"

	v1=(VEC 2 4 6 6)
	v3=0
	vDiv v1 2 v3
	assertL vDiv v3 "(VEC 1 2 3 3)"

	v1=(VEC 1 2 3 4)
	v2=(VEC 1 2 3 5)
	v3=0
	vSub v1 v2 v3
	assertL vSub v3 "(VEC 0 0 0 -1)"

	v1=(VEC 1 2 3 4)
	v2=(VEC 1 2 3 5)
	v3=0
	vAdd v1 v2 v3
	assertL vAdd v3 "(VEC 2 4 6 9)"

	FACTOR=10
	m1=(MAT\
			10 10 10 10\
			0 10 0 0\
			0 0 10 0\
			0 0 0 10\
			)
	mMul m1 m1 v3
	assertL mMul v3 "(MAT 10 20 20 20 0 10 0 0 0 0 10 0 0 0 0 10)"

	v1=(VEC 10 20 30 40)
	mvMul m1 v1 v3
	assertL mvMul v3 "(VEC 100 20 30 40)"
	FACTOR=1

	mScale 1 2 3 v3
	assertL mScale v3 "(MAT 1 0 0 0 0 2 0 0 0 0 3 0 0 0 0 1)"

	mTrans 1 2 3 v3
	assertL mTrans v3 "(MAT 1 0 0 1 0 1 0 2 0 0 1 3 0 0 0 1)"
	
	mRotate 1 2 3 0 v3
	assertL mRotate v3 "(MAT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1)"

	mRotate 0 0 1 180 v3
	assertL mRotate v3 "(MAT -1 0 0 0 0 -1 0 0 0 0 1 0 0 0 0 1)"
	
	FACTOR=10
	mFrustum -10 10 10 -10 20 100 v3
	assertL mFrustum v3 "(MAT 20 0 0 0 0 -20 0 0 0 0 -15 50 0 0 -10 0)"
	FACTOR=1
}

main
