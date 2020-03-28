#!/bin/bash

get_filename () {
	if [[ $1 == *CMakeLists.txt ]]; then
		if [ $1 == "CMakeLists.txt" ]; then
			echo "packages/CMakeLists.txt"
		else
			echo $1
		fi
	else
		local make_file="packages/$1.cmake"
		if [ -f "$make_file" ]; then
			echo $make_file
		else
			echo "toolchain/$1.cmake"
		fi
	fi 
}

replace_option () {
	echo "replace_option $1 $2 $3"
	
	sed -i "s/$2/$3/g" $(get_filename $1)
}

append_option () {
	echo "append_option $1 $3"
	
	fn=$(get_filename "$1")
	
	if ! grep -- "$3" $fn; then
		sed -i "/$2/a \        $3" $fn
	fi >/dev/null 2>&1
}

append_option_exact  () {
	echo "append_option $1 $3"
	
	fn=$(get_filename "$1")

	if ! (grep -A1 "$2"  $fn | grep -- "$3"); then
		sed -i "/$2/a \    $3"  $fn
	fi >/dev/null 2>&1
}

add_option () {
	echo "add_option $1 $3"
	
	fn=$(get_filename "$1")

	if ! (grep -A1 "$2" $fn | grep -- "$3"); then
		sed -i "/$2/i \    $3" $fn
	fi >/dev/null 2>&1
}

comment_line () {
	echo "comment_line $1 $2"

	sed -i "/^\s*$2/s/^/#/g" $(get_filename $1)
}

uncomment_line () {
	echo "uncomment_line $1 $2"
	sed -i '/$2/s/^#//g' $(get_filename $1)
}

delete_line () {
	echo "delete_line $1 $2"

	sed -i "/$2/d" $(get_filename $1)
}

replace_patch () {
	sed -i "s/$2/$3/g" packages/$1.patch
}
