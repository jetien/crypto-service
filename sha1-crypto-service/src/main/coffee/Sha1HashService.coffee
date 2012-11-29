scope = if global? then global else this

scope.CryptoService = CryptoService ? {}
scope.CryptoService.SHA1HashService = scope.CryptoService.SHA1HashService ? {}


# TODO Would be nice to keep in cache the window location result and listen for events.

scope.CryptoService.SHA1HashService = class SHA1HashService

  _hub : null

  _logger : null

  configure: (hub, configuration) ->
    @_hub = hub
    @_logger = new Logger("Sha1 CryptoService")
    @_hub.provideService({
      component: @,
      contract: window.CryptoService.HashService,
      properties: {
        'hash.algorithm' : 'sha1'
      }
    })

  start : ->
    
  stop : ->
    
  getComponentName : -> return "SHA1HashService"  

  ###*
  Computes the SHA1 Hash ot the given message
  @return {String} the computed hash.
  @method
  @name #hash
  @memberOf CryptoService.HashService
  @param {String} the message to hash
  @param {Object} optional others parameters
  ###
  hash: (message) ->
    return CryptoJS.SHA1(message).toString();

