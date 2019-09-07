priv="$@"
addr=$(node eth_priv_2_addr.js ${priv})
balance=$( curl -s "https://api.etherscan.io/api?module=account&action=balancemulti&address=${addr}&tag=latest&apikey=YourApiKeyToken" | jq -r .result[].balance )

echo "eth: "${addr} ${priv} ${balance}

