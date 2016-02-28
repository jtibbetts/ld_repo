basedir=$1
for dir in $(find "$basedir" -type d); do
	container=$(basename "$dir")
	for f in $(find $dir -type f -maxdepth 1); do
		full_filename=$(basename "$f")
		extension="${full_filename##*.}"
		filename="${full_filename%.*}"
		# echo Directory: $dir  Container: $container   Filename: $full_filename  #Extension: $extension

		# if file is already in the correct form we're done with this dir
		try_file=${PWD}/$dir/$container.$extension
		if [[ $extension =~ (jsonld|ttl|rdf|html) ]]; then
			if [ -f "$try_file" ]
			then
				: # echo $try_file ALREADY CORRECT
			fi
		else
			# create a new file
			if [[ $extension =~ (json|jsonld) ]]; then
				# Uncomment following if downcasing filename is desired
				# container=$(echo "$container"|tr '[A-Z]' '[a-z]')

				source_filename=${PWD}/$dir/$filename.$extension
				if [[ $filename == $container ]]; then
					target_filename=${PWD}/$dir/$container.jsonld
					cp ${PWD}/$dir/$full_filename $target_filename
				# normalize Greg name
				elif [[ $filename == "JSON_LD_CONTEXT" ]]; then
					target_filename=${PWD}/$dir/$container.jsonld
					cp ${PWD}/$dir/$full_filename  $target_filename
				fi
				echo "$source_filename COPIED TO $target_filename "
			else
				echo ${PWD}/$dir/$full_filename UN-HANDLED
			fi
		fi
	done
done
