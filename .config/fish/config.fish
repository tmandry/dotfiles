set -x EDITOR vim

abbr apt aptitude

abbr be bundle exec

abbr g git
abbr gcam git commit -am
abbr gcaa git commit -a --amend
abbr gcm git commit -m
abbr gs git status
abbr gd git diff
abbr ga git add
abbr gl1 git log -1
abbr fx git commit -m \'fx\'
abbr afx git commit -am \'fx\'

if status --is-interactive
  function fish_user_key_bindings
    # fish_vi_key_bindings: set below

    # use default bindings for everything in insert mode
    fish_default_key_bindings -M insert
    # ..except escape, which exits insert mode
    bind -M insert \e "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"

    bind -M insert \ce forward-word
  end

  set -g fish_key_bindings fish_vi_key_bindings
end

function fish_mode_prompt
  # NOOP - disable default mode indicator before prompt
end
