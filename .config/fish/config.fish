fish_vi_key_bindings

if type -q mise
    mise activate fish | source
end

if status is-interactive
    if type -q starship
        starship init fish | source
    end
end
