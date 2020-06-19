package chart:
    helm package -u "charts/{{chart}}" --destination out

lint chart:
    helm lint "charts/{{chart}}"

package-all:
    helm package -u charts/* --destination out

lint-all:
    helm lint charts/*

ci:
    docker build -t helm-ci .
    docker run --rm -it \
        -e "GITHUB_REPOSITORY=https://github.com/proctorlabs/charts" \
        -v $PWD:/ci \
        helm-ci BADTOKEN
