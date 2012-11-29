scope = if global? then global else this

scope.CryptoService = CryptoService ? {}
scope.CryptoService.MD5HashService = scope.CryptoService.MD5HashService ? {}


# TODO Would be nice to keep in cache the window location result and listen for events.

scope.CryptoService.MD5HashService = class MD5HashService

  _hub : null

  _logger : null

  configure: (hub, configuration) ->
    @_hub = hub
    @_logger = new Logger("MD5 CryptoService")
    @_hub.provideService({
      component: @,
      contract: window.CryptoService.HashService,
      properties: {
        'hash.algorithm' : 'md5'
      }
    })

  start : ->
    
  stop : ->
    
  getComponentName : -> return "MD5HashService"  

  ###*
  Computes the MD5 Hash ot the given message
  @return {String} the computed hash.
  @method
  @name #hash
  @memberOf CryptoService.HashService
  @param {String} the message to hash
  @param {Object} optional others parameters
  ###
  hash: (message) ->
    return CryptoJS.MD5(message).toString();

