#!/bin/bash

function check_nn() {
  if 
  if echo "$1" | grep -q "^[0-9]*$";then
  # 自然数なので0以上の整数。マイナス(文頭に'-')や、小数や乗数等記号(., ^)を含む場合を排除するため、[1-9]を任意の回数繰り返しにしています。
    return 0
  elif [ -z "$1" ]; then
    echo "$1 is not a number."
    exit 1
  else
    echo "$1 is not a number."
    exit 1
  fi
}

function gcdiv() {
  local m=$1;
  local n=$2;
  # $1, $2はこの関数の中だけで変化してほしいのでlocalで変数m,nとして宣言
  if [ "$2" -eq 0 ];then
    echo "$m"
  else
    echo $(gcdiv $n $(($m % $n)) );
  fi
}

check_nn $1
check_nn $2
gcdiv $1 $2