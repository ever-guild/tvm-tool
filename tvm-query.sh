#!/usr/bin/env bash

query="${1}"
param="${2}"
network="${3:-se}"

usage() {
  echo "Usage: $(basename "${0}") <query> <param> [network]"
}

if [ -z "${query}" ]; then
    usage
    exit 1
fi

endpoint="http://localhost/graphql"
case "${network}" in
  se)
    endpoint="http://localhost/graphql"
    ;;
  em)
    endpoint="https://mainnet.evercloud.dev/${EVERCLOUD_ID}/graphql"
    ;;
  et)
    endpoint="https://devnet.evercloud.dev/${EVERCLOUD_ID}/graphql"
    ;;
  ef)
    endpoint="https://n01.fld.dapp.tonlabs.io/${EVERCLOUD_ID}/graphql"
    ;;
  tm)
    endpoint="https://ton-mainnet.evercloud.dev/${EVERCLOUD_ID}/graphql"
    ;;
  vm)
    endpoint="http://gql.venom.foundation/graphql"
    ;;
  vt)
    endpoint="https://venom-testnet.evercloud.dev/${EVERCLOUD_ID}/graphql"
    ;;
  gm)
    endpoint="https://gra01.network.gosh.sh/graphql"
    ;;
  *)
    echo "Unknown network: ${network}"
    exit 1
    ;;
esac

args=()
args+=("--silent")
args+=("--location")
args+=("--request")
args+=("POST")
args+=("${endpoint}")
if [[ "$endpoint" == *"evercloud.dev"* ]]; then
  args+=("--header")
  args+=("Authorization: Basic ${EVERCLOUD_KEY}")
fi
args+=("--header")
args+=("Content-Type: application/json")
args+=("--data-raw")
args+=("$(printf '{"query":"%s","variables":%s}' "${query}" "${param}")")

curl "${args[@]}"
