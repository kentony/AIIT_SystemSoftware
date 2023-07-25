#!/bin/bash

#
# 最大公約数算出するスクリプト
#

# 数値チェック自然数のみ
check_number() {
  if expr "$1" : "^[0-9]*$" >&/dev/null;then
    return 0
  else
    echo -e "Error!"
    exit 1
  fi

}

# 最大公約数の計算
gcd() {
    # Euclidean Algorithm
    # 1. 入力を m, n (m ≧ n) とする。
    # 2. n = 0 なら、 m を出力してアルゴリズムを終了する。
    # 3. m を n で割った余りを新たに n とし、更に 元のnを新たにm とし 2. に戻る。
    while [ !  0 -eq "$2" ]; do
	    set -- "$2" "`expr "$1" % "$2"`"
	done
	echo "$1"
}

#
# Main処理
#

check_number $1
check_number $2
gcd $1 $2