priv=$( echo -n "$@" | shasum -a 256 | awk '{print $1}' )

#btc
addr=$( bx ec-to-public ${priv} | bx ec-to-address )
#balance=$( curl -s https://insight.bitpay.com/api/addrs/${addr}/utxo | jq -r ".[] | [.address,.txid,.vout,.scriptPubKey,.amount] | @tsv" )
balance=$( curl -s https://insight.bitpay.com/api/addr/${addr}/balance )
echo "btc:" ${addr} "           "${priv} ${balance}
if [[ "${balance}" != "0" ]]; then
    echo ${addr} ${priv} ${balance}
fi

addr=$( bx ec-to-public -u ${priv} | bx ec-to-address )
balance=$( curl -s https://insight.bitpay.com/api/addr/${addr}/balance )
echo "btc:" ${addr} "           "${priv} ${balance}
if [[ "${balance}" != "0" ]]; then
    echo ${addr} ${priv} ${balance}
fi

#bcc
addr=$( bx ec-to-public ${priv} | bx ec-to-address )
#balance=$( curl -s https://insight.bitpay.com/api/addrs/${addr}/utxo | jq -r ".[] | [.address,.txid,.vout,.scriptPubKey,.amount] | @tsv" )
#balance=$( curl -s https://blockdozer.com/api/addr/${addr}/balance )
#balance=$( curl -s https://bch.coin.space/api/addr/${addr}/balance )
balance=$( curl -s https://api.bitcore.io/api/BCH/mainnet/address/${addr}/balance | jq .balance )
echo "bcc:" ${addr} "           "${priv} ${balance}
if [[ "${balance}" != "0" ]]; then
    echo ${addr} ${priv} ${balance}
fi

addr=$( bx ec-to-public -u ${priv} | bx ec-to-address )
#balance=$( curl -s https://blockdozer.com/api/addr/${addr}/balance )
#balance=$( curl -s https://bch.coin.space/api/addr/${addr}/balance )
balance=$( curl -s https://api.bitcore.io/api/BCH/mainnet/address/${addr}/balance | jq .balance )
echo "bcc:" ${addr} "           "${priv} ${balance}
if [[ "${balance}" != "0" ]]; then
    echo ${addr} ${priv} ${balance}
fi

#bsv
addr=$( bx ec-to-public ${priv} | bx ec-to-address )
#balance=$( curl -s https://insight.bitpay.com/api/addrs/${addr}/utxo | jq -r ".[] | [.address,.txid,.vout,.scriptPubKey,.amount] | @tsv" )
balance=$( curl -s https://bchsvexplorer.com/api/addr/${addr}/balance )
echo "bsv:" ${addr} "           "${priv} ${balance}
if [[ "${balance}" != "0" ]]; then
    echo ${addr} ${priv} ${balance}
fi

addr=$( bx ec-to-public -u ${priv} | bx ec-to-address )
balance=$( curl -s https://bchsvexplorer.com/api/addr/${addr}/balance )
echo "bsv:" ${addr} "           "${priv} ${balance}
if [[ "${balance}" != "0" ]]; then
    echo ${addr} ${priv} ${balance}
fi

#eth
( cd eth && bash check_eth_balance_b.sh "$@" )

#xrp
( cd xrp && bash check_xrp_balance_b.sh "$@" )
