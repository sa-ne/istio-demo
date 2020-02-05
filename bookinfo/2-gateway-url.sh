#!/bin/bash
export GATEWAY_URL=$(oc -n istio-system get route istio-ingressgateway -o jsonpath='{.spec.host}')
echo "GATEWAY_URL=$GATEWAY_URL"
