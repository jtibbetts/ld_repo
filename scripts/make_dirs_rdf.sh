#!/usr/bin/env bash
basedir=$1
for dir in $(find "$basedir" -type d); do
	container=$(basename "$dir")
	for f in $(find $dir -type f -maxdepth 1); do
		full_filename=$(basename "$f")
		extension="${full_filename##*.}"
		filename="${full_filename%.*}"
		# echo Directory: $dir  Container: $container   Full_filename: $full_filename  #Extension: $extension

		# if file is already in the correct form we're done with this dir
		try_file=${PWD}/$dir/$container.$extension
		if [[ $extension =~ (jsonld|ttl|rdf|html) ]]; then
			if [ -f "$try_file" ]
			then
				echo $try_file ALREADY CORRECT
				continue
			fi
		fi

		source_filename=${PWD}/$dir/$filename.$extension
		# create a new file
		if [[ $extension =~ (json|jsonld) ]]; then
			# Uncomment following if downcasing filename is desired
			# container=$(echo "$container"|tr '[A-Z]' '[a-z]')

			if [[ $filename == $container ]]; then
				target_filename=${PWD}/$dir/_content_.jsonld
				cp ${PWD}/$dir/$full_filename $target_filename
			# normalize Greg name
			elif [[ $filename == "JSON_LD_CONTEXT" ]]; then
				target_filename=${PWD}/$dir/_content_.jsonld
				cp ${PWD}/$dir/$full_filename  $target_filename
			fi
			echo "$source_filename COPIED TO $target_filename "
		elif [[ $full_filename == 'TURTLE.ttl' ]]; then
			target_filename=${PWD}/$dir/_content_.ttl
			cp ${PWD}/$dir/$full_filename  $target_filename
			echo "$source_filename COPIED TO $target_filename "
		elif [[ full_filename == 'index.html' ]]; then
			target_filename=${PWD}/$dir/_content_.html
			cp ${PWD}/$dir/$full_filename  $target_filename
			echo "$source_filename COPIED TO $target_filename "
		else
			echo ${PWD}/$dir/$full_filename UN-HANDLED
		fi
	done
done
