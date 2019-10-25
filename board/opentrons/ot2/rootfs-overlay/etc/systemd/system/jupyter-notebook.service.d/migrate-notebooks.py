#!/usr/bin/env python

""" migrate-notebooks.py: move jupyter notebooks created before the
buildroot migration into the directory jupyter uses for its notebooks on
buildroot
"""

import argparse
from pathlib import Path
import shutil
import sys


def main(resin_data: str,
         old_jupyter_path: str,
         dest_dir: str,
         dummy: bool) -> int:
    """ Copy the files.

    resin_data should be the path to the resin data dir; all application ids
    will then be searched.

    old_jupyter_path is the in-container path to the jupyter files

    dest_dir is where to copy to

    dummy will prevent file operations from being made
    """
    resin_data = Path(resin_data)
    assert resin_data.is_dir(), f'{resin_data} is not a directory'

    dest_path = Path(dest_dir)
    if not dest_path.exists():
        dest_path.mkdir(parents=True, exist_ok=True)
    if not dest_path.is_dir():
        raise OSError(f"Can't create {dest_path}, exists and not dir")

    for resin_root in resin_data.iterdir():
        from_dir_path = resin_root / Path(old_jupyter_path)
        if not from_dir_path.is_dir():
            print(f"Ignoring non-dir {from_dir_path}")
            continue

        def copy_with_suffix(src, dst, *, follow_symlinks=True):
            spath = Path(src)
            ddir = Path(dst)
            dpath_orig = ddir/spath.name
            dpath = ddir/spath.name
            suffix = 1
            while dpath.exists():
                dpath = dpath_orig.with_name(
                    spath.stem + f'-{suffix}' + ''.join(spath.suffixes))
                suffix += 1
            # at this point we can use shutil.copytree because we just made
            # sure the path was unique
            if spath.is_dir():
                print(f"copytree {src}->{str(dpath)}")
                if not dummy:
                    shutil.copytree(src, str(dpath))
            else:
                print(f"copy2 {src}->{str(dpath)}")
                if not dummy:
                    shutil.copy2(src, str(dpath))

        for child in from_dir_path.iterdir():
            copy_with_suffix(child, dest_dir)
        print(f"rm -r {from_dir_path}")
        if not dummy:
            shutil.rmtree(str(from_dir_path), ignore_errors=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Move jupyter notebook files from resin-data.'
        'Files will have unique suffixes added if necessary to '
        'prevent conflicts in the destination. The destination will be created '
        'if it does not exist. File structure in the origin directories will '
        'be mirrored in the output directory.')
    parser.add_argument('-d', '--dummy',
                        help='Just print actions instead of moving files',
                        action='store_true')
    parser.add_argument('-s', '--swallow-errors', action='store_true',
                        help='Print errors to stderr but always return 0')
    parser.add_argument('resin_data', metavar='RESIN_DATA',
                        help='path to the resin data (probably /var/resin-data)')
    parser.add_argument('old_path', metavar='OLD_NOTEBOOK_PATH',
                        help='Path to jupyter notebook dirs in resin paths')
    parser.add_argument('dest_dir', metavar='DEST',
                        help='Destination directory for notebooks. The leaf'
                        ' directory will be created if it does not exist.')
    args = parser.parse_args()
    try:
        sys.exit(main(args.resin_data, args.old_path, args.dest_dir, args.dummy))
    except Exception as e:
        sys.stderr.write(str(e))
        if args.swallow_errors:
            sys.exit(0)
        else:
            sys.exit(-1)
