const keypairs = require('ripple-keypairs')
const elliptic = require('elliptic')
const secp256k1 = elliptic.ec('secp256k1')

function bytesToHex(a) {
  return a.map(function(byteValue) {
    const hex = byteValue.toString(16).toUpperCase()
    return hex.length > 1 ? hex : '0' + hex
  }).join('')
}

var privateKey = '00' +  process.argv[2]

const publicKey = bytesToHex(secp256k1.keyFromPrivate(privateKey.slice(2)).getPublic().encodeCompressed())

const address = keypairs.deriveAddress(publicKey)
console.log(address)

