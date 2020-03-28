priv=$( echo -n "$@" | shasum -a 256 | awk '{print $1}' )

#btc
addr=$( bx ec-to-public ${priv} | bx ec-to-address )
#balance=$( curl -s https://insight.bitpay.com/api/addrs/${addr}/utxo | jq -r ".[] | [.address,.txid,.vout,.scriptPubKey,.amount] | @tsv" )
balance=$( curl -s https://insight.bitpay.com/api/addr/${addr}/balance )
echo ${addr} ${priv} ${balance}
if [[ "${balance}" != "0" ]]; then
    echo ${addr} ${priv} ${balance}
fi

addr=$( bx ec-to-public -u ${priv} | bx ec-to-address )
balance=$( curl -s https://insight.bitpay.com/api/addr/${addr}/balance )
echo ${addr} ${priv} ${balance}
if [[ "${balance}" != "0" ]]; then
    echo ${addr} ${priv} ${balance}
fi

#bcc
addr=$( bx ec-to-public ${priv} | bx ec-to-address )
#balance=$( curl -s https://insight.bitpay.com/api/addrs/${addr}/utxo | jq -r ".[] | [.address,.txid,.vout,.scriptPubKey,.amount] | @tsv" )
#balance=$( curl -s https://blockdozer.com/api/addr/${addr}/balance )
#balance=$( curl -s https://bch.coin.space/api/addr/${addr}/balance )
balance=$( curl -s https://api.bitcore.io/api/BCH/mainnet/address/${addr}/balance | jq .balance )
echo ${addr} ${priv} ${balance}
if [[ "${balance}" != "0" ]]; then
    echo ${addr} ${priv} ${balance}
fi

addr=$( bx ec-to-public -u ${priv} | bx ec-to-address )
#balance=$( curl -s https://blockdozer.com/api/addr/${addr}/balance )
#balance=$( curl -s https://bch.coin.space/api/addr/${addr}/balance )
balance=$( curl -s https://api.bitcore.io/api/BCH/mainnet/address/${addr}/balance | jq .balance )
echo ${addr} ${priv} ${balance}
if [[ "${balance}" != "0" ]]; then
    echo ${addr} ${priv} ${balance}
fi

#bsv
addr=$( bx ec-to-public ${priv} | bx ec-to-address )
#balance=$( curl -s https://insight.bitpay.com/api/addrs/${addr}/utxo | jq -r ".[] | [.address,.txid,.vout,.scriptPubKey,.amount] | @tsv" )
balance=$( curl -s https://bchsvexplorer.com/api/addr/${addr}/balance )
echo ${addr} ${priv} ${balance}
if [[ "${balance}" != "0" ]]; then
    echo ${addr} ${priv} ${balance}
fi

addr=$( bx ec-to-public -u ${priv} | bx ec-to-address )
balance=$( curl -s https://bchsvexplorer.com/api/addr/${addr}/balance )
echo ${addr} ${priv} ${balance}
if [[ "${balance}" != "0" ]]; then
    echo ${addr} ${priv} ${balance}
fi
#eth
priv=$( echo -n "$@" | keccak-256sum | awk '{print $1}' )
#pubkey=$( echo -n ${priv} | bx ec-to-public)
pubkey=$( echo -n ${priv} | bx ec-to-public -u  | sed -e 's/^04//g')
addr=$(echo -n ${pubkey} |  keccak-256sum -x -l | tr -d ' -' | tail -c 41)
addr='0x'"${addr}"
#echo '0x'${addr} ${privkey}
balance=$( curl -s "https://api.etherscan.io/api?module=account&action=balancemulti&address=${addr}&tag=latest&apikey=YourApiKeyToken" | jq -r .result[].balance )
echo ${addr} ${priv} ${balance}
if [[ "${balance}" != "0" ]]; then
    echo ${addr} ${priv} ${balance}
fi

#xrp
account_id=$( node xrp_md5_2_address.js "$@" )
host_url=https://s1.ripple.com:51234
balance=$(curl -s -X POST "$host_url" -d @- <<-END
{
     "method" : "account_info",
     "params": [
      {
        "account": "${account_id}",
        "strict" : true,
        "ledger_index": "validated"
      }
     ]
}
END
)

balance=$(echo $balance | jq -r '.result.account_data.Balance')
#echo ${account_id} ${master_seed} ${balance}
if [[ "${balance}" = "null" ]]; then
    echo ${account_id} ${master_seed} "0"
else
    echo ${account_id} ${master_seed} ${balance}
fi

