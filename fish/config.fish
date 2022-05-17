if status is-interactive
    # Commands to run in interactive sessions can go here
    # fish_config prompt choose informative_vcs
    fish_config theme choose Dracula
    set fish_color_cwd blue
    # alias maps
    alias clear="clear && fish_greeting"
    alias c=clear
end
function fish_greeting
    echo (set_color purple) \t=＾• ⋏ •＾=(set_color blue) ᵐᵉᵒʷˎˊ˗
end
