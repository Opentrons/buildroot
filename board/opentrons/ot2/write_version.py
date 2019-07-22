import json
import os
import subprocess
import argparse
print("Getting git data from cwd %s" % os.getcwd())
try:
    br_version = subprocess.check_output(
        ['git', 'describe', '--tags', '--always'],
        stderr=subprocess.STDOUT).decode().strip()
except subprocess.CalledProcessError as cpe:
    print("{}: {}: {}".format(cpe.cmd, cpe.returncode, cpe.stdout))
    print("Defaulting to (unknown)")
    br_version = 'unknown'

try:
    br_sha = subprocess.check_output(
        ['git', 'rev-parse', 'HEAD'],
        stderr=subprocess.STDOUT).decode().strip()
except subprocess.CalledProcessError as cpe:
    print("{}: {}: {}".format(cpe.cmd, cpe.returncode, cpe.stdout))
    print("Defaulting to (unknown)")
    br_sha = 'unknown'

try:
    br_branch_from_git = subprocess.check_output(
        ['git', 'rev-parse', '--abbrev-ref', 'HEAD'],
        stderr=subprocess.STDOUT).decode().strip()
except subprocess.CalledProcessError as cpe:
    print("{}: {}: {}".format(cpe.cmd, cpe.returncode, cpe.stdout))
    print("Defaulting to (unknown)")
    br_branch_from_git = 'unknown'

br_branch = os.getenv('CODEBUILD_SOURCE_VERSION', br_branch_from_git)
build_id = os.getenv('CODEBUILD_BUILD_ID', 'dev')

parser = argparse.ArgumentParser(description='Write a version file to buildroot')
parser.add_argument('in_versions', metavar='IN_VERSIONS',
                    type=argparse.FileType('r'), nargs='+',
                    help='A list of files to read versions from. These should '
                         'be json files with non-overlapping keys that will be'
                         ' unified (along with the buildroot version from git)'
                         ' into the final product.')
parser.add_argument('outfile', metavar='OUT', type=argparse.FileType('w'),
                    help='The file to write to')
args = parser.parse_args()

version_dict = {'buildroot_version': br_version,
                'buildroot_sha': br_sha,
                'buildroot_branch': br_branch,
                'buildroot_buildid': build_id,
                'build_type': os.getenv('OT_BUILD_TYPE', 'unknown/dev')}

for f in args.in_versions:
    version_dict.update(json.load(f))

json.dump(version_dict, args.outfile)
