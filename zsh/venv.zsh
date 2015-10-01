export WORKON_HOME=~/.virtualenvs
mkdir -p $WORKON_HOME
source /opt/boxen/homebrew/bin/virtualenvwrapper.sh


function repair_venv() {
    for venv in "$@"
    do
        python=$(venv_python_version "$venv")
        echo "--> Repairing $venv ($python)"
        find "$venv" -type l -delete
        virtualenv --python $python "$venv"
        echo ""
    done
}

function venv_python_version() {
    which $(ls "$1/lib/")
}
