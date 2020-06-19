{{ define "lib.deployment_nfs" }}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}
  namespace: "{{ .Values.namespace }}"
  {{- template "lib.labels" . }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      id.proctor.service: "{{ .Release.Name }}"
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        id.proctor.service: "{{ .Release.Name }}"
    spec:
      nodeSelector:
        kubernetes.io/arch: "{{ .Values.cpuType }}"
      containers:
        - image: "{{ .Values.image.repository}}"
          name: "{{ .Release.Name }}"
          imagePullPolicy: "{{ .Values.image.pullPolicy }}"
          resources:
            limits:
              memory: "{{ .Values.resources.limits.memory }}"
              cpu: "{{ .Values.resources.limits.cpu }}"
            requests:
              memory: "{{ .Values.resources.requests.memory }}"
              cpu: "{{ .Values.resources.requests.cpu }}"
          volumeMounts:
            - name: "{{ .Release.Name }}-data"
              mountPath: "{{ .Values.nfsMountPath }}"
          ports:
            - containerPort: 80
      volumes:
        - name: "{{ .Release.Name }}-data"
          persistentVolumeClaim:
            claimName: "{{ .Release.Name }}-claim"
      restartPolicy: Always
{{ end }}