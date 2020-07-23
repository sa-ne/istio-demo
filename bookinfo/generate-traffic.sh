#!/bin/bash

export $(./2-gateway-url.sh)

while [ true ]
do
    response=$(curl -o /dev/null -s -w "%{http_code}\n" http://$GATEWAY_URL/productpage)
    echo "[$(date +'%m/%d/%Y %H:%M:%S')] - $response"
    sleep .1
done
