#!/usr/bin/env bash
set -Eeuo pipefail

GITHUB_TOKEN=$1
CHARTS_DIR="charts"
OWNER=$(cut -d '/' -f 1 <<<"$GITHUB_REPOSITORY")
REPOSITORY=$(cut -d '/' -f 2 <<<"$GITHUB_REPOSITORY")
BRANCH="gh-pages"
CHARTS_URL="https://${OWNER}.github.io/${REPOSITORY}"

CHARTS_TMP_DIR=$(mktemp -d)
REPO_ROOT=$(git rev-parse --show-toplevel)
REPO_URL="https://x-access-token:${GITHUB_TOKEN}@github.com/${OWNER}/${REPOSITORY}"

helm package -u ${REPO_ROOT}/${CHARTS_DIR}/* --destination ${CHARTS_TMP_DIR}
helm lint ${REPO_ROOT}/${CHARTS_DIR}/*
cp ${REPO_ROOT}/README.md ${CHARTS_TMP_DIR}

upload() {
    tmpDir=$(mktemp -d)
    pushd $tmpDir >&/dev/null

    git clone ${REPO_URL}
    cd ${REPOSITORY}
    git config user.name "${GITHUB_ACTOR}"
    git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
    git remote set-url origin ${REPO_URL}
    git checkout gh-pages

    charts=$(cd ${CHARTS_TMP_DIR} && ls *.tgz | xargs)

    mv -f ${CHARTS_TMP_DIR}/*.tgz .
    helm repo index . --url ${CHARTS_URL}
    mv -f ${CHARTS_TMP_DIR}/README.md .

    git add .
    git commit -m "Publish $charts"
    git push origin gh-pages

    popd >&/dev/null
    rm -rf $tmpDir
}

upload
