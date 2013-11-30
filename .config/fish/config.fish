set -x EDITOR vim

function fish_user_key_bindings
	. ~/.config/fish/vi-mode.fish
        vi_mode_insert
end

alias apt=aptitude

function make_completion --argument alias command
    complete -c $alias -xa "(
        set -l cmd (commandline -pc | sed -e 's/^ *\S\+ *//' );
        complete -C\"$command \$cmd\";
    )"
end

function g; git $argv; end
make_completion g git

function gco; git co $argv; end
make_completion gco 'git checkout'

function grb; git rb $argv; end
make_completion grb 'git rebase'

function gcm; git commit $argv; end
make_completion gcm 'git commit'

function ga; git add $argv; end
make_completion ga 'git add'
