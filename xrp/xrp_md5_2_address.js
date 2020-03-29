const rippleKeyPairs = require('ripple-keypairs')
const elliptic = require('elliptic')
const secp256k1 = elliptic.ec('secp256k1')
const crypto = require('crypto')
const rs_api = require('ripple-secret-codec')


function sha512hex(str /*: string */) {
  const md5 = crypto.createHash('sha512')  //64bytes 128chars
  return md5.update(str, 'binary').digest('hex').toUpperCase()
}


function bytesToHex(a) {
  return a.map(function(byteValue) {
    const hex = byteValue.toString(16).toUpperCase()
    return hex.length > 1 ? hex : '0' + hex
  }).join('')
}

var sha512hash=sha512hex(process.argv[2])
var hexSeed = sha512hash.substring(0,32)
const seed_from_hex_secret = rs_api.encodeHex(hexSeed).secret_b58
//console.log('xrp', seed_from_hex_secret)
const keypair = rippleKeyPairs.deriveKeypair(seed_from_hex_secret)
const address = rippleKeyPairs.deriveAddress(keypair.publicKey)
console.log(address)
