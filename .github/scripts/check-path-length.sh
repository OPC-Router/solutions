#!/usr/bin/env bash
# Fails when a file path in the gallery is too long to be installed on Windows.
#
# The product stores the gallery under
#   C:\ProgramData\inray\OPC Router 5\config\solution-gallery\<source id>\
# where <source id> is 8 characters (24 in versions before tp#354132), so up to
# 83 characters precede every path of this repository. Windows limits a full
# path to 259 characters (MAX_PATH 260 including the terminating NUL). That
# leaves 176 characters. The default limit keeps a small safety margin.
set -euo pipefail

export LC_ALL=C.UTF-8

# Allow the default safety margin to be adjusted through an environment variable.
limit="${MAX_SOLUTION_PATH_LENGTH:-170}"
failed=0
longest=0

# Measure paths from the repository root, regardless of where this script is run.
cd "$(git rev-parse --show-toplevel)"

# Read the NUL-delimited paths emitted by find -print0:
#   IFS=  preserves leading and trailing whitespace.
#   -r    treats backslashes literally.
#   -d '' uses NUL as the delimiter, allowing newlines within filenames.
# Process substitution (< <(...)) keeps the loop in this shell so updates to
# failed and longest remain available after the loop.
while IFS= read -r -d '' file; do
  # Exclude find's leading ./ from the repository-relative path length.
  rel="${file#./}"
  len=${#rel}

  if (( len > longest )); then
    longest=$len
  fi

  if (( len > limit )); then
    # Emit a GitHub Actions error annotation, then keep checking the other files.
    echo "::error file=${rel}::Path is ${len} characters long (limit ${limit}). Shorten the Solution, Flow or parameter names so the Solution can be installed on Windows."
    failed=1
  fi
done < <(
  # Exclude repository metadata, CI configuration, and image assets.
  find . -type f \
    -not -path './.git/*' \
    -not -path './.github/*' \
    -not -path './img/*' \
    -print0
)

echo "Longest path: ${longest} characters (limit ${limit})."
exit $failed
