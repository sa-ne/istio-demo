Demo for the Red Hat Service Mesh bookinfo demo, taken from https://access.redhat.com/documentation/en-us/openshift_container_platform/4.5/html-single/service_mesh/index#ossm-tutorial-bookinfo-overview_deploying-applications-ossm-v1x

## To Install
1. Log in as cluster admin
1. Apply 1-5 in the [istio-install](istio-install) directory via `oc apply -f`
    - If running on RHPDS or in AWS, also run [`6-deploy-smcp-aws.yaml`](istio-install/6-deploy-smcp-aws.yaml)
1. Give the "normal" user access to the `istio-system` project (i.e. `oc adm policy add-role-to-user view user1 -n istio-system`)
1. Switch to a "normal" user (i.e. user1 in an RHPDS environment)
1. Create the `bookinfo` project (`oc new-project bookinfo`)
1. Switch back to the cluster admin user
1. Apply [`7-deploy-servicemeshmemberroll.yaml`](istio-install/7-deploy-servicemeshmemberroll.yaml) via `oc apply -f`
1. Switch back to the "normal" user
1. Apply 0 & 1 in the [bookinfo](bookinfo) directory via `oc apply -f`
1. Run `export $(./2-gateway-url.sh)` in the [bookinfo](bookinfo) directory
1. Apply [`3-destination-rule-all-mtls.yaml`](bookinfo/3-destination-rule-all-mtls.yaml) via `oc apply -f`
1. Now you should be able to run [`generate-traffic.sh`](bookinfo/generate-traffic.sh) to generate traffic
    - Kiali should be available at https://kiali-istio-system.apps.##CLUSTER_SUFFIX##
    - Jaeger should be available at https://jaeger-istio-system.apps.##CLUSTER_SUFFIX##

## Running a demo
- The [`reset-virtualservices.sh`](bookinfo/reset-virtualservices.sh) script will reset all `VirtualService`s to the default state, so requests to the `reviews` service will flow to each version, as set up by the installation
    - Re-run this each time you make a change before making a new change to revert back to a clean state
- The [`reset-ratelimits.sh`](bookinfo/reset-ratelimits.sh) script will reset the rate limits applied by [`demo-6-mixer-rule-productpage-ratelimit.yaml`](bookinfo/demo-6-mixer-rule-productpage-ratelimit.yaml)
    - Re-run this whenever you apply [`demo-6-mixer-rule-productpage-ratelimit.yaml`](bookinfo/demo-6-mixer-rule-productpage-ratelimit.yaml) to reset back to a clean state
        - **NOTE:** This requires either being run as a cluster admin user, or by a user that has `edit` access to the `istio-system` project
- The [bookinfo](bookinfo) directory has a bunch of `demo-` scripts that you can run to set up different scenarios
    - [`demo-0-virtual-service-all-v1.yaml`](bookinfo/demo-0-virtual-service-all-v1.yaml) sets all requests to `reviews-v1`
    - [`demo-1-virtual-service-reviews-v2-partial.yaml`](bookinfo/demo-1-virtual-service-reviews-v2-partial.yaml) sets 90% of traffic to `reviews-v1` & 10% of traffic to `reviews-v2`
    - [`demo-2-virtual-service-reviews-v2-full.yaml`](bookinfo/demo-2-virtual-service-reviews-v2-full.yaml) sets all requests to `reviews-v2`
    - [`demo-3-virtual-service-reviews-jason-v2-v3.yaml`](bookinfo/demo-3-virtual-service-reviews-jason-v2-v3.yaml) sets users who log in as `jason` to `reviews-v3` and everyone else to `reviews-v2`
    - [`demo-4-virtual-service-reviews-jason-v2-v3-delay.yaml`](bookinfo/demo-4-virtual-service-reviews-jason-v2-v3-delay.yaml) sets users who log in as `jason` to `reviews-v3`, but with a 7 second delay. Everyone else goes to `reviews-v2` with no delay
    - [`demo-5-virtual-service-reviews-jason-v2-v3-error.yaml`](bookinfo/demo-5-virtual-service-reviews-jason-v2-v3-error.yaml) sets users who log in as `jason` to receive a `500` error. All other users are routed 50% to `reviews-v2` & 50% to `reviews-v3`
    - [`demo-6-mixer-rule-productpage-ratelimit.yaml`](bookinfo/demo-6-mixer-rule-productpage-ratelimit.yaml) imposes some rate limits on the `productpage`
    - [`demo-7-destination-rule-product-page-circuit-breaker.yaml`](bookinfo/demo-7-destination-rule-product-page-circuit-breaker.yaml) places some circuit breaker logic on `productpage`
