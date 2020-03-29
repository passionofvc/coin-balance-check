pass="$@"
addr=$(node eth_pass_2_priv.js ${pass})

bash check_eth_balance.sh "$addr"
