#!/usr/bin/env bash

# Non-Git file for setting credentials.

export AWS_ACCESS_KEY_ID="anaccessid"
export AWS_SECRET_ACCESS_KEY="anaccesskey"
export AWS_DEFAULT_REGION="us-east-1"
export TF_VAR_database_password="adatabasepassword"
# Use http://checkip.amazonaws.com
export TF_VAR_operator_ip="12.34.56.78/32"