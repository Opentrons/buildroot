#!/bin/sh

# migrate-nobteooks.sh: move jupyter notebooks created before the migration to
# buildroot into the directory jupyter uses for its notebooks on buildroot

# if this robot doesn't have /var/resin-data, then it wasn't migrated from
# balena, and we don't have to check for old notebooks
if [ ! -d /var/resin-data ] ; then
    exit 0
fi

NOTEBOOK_DIR="${STATE_DIRECTORY}/jupyter/notebooks"

# get any notebooks saved in the old notebook directories. we have to use find
# -name here because this is the old balena /data root, which invisibly to the
# old containers actually had the application id in the path; we lost that id
# after migration, so we have to search all of them.
notebooks=$(find /var/resin-data -name *.ipynb | grep -v '.*ipynb_checkpoints.*')

for nb in $notebooks; do
    _filename=$(basename "$nb")
    _basename=$(basename "$_filename" ".ipynb")
    if [ -e "${NOTEBOOK_DIR}/${_filename}" ]; then
        echo "${NOTEBOOK_DIR}/${_filename} exists"
        _suffix=1
        while [ -e "${NOTEBOOK_DIR}/${_basename}-${_suffix}.ipynb" ]; do
            echo "${NOTEBOOK_DIR}/${_basename}-${_suffix}.ipynb exists"
            ++_suffix
        done;
        _newname="${_basename}-${_suffix}.ipynb"
        echo "${NOTEBOOK_DIR}/${_newname} OK"
    else
        _newname=$_filename
    fi
    echo "${nb} -> ${NOTEBOOK_DIR}/${_newname}"
    mv "${nb}" "${NOTEBOOK_DIR}/${_newname}"
done

