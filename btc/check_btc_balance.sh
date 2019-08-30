priv="$@"

#btc[p2pkh]-------------------------------------------------------
#compress
addr=$( bx ec-to-public "${priv}" | bx ec-to-address )
#balance=$( curl -s https://insight.bitpay.com/api/addrs/${addr}/utxo | jq -r ".[] | [.address,.txid,.vout,.      scriptPubKey,.amount] | @tsv" )
balance=$( curl -s https://insight.bitpay.com/api/addr/${addr}/balance )
echo "btc:" ${addr} ${priv} ${balance}

#uncompressed
addr=$( bx ec-to-public -u ${priv} | bx ec-to-address )
balance=$( curl -s https://insight.bitpay.com/api/addr/${addr}/balance )
echo "btc:" ${addr} ${priv} ${balance}


#btc[p2sh-p2wpkh]-------------------------------------------------------
addr=$( node gen_p2sh_p2wpkh_addr.js "${priv}")
balance=$( curl -s https://insight.bitpay.com/api/addr/${addr}/balance )
echo "btc:" ${addr} ${priv} ${balance}


#btc[p2wpkh]-------------------------------------------------------
addr=$( node gen_p2wpkh_addr.js "${priv}")
#addr=17iyRRXBHJKbv5DKPPkttWewm3CHdNPGQd
balance=$( curl -s https://blockstream.info/api/address/${addr} | jq .chain_stats )
fund=$(echo ${balance}  | jq .funded_txo_sum )
spent=$(echo ${balance} | jq .spent_txo_sum  )
echo "btc:" ${addr} ${priv} $(( $fund - $spent  ))

