#!/bin/bash
printf "%-14s %-10s %-10s %-6s %-6s\n" "IMAGE" "TAILLE" "CRITICAL" "HIGH" "TOTAL"
echo "----------------------------------------------------"

for tag in standard slim distroless; do
  size=$(docker images docker-sec-demo:$tag --format "{{.Size}}")
  json=$(trivy image --severity CRITICAL,HIGH --format json --quiet docker-sec-demo:$tag)
  critical=$(echo "$json" | jq '[.Results[]?.Vulnerabilities[]? | select(.Severity=="CRITICAL")] | length')
  high=$(echo "$json" | jq '[.Results[]?.Vulnerabilities[]? | select(.Severity=="HIGH")] | length')
  total=$((critical + high))
  printf "%-14s %-10s %-10s %-6s %-6s\n" "$tag" "$size" "$critical" "$high" "$total"
done
