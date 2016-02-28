# vim: set filetype=sh:

string_escape() { echo -n "$1" | sed -re 's/([] "$!()[])/\\\1/g' ; }
compgen_fuzzy_path ()
{
	local path="$1"
	local path_parts sufx
	IFS='/' read -a path_parts <<< "$path"

	[ -z "${path_parts[0]}" ] && local absolute_path=1

	for index in "${!path_parts[@]}" ; do
		path_parts[index]=$(string_escape "${path_parts[index]}*")
	done

	if [ -n "$absolute_path" ]; then
		path_parts[0]=""
	fi

	path=$(IFS=/ ; echo -ne "${path_parts[*]}")
	eval "shopt -s nullglob ; ls -d1 $path"
}

cd ()
{
	target_path=$(compgen_fuzzy_path "$1" | head -n1)
	if [ "$target_path" == "." ]; then
		builtin cd "$@"
	else
		echo "$target_path" 1>&2
		builtin cd "$target_path"
	fi
}

