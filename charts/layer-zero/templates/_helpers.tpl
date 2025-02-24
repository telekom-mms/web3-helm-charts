{{- define "layer-zero.metricsPortName" -}}
metrics
{{- end }}

{{- define "layer-zero.serverPortName" -}}
server
{{- end }}

{{- define "layer-zero.secretVolumeName" -}}
wallet-mnemonic
{{- end -}}

{{- define "layer-zero.configVolumeName" -}}
config
{{- end -}}

{{- define "layer-zero.dataVolumePath" -}}
/data
{{- end -}}

{{- define "layer-zero.secretVolumePath" -}}
{{ include "layer-zero.dataVolumePath" . }}/secret
{{- end -}}

{{- define "layer-zero.configVolumePath" -}}
{{ include "layer-zero.dataVolumePath" . }}/configs
{{- end -}}

{{- define "layer-zero.walletsVolumePath" -}}
{{ include "layer-zero.dataVolumePath" . }}/wallets
{{- end -}}

{{/*
Convert memory values (Gi, Mi, Ki) to MB for MAX_OLD_SPACE_SIZE
Usage: {{ include "layer-zero.convertMemoryToMB" .Values.resources.requests.memory }}
*/}}
{{- define "layer-zero.convertMemoryToMB" -}}
  {{- if hasSuffix "Gi" . }}
    {{ . | trimSuffix "Gi" | int | mul 1024 }}
  {{- else if hasSuffix "Mi" . }}
    {{ . | trimSuffix "Mi" | int }}
  {{- else if hasSuffix "Ki" . }}
    {{ . | trimSuffix "Ki" | int | div 1024 }}
  {{- else }}
    {{ . }}
  {{- end }}
{{- end }}
