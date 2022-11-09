#!/usr/bin/env bash

# Utilities for the opentrons build container.


if [[ -n "${CI}" ]]; then
   filter_arg="--build-arg filter_output=true"
fi

githubname="$(git describe --all --dirty --always | tr '[:upper:]' '[:lower:]')"
imgname=ghcr.io/opentrons/buildroot
noheads=${githubname/heads//}
imgtag=${noheads:2}



help () {
    cat <<EOF
$0: Utilities for opentrons build container. Argument is a single word:
   $0 build: build a container locally and return its name
   $0 push: push a container. It will be the last one built.
   $0 build-push: build a container then push it.
   $0 pull: pull the latest container for running
EOF
    exit 1
}

build () {
    docker build ${filter_arg} -t ${imgname}:${imgtag} -t ${imgname}:latest . 1>&2 || exit 1
    echo ${imgname}:${imgtag}
}

push () {
    docker push ${imgname}:latest 1>&2 || exit 1
    echo ${imgname}:latest
}

pull () {
    docker pull ${imgname}:latest 1>&2 || exit 1
    echo ${imgname}:latest
}


case $# in
    0)
        help
        ;;
    *)
        case $1 in
            build)
                build && exit 0
            ;;
            push)
                push && exit 0
            ;;
            build-push)
                build && push && exit 0
            ;;
            pull)
                pull && exit 0
            ;;
            *)
                help
                ;;
        esac
esac
