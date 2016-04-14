#! /usr/bin/env bats

#
# Unit tests for chext
#

setup() {
  mkdir .chext
}

teardown() {
  rm -rf .chext/
}

@test "Check usage message" {
  run chext.sh
  usage_msg="usage: chext [-i] [-v] source ... extension"
  [ "$usage_msg" == "$output" ]
}

@test "Change one extension" {
  cd .chext
  touch foo.bar
  run ../chext.sh foo.bar baz
  [ ! -e foo.bar ]
  [ -e foo.baz ]
  cd ..
}

@test "Change multiple extensions" {
  cd .chext
  touch foo.bar qux.bar
  run ../chext.sh *.bar baz
  [ ! -e foo.bar ]
  [ ! -e qux.bar ]
  [ -e foo.baz ]
  [ -e qux.baz ]
  cd ..
}

@test "Check verbose mode" {
  cd .chext
  touch foo.bar
  run ../chext.sh -v foo.bar baz
  verbose_msg="foo.bar -> foo.baz"
  [ "$verbose_msg" == "$output" ]
  cd ..
}

@test "Try to change extension of non-existant file" {
  cd .chext
  run ../chext.sh foo.bar baz
  errmsg="chext: change extension of foo.bar to baz: No such file"
  [ "$errmsg" == "$output" ]
  [ ! -e foo.bar ]
  [ ! -e foo.baz ]
  [ ! -e baz ]
  cd ..
}

@test "Check for existence of extension" {
  cd .chext
  touch foo
  run ../chext.sh foo bar
  errmsg="chext: change extension of foo to bar: File has no extension"
  [ "$errmsg" == "$output" ]
  [ -e foo ]
  [ ! -e bar ]
  [ ! -e foo.bar ]
  cd ..
}

@test "Check that chext doesn't accidentally move a hidden file" {
  cd .chext
  touch .foo
  run ../chext.sh .foo bar
  errmsg="chext: change extension of .foo to bar: File has no extension"
  [ "$errmsg" == "$output" ]
  [ -e .foo ]
  [ ! -e .bar ]
  [ ! -e bar ]
  cd ..
}

@test "Check interactive mode (y)" {
  cd .chext
  touch foo.bar foo.baz
  run bash -c "echo y | ../chext.sh -i foo.* qux"
  [ -e foo.qux ]
  [ ! -e foo.bar ]
  [ ! -e foo.baz ]
  cd ..
}

@test "Check interactive mode (n)" {
  cd .chext
  touch foo.bar foo.baz
  run bash -c "echo n | ../chext.sh -i foo.* qux"
  [ -e foo.qux ]
  [ ! -e foo.bar ]
  [ -e foo.baz ]
  cd ..
}
