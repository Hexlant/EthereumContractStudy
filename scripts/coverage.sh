#!/usr/bin/env bash

# Exit script as soon as a command fails.
set -o errexit

# Executes cleanup function at script exit.
trap cleanup EXIT

cleanup() {
  # Kill the ganache instance that we started (if we started one and if it's still running).
  if [ -n "$ganache_pid" ] && ps -p $ganache_pid > /dev/null; then
    kill -9 $ganache_pid
  fi
}

ganache_port=8555

ganache_running() {
  nc -z localhost "$ganache_port"
}

start_ganache() {
  # We define 10 accounts with balance 1M ether, needed for high-value tests.
  local accounts=(
    --account="0xb178cf12d4126ea1db48ca32e3ce6743580ca6646391996032fc76652d699972,1000000000000000000000000"
    --account="0xb178cf12d4126ea1db48ca32e3ce6743580ca6646391996032fc76652d699973,1000000000000000000000000"
    --account="0xb178cf12d4126ea1db48ca32e3ce6743580ca6646391996032fc76652d699974,1000000000000000000000000"
    --account="0xb178cf12d4126ea1db48ca32e3ce6743580ca6646391996032fc76652d699975,1000000000000000000000000"
    --account="0xb178cf12d4126ea1db48ca32e3ce6743580ca6646391996032fc76652d699976,1000000000000000000000000"
    --account="0xb178cf12d4126ea1db48ca32e3ce6743580ca6646391996032fc76652d699977,1000000000000000000000000"
    --account="0xb178cf12d4126ea1db48ca32e3ce6743580ca6646391996032fc76652d699978,1000000000000000000000000"
    --account="0xb178cf12d4126ea1db48ca32e3ce6743580ca6646391996032fc76652d699979,1000000000000000000000000"
    --account="0xb178cf12d4126ea1db48ca32e3ce6743580ca6646391996032fc76652d69997a,1000000000000000000000000"
    --account="0xb178cf12d4126ea1db48ca32e3ce6743580ca6646391996032fc76652d69997b,1000000000000000000000000"
    --account="0xb178cf12d4126ea1db48ca32e3ce6743580ca6646391996032fc76652d69997c,1000000000000000000000000"
  )

  node_modules/.bin/testrpc-sc --gasLimit 0xfffffffffff --port "$ganache_port" "${accounts[@]}" > /dev/null &
  ganache_pid=$!
}

if ganache_running; then
  echo "Using existing ganache instance"
else
  echo "Starting our own ganache instance"
  start_ganache
fi

node_modules/.bin/solidity-coverage
cat coverage/lcov.info | node_modules/.bin/coveralls