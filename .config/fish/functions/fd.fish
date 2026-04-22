# On Ubuntu, fd is installed as fdfind
function fd
    if type -q fdfind
        fdfind $argv
    else
        command fd $argv
    end
end
