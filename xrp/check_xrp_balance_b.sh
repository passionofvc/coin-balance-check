#xrp
priv="$1"
account_id=$( node xrp_md5_2_address.js "${priv}" )
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
if [[ "${balance}" == "null" ]]; then
    echo "xrp: "${account_id} "           "${priv} "0"
else
    echo "xrp: "${account_id} "           "${priv} ${balance}
fi

