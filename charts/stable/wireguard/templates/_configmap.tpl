{{/* Define the secrets */}}
{{- define "wg.env.configmap" -}}
enabled: true
data:
  SERVERURL: {{ .Values.wg.serverUrl | quote }}

  {{- if hasKey .Values.wg "serverPort" }}
  SERVERPORT: {{ .Values.wg.serverPort | quote }}
  {{- end }}

  {{- if hasKey .Values.wg "peers" }}
    {{- if kindIs "slice" .Values.wg.peers }}
  PEERS: {{ join "," .Values.wg.peers | quote }}
    {{ else }}
  PEERS: {{ .Values.wg.peers | quote }}
    {{- end }}
  {{- end }}

  {{- if hasKey .Values.wg "peerDns" }}
  PEERDNS: {{ .Values.wg.peerDns}}
  {{- end }}

  {{- if hasKey .Values.wg "internalSubnet" }}
  INTERNAL_SUBNET: {{ .Values.wg.internalSubnet }}
  {{- end }}

  {{- if hasKey .Values.wg "allowedIps" }}
    {{- if kindIs "slice" .Values.wg.allowedIps }}
  ALLOWEDIPS: {{ join "," .Values.wg.allowedIps | quote }}
    {{ else }}
  ALLOWEDIPS: {{ .Values.wg.allowedIps }}
    {{- end }}
  {{- end }}

  {{- if hasKey .Values.wg "persistentKeepAlivePeers" }}
    {{- if kindIs "slice" .Values.wg.persistentKeepAlivePeers }}
  PERSISTENTKEEPALIVE_PEERS: {{ join "," .Values.wg.persistentKeepAlivePeers | quote }}
    {{ else }}
  PERSISTENTKEEPALIVE_PEERS: {{ .Values.wg.persistentKeepAlivePeers | quote }}
    {{- end }}
  {{- end }}

  {{- if hasKey .Values.wg "logConfs" }}
  LOG_CONFS: {{ .Values.wg.logConfs | quote }}
  {{- end }}

  SEPARATOR: ";"
  IPTABLES_BACKEND: nft
  KILLSWITCH: {{ .Values.wg.killswitch | quote }}

  {{- if .Values.wg.killswitch }}
    {{- $excludedIP4Networks := prepend .Values.wg.excludedIP4networks .Values.chartContext.podCIDR }}
    {{- $excludedIP4net := (join ";" $excludedIP4Networks) }}
  KILLSWITCH_EXCLUDEDNETWORKS_IPV4: {{ $excludedIP4net | quote }}
    {{- $excludedIP6net := (join ";" .Values.wg.excludedIP6networks) }}
  KILLSWITCH_EXCLUDEDNETWORKS_IPV6: {{ $excludedIP6net | quote }}
  {{- end }}
{{- end -}}
