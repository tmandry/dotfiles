function fish_user_key_bindings
#  set -l mode

  #if functions -q fish_vi_key_bindings
    #bind --erase --all
    # put default key bindings back in insert mode
    fish_default_key_bindings -M insert -m insert
    fish_vi_key_bindings --no-erase
    #set mode -M insert -m insert
  #end
end
