const createKeccakHash = require('keccak')
const ethjsUtil = require('ethereumjs-util')

const pass=process.argv[2]
const priv_key = createKeccakHash('keccak256').update(pass).digest().toString('hex')
//const address = ethjsUtil.privateToAddress(Buffer.from(priv_key,'hex'))
console.log(priv_key)
//console.log(ethjsUtil.toChecksumAddress( address.toString('hex') ) )


