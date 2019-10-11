priv="$@"

#btc[p2pkh]-------------------------------------------------------
#compress
addr=$( bx ec-to-public "${priv}" | bx ec-to-address -v 48 )
balance=$( curl -s https://insight.litecore.io/api/addr/${addr}/balance )
echo "ltc:" ${addr} "           "${priv} ${balance}

#uncompressed
addr=$( bx ec-to-public -u ${priv} | bx ec-to-address -v 48)
balance=$( curl -s https://insight.litecore.io/api/addr/${addr}/balance )
echo "ltc:" ${addr} "           "${priv} ${balance}


#btc[p2sh-p2wpkh]-------------------------------------------------------
addr=$( node gen_p2sh_p2wpkh_addr.js "${priv}")
balance=$( curl -s https://insight.litecore.io/api/addr/${addr}/balance )
echo "ltc:" ${addr} "           "${priv} ${balance}


#btc[p2wpkh]-------------------------------------------------------
addr=$( node gen_p2wpkh_addr.js "${priv}")
#balance=$( curl -s https://insight.litecore.io/api/addr/${addr}/balance )
balance=$( curl -s https://api.blockchair.com/litecoin/dashboards/address/${addr}| sed -e "s/$addr/addr/g" |  jq .data.addr.address.balance)
echo "ltc:" ${addr} " "${priv} ${balance}
