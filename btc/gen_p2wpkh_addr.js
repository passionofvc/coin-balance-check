const bitcoin = require('bitcoinjs-lib')
var wif = require('wif')

const btc_mainnet = {
  messagePrefix: '\x18Bitcoin Signed Message:\n',
  bech32: 'bc',
  bip32: {
    public: 0x0488b21e,
    private: 0x0488ade4,
  },
  pubKeyHash: 0x00,
  scriptHash: 0x05,
  wif: 0x80,
};

net=btc_mainnet
const key_in=process.argv[2]
var privateKey = Buffer.from(key_in)
var key = wif.encode(128, privateKey, true)

let keyPair = bitcoin.ECPair.fromWIF(key, net)
let p2wpkh = bitcoin.payments.p2wpkh({ pubkey: keyPair.publicKey, network: net})
//console.log(p2wpkh.address, p2wpkh.output.toString('hex'))
console.log(p2wpkh.address)


