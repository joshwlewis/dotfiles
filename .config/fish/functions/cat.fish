# Use bat for cat (batcat on Ubuntu)
function cat
    if type -q batcat
        batcat --paging=never $argv
    else if type -q bat
        bat --paging=never $argv
    else
        command cat $argv
    end
end
