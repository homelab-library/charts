package chart:
    helm package -u "charts/{{chart}}" --destination out

lint chart:
    helm lint "charts/{{chart}}"

package-all:
    helm package -u charts/* --destination out

lint-all:
    helm lint charts/*
