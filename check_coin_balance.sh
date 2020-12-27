priv=$( echo "$@" | sed 's/^0x//g' )
( cd btc && bash check_btc_balance.sh "$priv"  )
( cd eth && bash check_eth_balance.sh "$priv" )
( cd ltc && bash check_ltc_balance.sh "$priv" )
( cd xrp && bash check_xrp_balance.sh "$priv" )

