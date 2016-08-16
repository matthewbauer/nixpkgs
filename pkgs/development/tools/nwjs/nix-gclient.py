#!/usr/bin/env python

# This should work with "gclient" repositories which have DEPS
# in the root of the tree. This will fetch all of the git repositories,
# so it may take a long time.

# Run
# $ python parse-deps.py > ./deps.nix < ./DEPS
# with the latest DEPS file
# to regenerate deps.nix.

# Use this to unpack them:
#   postUnpack = ''
#     ${lib.concatStringsSep "\n" (
#       lib.mapAttrsToList (n: v: ''
#          mkdir -p $sourceRoot/${n}
#          cp -r ${v}/* $sourceRoot/${n}
#        '') deps)}
#   '';

import subprocess
import sys
import json

deps_obj = compile(sys.stdin.read(), "stdin", 'exec')

# needed by DEPS
def Var(attr):
    return vars[attr]

exec deps_obj

def dep_str(key, value):
    key = key.replace("src/", "")
    (url, rev) = value.split("@")
    proc = subprocess.Popen(['nix-prefetch-git', '--quiet', '--url', url, '--rev', rev], stdout=subprocess.PIPE)
    out = proc.communicate()[0]
    data = json.loads(out)
    sha256 = data["sha256"]

    # eventually refactory this to download from googlesource.com tarball
    return """
  "{}" = fetchgit {{
    url = "{}";
    rev = "{}";
    sha256 = "{}";
  }};""".format(key, url, rev, sha256)

deps_str = "".join([dep_str(key, value) for key, value in deps.iteritems()])
deps_str_mac = "".join([dep_str(key, value) for key, value in deps_os["mac"].iteritems()])

nix_expr = """
# run "python parse-deps.py > ./deps.nix < ./DEPS" to regenerate this.

{{ fetchgit }}:

{{
{0}
}}""".format(deps_str + deps_str_mac)

print(nix_expr)
