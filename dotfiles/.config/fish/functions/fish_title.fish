function fish_title
	if [ $_ = "fish" ]
		echo -s $USER @ "$__fish_prompt_hostname" " " (prompt_pwd)
	else
		echo $_
	end
end
