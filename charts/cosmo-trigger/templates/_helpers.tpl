{{- define "cosmo-trigger.secretEnvTriggerTokenName" -}}
{{ include "common.names.fullname" . }}-cicd-trigger-token
{{- end -}}

{{- define "cosmo-trigger.secretEnvPersonalAccessTokenName" -}}
{{ include "common.names.fullname" . }}-cicd-personal-access-token
{{- end -}}
