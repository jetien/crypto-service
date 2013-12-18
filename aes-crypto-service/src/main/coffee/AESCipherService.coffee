scope = if global? then global else this

scope.CryptoService = CryptoService ? {}
scope.CryptoService.AESCipherService = scope.CryptoService.AESCipherService ? {}

scope.CryptoService.AESCipherService = class AESCipherService

  _hub : null

  _logger : null

  configure: (hub, configuration) ->
    @_hub = hub
    @_logger = new Logger("AES Cipher Service")
    # AES encrypt key size (Default:128)
    @keySize = if configuration?.keySize then (configuration.keySize / 32) else (128 / 32)
    # AES salt iteration (Default:20)
    @iterationCount = if configuration?.iterationCount then configuration.iterationCount else 20
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
  Generate key with the PBKDF2 algorithm for the salting process
  @return {String} then generated key
  @method
  @name #generateKey
  @memborOf CryptoService.CipherService
  @param {String} the salt hex key
  @param {String} the passPhrase key
  ###
  generateKey: (salt, passPhrase) ->
    genKey = CryptoJS.PBKDF2(
      passPhrase,
      CryptoJS.enc.Hex.parse(salt),
      { keySize: @keySize, iterations: @iterationCount })
    return genKey


  ###*
  Encodes the given message using the AES Cipher algorithm.
  @return {String} the encoded message.
  @method
  @name #encode
  @memberOf CryptoService.CipherService
  @param {String} the message to encrypt
  @param {String} the encoding key
  @param {String} the hexadecimal iv key (initialization vector)
  ###
  encode: (message, key, iv) ->
    encrypted = CryptoJS.AES.encrypt(
      message,
      key,
      { iv: CryptoJS.enc.Hex.parse(iv) });
    return encrypted.ciphertext.toString(CryptoJS.enc.Base64);


  ###*
  Encodes the given message using the AES Cipher algorithm and Salt function
  @return {String} the encoded message.
  @method
  @name #encodeWithSalt
  @memberOf CryptoService.CipherService
  @param {String} the message to encrypt
  @param {String} the encoding key
  @param {String} the hexadecimal iv key (initialization vector)
  @param {String} the hexadecimal salt key
  ###
  encodeWithSalt: (message, key, iv, salt) ->
    genKey = this.generateKey(salt, key)
    return encode(message, genKey, iv)


  ###*
  Decodes the given encoded message using the AES Cipher algorithm
  @return {String} the decoded message.
  @method
  @name #decode
  @memberOf CryptoService.CipherService
  @param {String} the message to decrypt
  @param {String} the encoding key
  @param {String} the hexadecimal iv key (initialization vector)
  ###
  decode: (message, key, iv) ->
    cipherParams = CryptoJS.lib.CipherParams.create({
      ciphertext: CryptoJS.enc.Base64.parse(message)
    })
    decrypted = CryptoJS.AES.decrypt(
      cipherParams,
      key,
      { iv: CryptoJS.enc.Hex.parse(iv) }
    )
    return decrypted.toString(CryptoJS.enc.Utf8);


  ###*
  Decodes the given encoded message using the AES Cipher algorithm and Salt function
  @return {String} the decoded message.
  @method
  @name #decode
  @memberOf CryptoService.CipherService
  @param {String} the message to decrypt
  @param {String} the encoding key
  @param {String} the hexadecimal iv key (initialization vector)
  @param {String} the hexadecimal salt key
  ###
  decodeWithSalt: (message, key, iv, salt) ->
    genKey = this.generateKey(salt, key)
    return decode(message, genKey, iv)