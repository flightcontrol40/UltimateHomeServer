{{ define "common.apiKey" }}
{{- $secretName := .secretName -}}
{{- $secretKey := .secretKey -}}
{{- $secret := lookup "v1" "Secret" .Release.Namespace $secretName -}}
{{- if not $secret -}}
{{- /* If it does not exist, create it */ -}}
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  namespace: {{ .Release.Namespace }}
type: Opaque
data:
  {{ $secretKey }}: {{ randAlphaNum 32 | b64enc }}
{{- else -}}
{{- $apiKey := index $secret.data $secretKey | b64dec -}}
{{- $apiKey -}}
{{- end -}}
{{- end }}

{{ define "prowlarr.api_key" }}
{{ include "common.apiKey" (dict "secretName" .Values.services.prowlarr.secretName "secretKey" .Values.services.prowlarr.secretKey "Release" .Release) }}
{{ end }}

{{ define "sonarr.api_key" }}
{{ include "common.apiKey" (dict "secretName" .Values.services.sonarr.secretName "secretKey" .Values.services.sonarr.secretKey "Release" .Release) }}
{{ end }}

{{ define "radarr.api_key" }}
{{ include "common.apiKey" (dict "secretName" .Values.services.radarr.secretName "secretKey" .Values.services.radarr.secretKey "Release" .Release) }}
{{ end }}

