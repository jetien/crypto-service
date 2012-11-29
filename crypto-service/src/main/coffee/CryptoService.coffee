###*
The Crypto Service Namespace
@namespace CryptoService
@global
###
window.CryptoService = CryptoService ? {}

window.CryptoService.cipher_algorithm_key = "cipher.algorithm"

###*
@class CryptoService.CipherService
@classDesc The Crypto Cipher contract.

This service allows endoding and decoding messages using the implementation algorithm. The service contains two methods:

* `encode(message, key)`: to encode a message
* `decode(encoded, key)` : to decode the message

Algorithms may require other parameters, they are given as an object as third arguments. This parameter is optional.

Providers must published the algorithm they are using as service properties using the `cipher.algorithm` property.

Be aware that this class cannot be instantiated directly. It must be implementated by a component and consumed as a service.

###
window.CryptoService.CipherService = {

    ###*
    @return {String} the encoded message.
    @method
    @name #encode
    @memberOf CryptoService.CipherService
    @param {String} the message to encrypt
    @param {String} the encoding key
    @param {Object} optional others parameters
    ###
    encode: ->

    ###*
    @return {String} the decoded message.
    @method
    @name #decode
    @memberOf CryptoService.CipherService
    @param {String} the message to decrypt
    @param {String} the encoding key
    @param {Object} optional others parameters
    ###
    decode: ->	

}

###*
@class CryptoService.HashService
@classDesc The Crypto Hash contract.

This service computes hash of messages using the implementation algorithm. The service contains one method:

* `hash(message)`: to computes the hash

Algorithms may require other parameters, they are given as an object as second arguments. This parameter is optional.

Providers must published the algorithm they are using as service properties using the `hash.algorithm` property.

Be aware that this class cannot be instantiated directly. It must be implementated by a component and consumed as a service.

###
window.CryptoService.HashService = {

    ###*
    @return {String} the computed hash.
    @method
    @name #hash
    @memberOf CryptoService.HashService
    @param {String} the message to hash
    @param {Object} optional others parameters
    ###
    hash: ->

}