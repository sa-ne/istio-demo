Demo for the Red Hat Service Mesh bookinfo demo, taken from https://access.redhat.com/documentation/en-us/openshift_container_platform/4.4/html-single/service_mesh/index#ossm-bookinfo-tutorial

## To Install
1. Apply 1-5 in the [istio-install](istio-install) directory via `oc apply -f`
    - If running on RHPDS or in AWS, also run [6-deploy-smcp-aws.yaml](istio-install/6-deploy-smcp-aws.yaml)
1. Apply [7-deploy-servicemeshmemberroll.yaml](istio-install/7-deploy-servicemeshmemberroll.yaml) via `oc apply -f`
1. Switch to a "normal" user (i.e. user1 in an RHPDS environment)
1. Create the `bookinfo` project (`oc new-project bookinfo`)
1. Apply 0-3 in the [bookinfo](bookinfo) directory via `oc apply -f`
1. Now you should be able to run [generate-traffic.sh](bookinfo/generate-traffic.sh) to generate traffic
    - Kiali should be available at https://kiali-istio-system.apps.##CLUSTER_SUFFIX##
    - Jaeger should be available at https://jaeger-istio-system.apps.##CLUSTER_SUFFIX##