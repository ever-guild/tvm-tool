#!/usr/bin/env bash

address="${1}"
network="${2:-se}"

usage() {
  echo "Usage: $(basename "${0}") <address> [network]"
}

if [ -z "${address}" ]; then
    usage
    exit 1
fi

# shellcheck disable=SC2016
query='query balance($address: String!){blockchain{account(address:$address){info{balance(format:DEC)}}}}'
param=$(printf '{"address": "%s"}' "${address}")
balance=$(tvm-query "${query}" "${param}" "${network}" | jq -r .data.blockchain.account.info.balance || echo 0)
echo "$(echo "${balance}/10^9" | bc).$(echo "${balance}%10^9" | bc)"
