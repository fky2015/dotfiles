{{- /* chezmoi:modify-template */ -}}
{{- if not (regexMatch `(?m)^[ \t]*(require\("plugins\.rex-navigation"\)[ \t]*\r?$|name[ \t]*=[ \t]*["']navigate_window["'])` .chezmoi.stdin) -}}
{{ printf "%s\n" `require("plugins.rex-navigation")` }}
{{- end -}}
{{- /* The Mac handles Cmd+J even in remote panes. */ -}}
{{- if and (eq .chezmoi.os "darwin") (not (regexMatch `(?m)^[ \t]*require\("plugins\.rex-next-attention"\)\.setup\(\)[ \t]*\r?$` .chezmoi.stdin)) -}}
{{ printf "%s\n" `require("plugins.rex-next-attention").setup()` }}
{{- end -}}
{{- .chezmoi.stdin -}}
