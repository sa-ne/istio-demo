#!/bin/bash

oc delete rule quota -n istio-system
oc delete quotaspecbinding request-count -n istio-system
oc delete quotaspec request-count -n istio-system
oc delete instance requestcountquota -n istio-system
oc delete handler quotahandler -n istio-system