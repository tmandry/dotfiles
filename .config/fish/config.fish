set -x EDITOR vim

function fish_user_key_bindings
	. ~/.config/fish/vi-mode.fish
        vi_mode_insert
end

abbr apt aptitude

abbr be bundle exec

abbr g git
abbr gcam git commit -am
abbr gcaa git commit -a --amend
abbr gcm git commit -m
abbr gs git status
abbr gd git diff
abbr ga git add
