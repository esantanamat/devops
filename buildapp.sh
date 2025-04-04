#!/bin/bash
echo "Enter your name"
read name
MY_ARG_VALUE=${name}
echo ${MY_ARG_VALUE}

docker build --build-arg MY_VARIABLE="$MY_ARG_VALUE" -t my-image .