#!/bin/bash

for vs in productpage reviews ratings details ;
  do
    oc delete virtualservice $vs
  done