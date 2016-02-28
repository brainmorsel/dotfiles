
command_exec_trap ()
{
	# run only once after prompt
	if [ "$__comman_exec_trap_lock" -eq 0 ]; then
		return
	fi
	__comman_exec_trap_lock=0

	# show command start time
	local datestr=$(date +%T)
	echo -ne "\e[s\e[2A\e[$(( $COLUMNS - ${#datestr} - 2 ))C\e[37m$datestr\e[u"
	# reset output color after entering command
	echo -ne "\e[0m"
}
# make fancy prompt
fancy_prompt ()
{
	# Return value visualisation
	local retcode=$?

	# colors:
	local RST="\[\e[0m\]"    # reset
	local CL1="\[\e[0;31m\]" # red
	local CL2="\[\e[0;32m\]" # green
	local CL3="\[\e[1;35m\]" # light grey
	local CL4="\[\e[0;34m\]" # light blue
	local CL5="\[\e[0;33m\]" # orange
	local CL6="\[\e[0;36m\]" # 
	local BEEP="\[\a\]"

	if [ $retcode -eq 0 ];then
		local RET="$CL2:)$RST"
	else
		local RET="$CL1:($RST"
	fi

	local tty_width=$(stty size | cut -f2 -d' ')

	local time=$(date +%T)
	local wdir=$(pwd | sed "s:^$HOME:~:")
	local user=$(whoami)
	local host=$(hostname)
	local git=$(__git_ps1 " (g:%s)")

	if [[ -n "$VIRTUAL_ENV" ]] ; then
		local py_virt_env=$(printf " (py:%s)" `basename "$VIRTUAL_ENV"`)
	fi

	local decor_size=15
	local freespace=$(( $tty_width - ( $decor_size + \
	    ${#time} * 2 + ${#user} + ${#host} + ${#py_virt_env} + ${#git} ) ))

	if ! [ ${#wdir} -lt $freespace ]; then
		local path_parts
		# collapse path parts until it fits line
		IFS='/' read -a path_parts <<< "$wdir"
		for index in "${!path_parts[@]}" ; do
			local part="${path_parts[index]}"
			path_parts[$index]=${part:0:1}
			wdir=$( IFS=/ ; echo "${path_parts[*]}" )
			if [ ${#wdir} -lt $freespace ]; then
				break
			fi
		done
	fi

	local padline_len=$(( $freespace - ${#wdir} ))
	local padline=$(seq 1 $padline_len | sed 's/.*/─/' | tr -d '\n')

	PS1=$(printf "$BEEP$RST┌╼ $CL3%s@%s$RST:$CL4%s$RST%s%s ╾%s╼ $RET $CL6%s$RST/--:--:-- ╾\n└╼ \$ $CL5" \
		"$user" "$host" "$wdir" "$git" "$py_virt_env" "$padline" "$time")

	if [ "$TERM" != 'screen' ] ; then
		check_cursor_pos
	fi

    # save history after each command
    history -a

	__comman_exec_trap_lock=1
}

__comman_exec_trap_lock=0
trap command_exec_trap DEBUG
PROMPT_COMMAND="fancy_prompt"
