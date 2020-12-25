#!/bin/bash

tag="benramsey/jupyter-php:latest"

docker build \
    --tag "$tag" \
    .
