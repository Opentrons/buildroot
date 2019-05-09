#!/usr/bin/env python3
import sys
import argparse
import boto3


def get_parameter(param_name):
    session = boto3.session.Session(region_name='us-east-2')
    cli = session.client('ssm')
    return cli.get_parameter(
        Name=param_name, WithDecryption=True)['Parameter']['Value']


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Pull a parameter')
    parser.add_argument('param_name', metavar='PARAM', type=str)
    parser.add_argument('output', metavar='OUTPUT',
                        default='-', type=argparse.FileType('w'),
                        help='Where to write the output (default: stdout)')
    args = parser.parse_args()
    try:
        param = get_parameter(args.param_name)
    except Exception as e:
        sys.stderr.write('Failed to get param {0}: {1}\n'.format(args.param_name, repr(e)))
        param = ''
    args.output.write(param)
