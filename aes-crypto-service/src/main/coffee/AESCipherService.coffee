scope = if global? then global else this

scope.CryptoService = CryptoService ? {}
scope.CryptoService.AESCipherService = scope.CryptoService.AESCipherService ? {}

scope.CryptoService.AESCipherService = class AESCipherService

  _hub : null

  _logger : null

  configure: (hub, configuration) ->
    @_hub = hub
    @_logger = new Logger("AES Cipher Service")
    @_hub.provideService({
      component: @,
      contract: window.CryptoService.CipherService,
      properties: {
        'cipher.algorithm' : 'aes'
      }
    })

  start : ->
    
  stop : ->
    
  getComponentName : -> return "AESCipherService"  

  ###*
  Encodes the given message using the AES Cipher algorithm.
  @return {String} the encoded message.
  @method
  @name #encode
  @memberOf CryptoService.CipherService
  @param {String} the message to encrypt
  @param {String} the encoding key
  @param {Object} optional others parameters
  ###
  encode: (message, key) ->
    return CryptoJS.AES.encrypt(message, key).toString()

  ###*
  Decodes the given encoded message using the AES Cipher algorithm
  @return {String} the decoded message.
  @method
  @name #decode
  @memberOf CryptoService.CipherService
  @param {String} the message to decrypt
  @param {String} the encoding key
  @param {Object} optional others parameters
  ###
  decode: (message, key) ->
    return CryptoJS.AES.decrypt(message, key).toString(CryptoJS.enc.Utf8)
