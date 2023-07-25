#!/bin/bash

# 引数の個数チェック
if [ $# != 2 ]; then
    echo "Please input 2 natural number"
    exit 1
fi

# 自然数チェック
function check_nn() {
  # 数字以外を含んだ場合 exit 1
  if echo "$1" | grep -q '\D' ;then
    echo "$1 is not a natural number."
    exit 1
  # 0, 001 等の入力を排除するために、先頭が0の場合はexit 1
  elif echo "$1" | grep -q "^0";then
    echo "$1 is not a natural number."
    exit 1
  # 自然数なので0以上の整数。マイナス(文頭に'-')や、小数や乗数等記号(., ^)を含む場合を排除するため、[0-9]を任意の0回以上回数繰り返すパターンを条件とする
  elif echo "$1" | grep -q "^[0-9]*$";then
    return 0
  fi
}

# 最大公約数(great common divisor)チェック。ユークリッドの互助法にて実装
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