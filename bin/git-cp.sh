#!/bin/sh
commit=${1}
savePath=${2}
ext="tar.gz"

fname="${savePath}.${ext}"
delFile="DELETE"

changes=$(git diff --diff-filter=ACMRT --name-status ${commit} --)
deleted=$(git diff --diff-filter=D --name-status ${commit} --)

# extract added and modified files
ch=$(echo "${changes}" | awk '{if($1~"A|M") print $2}')
echo "${ch}" | xargs tar -rvf "${fname}"

# extract deleted files
de=$(echo "${changes}" | awk '{if($1=="D") print $2}')
echo "${de}" > "${TMPDIR}/${delFile}"
tar -rvf "${fname}" -C "${TMPDIR}" "${delFile}"
rm -f "${TMPDIR}/${delFile}"
