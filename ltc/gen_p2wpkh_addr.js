const bitcoin = require('bitcoinjs-lib')
const explorers = require('litecore-explorers')
let litecore = explorers.litecore
var wif = require('wif')

const testnet　=　{
　　messagePrefix:　'\x19Litecoin　Signed　Message:\n',
　　bip32:　{　//　tpub,　tprv
　　　　public:　0x043587cf,
　　　　private: 0x04358394
　　},
    bech32: 'tltc',
　　pubKeyHash:　0x6f,
　　scriptHash:　0xc4,　//2 start address
　　wif:　0xef
}

const mainnet= {
    messagePrefix: '\x19Litecoin Signed Message:\n',
    bip32: {
        public: 0x019da462,
        private: 0x019d9cfe
    },
    pubKeyHash: 0x30,
    //scriptHash: 0x32,
    scriptHash: 0x05,
    bech32: '1ltc',
    //wif: 0xb0
    wif: 0x80
}

const net=mainnet
//const net=testnet

const key_in=process.argv[2]
var privateKey = Buffer.from(key_in)
var key = wif.encode(128, privateKey, true)

let keyPair = bitcoin.ECPair.fromWIF(key, net)
let p2wpkh = bitcoin.payments.p2wpkh({ pubkey: keyPair.publicKey, network: net })
console.log(p2wpkh.address)

