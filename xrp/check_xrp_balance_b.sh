#xrp
pass="$1"
priv=$( node xrp_pass_2_priv.js "${pass}" )
bash check_xrp_balance.sh "${priv}"
