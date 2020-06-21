package chart:
    helm package -u "charts/{{chart}}" --destination out

lint chart:
    helm lint "charts/{{chart}}"

package-all:
    helm package -u charts/* --destination out

lint-all:
    helm lint charts/*

render chart:
    helm package -u "charts/{{chart}}" --destination out
    helm template --debug "charts/{{chart}}" | tee "out/{{chart}}.yml"

watch chart:
    watchexec -i *.tgz -i *.lock -i tmpcharts -i out -i "{{chart}}/charts" just render "{{chart}}"

debug chart:
    helm package -u "charts/{{chart}}" --destination out
    helm install "{{chart}}" "charts/{{chart}}" --debug --dry-run

new chart:
    cp -r ref "charts/{{chart}}"

ci:
    docker build -t helm-ci .
    docker run --rm -it \
        -e "GITHUB_REPOSITORY=https://github.com/proctorlabs/charts" \
        -v $PWD:/ci \
        helm-ci BADTOKEN
