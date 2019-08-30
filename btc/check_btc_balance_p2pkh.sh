priv="$@"

#btc-------------------------------------------------------
#compress
addr=$( bx ec-to-public "${priv}" | bx ec-to-address )
#balance=$( curl -s https://insight.bitpay.com/api/addrs/${addr}/utxo | jq -r ".[] | [.address,.txid,.vout,.      scriptPubKey,.amount] | @tsv" )
balance=$( curl -s https://insight.bitpay.com/api/addr/${addr}/balance )
echo "btc:" ${addr} ${priv} ${balance}

#uncompressed
addr=$( bx ec-to-public -u ${priv} | bx ec-to-address )
balance=$( curl -s https://insight.bitpay.com/api/addr/${addr}/balance )
echo "btc:" ${addr} ${priv} ${balance}

