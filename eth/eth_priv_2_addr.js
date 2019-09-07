const ethjsUtil = require('ethereumjs-util')

const priv_key=process.argv[2]
const address = ethjsUtil.privateToAddress(Buffer.from(priv_key,'hex'))
console.log(ethjsUtil.toChecksumAddress( address.toString('hex') ) )



