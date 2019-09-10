#!/bin/sh

# migrate-nobteooks.sh: move jupyter notebooks created before the migration to
# buildroot into the directory jupyter uses for its notebooks on buildroot

# if this robot doesn't have /var/resin-data, then it wasn't migrated from
# balena, and we don't have to check for old notebooks
if [ ! -d /var/resin-data ] ; then
    exit 0
fi

function migrate_notebook_dir {
    # Migrate an old notebook dir to a new one. Anything at the top level of
    # the notebook dir with a name that exists in the new directory will be
    # renamed with a numerical suffix
    _from=$1
    _to=$2
    echo "Migrating ${_from} to ${_to}"
    for _bn in $(ls "${_from}"); do
        _dest="${_to}/${_bn}"
        if [ -e "${_dest}" ]; then
            if [ -f "${_dest}" ]; then
               _fname="${_bn%.*}"
               _fext="${_bn##*.}"
               _fsuffix=1
               while [ -e "${_dest}" ]; do
                   echo "${_dest} exists"
                   _dest="${_to}/${_fname}-${_fsuffix}.${_fext}"
                   _fsuffix=$(( _fsuffix + 1 ))
               done;
            else
                _dsuffix=1
                while [ -e "${_dest}" ]; do
                    echo "${_dest} exists"
                    _dest="${_to}/${_bn}-${_dsuffix}"
                    _dsuffix=$(( _dsuffix + 1 ))
                done;
            fi
        fi
        echo "${_from}/${_bn} -> ${_dest}"
        mv "${_from}/${_bn}" "${_dest}"
    done;
}

# Find any and all old notebook directories
notebook_dirs=$(find /var/resin-data \
                     -name jupyter \
                     -type d \
                     -path "*/user_storage/opentrons_data/*")

for nb in $notebook_dirs; do
    migrate_notebook_dir "${nb}" "${JUPYTER_NOTEBOOK_DIR}"
done
