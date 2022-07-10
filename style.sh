#!/bin/bash

cd "${GITHUB_WORKSPACE}" || exit 1

# https://github.com/reviewdog/reviewdog/issues/1158
git config --global --add safe.directory "$GITHUB_WORKSPACE" || exit 1

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

sources=$(find "${INPUT_PATH}" -not -path "${INPUT_EXCLUDE}" -type f -name "${INPUT_PATTERN}")

echo "::group::Files to style"
echo "${sources}"
echo "::endgroup::"

cljstyle fix
  | reviewdog \
      -efm="%f:%l:%c: %m" \
      -name="cljstyle" \
      -reporter="${INPUT_REPORTER}" \
      -filter-mode="${INPUT_FILTER_MODE}" \
      -fail-on-error="${INPUT_FAIL_ON_ERROR}" \
      -level="${INPUT_LEVEL}" \
      "${INPUT_REVIEWDOG_FLAGS}"

exit_code=$?

exit $exit_code
