scope = if global? then global else this

scope.URLService = URLService ? {}
scope.URLService.DefaultURLParser = URLService.DefaultURLParser ? {}


# TODO Would be nice to keep in cache the window location result and listen for events.

scope.URLService.DefaultURLParser.DefaultURLParserImpl = class DefaultURLParserImpl

  _hub : null

  _logger : null

  configure: (hub, configuration) ->
    @_hub = hub
    @_logger = new Logger("URL Default Parser")
    @_hub.provideService({
      component: @,
      contract: window.URLService.URLParser,
      properties: {
        schemes : ["file", "http", "https"]
      }
    })

  start : ->
    
  stop : ->
    
  getComponentName : -> return "DefaultURLParser"  

  ###*
  @return {String} the URL's scheme.
  @method
  @name #getScheme
  @memberOf URLService.DefaultURLParser.DefaultURLParserImpl
  @param {String} url the url to parse, if not set use `window.location`
  ###
  getScheme: (url) ->
    if not url? and window?.location?.protocol? then return window.location.protocol
    result = if url? then @._parse(url) else @._parse(window.location)
    return result.scheme

  ###*
  @return {String} the URL's host.
  @method
  @name #getHost
  @memberOf URLService.DefaultURLParser.DefaultURLParserImpl
  @param {String} url the url to parse, if not set use `window.location`
  ###
  getHost: (url) ->
    if not url? and window?.location?.hostname? then return window.location.hostname
    result = if url? then @._parse(url) else @._parse(window.location)
    return result.host

  ###*
  @return {String} the URL's port.
  @method
  @name #getPort
  @memberOf URLService.DefaultURLParser.DefaultURLParserImpl
  @param {String} url the url to parse, if not set use `window.location`
  ###
  getPort: (url) ->
    if not url? and window?.location?.port? then return parseInt(window.location.port)
    result = if url? then @._parse(url) else @._parse(window.location)
    return result.port

  ###*
  @return {String} the URL's path.
  @method
  @name #getPath
  @memberOf URLService.DefaultURLParser.DefaultURLParserImpl
  @param {String} url the url to parse, if not set use `window.location`
  ###
  getPath: (url) ->
    if not url? and window?.location?.pathname? then return window.location.pathname
    result = if url? then @._parse(url) else @._parse(window.location)
    return result.path

  ###*
  @return {String} the URL's query segment.
  @method
  @name #getQuery
  @memberOf URLService.DefaultURLParser.DefaultURLParserImpl
  @param {String} url the url to parse, if not set use `window.location`
  ###
  getQuery: (url) ->
    # Do the parsing ourself without relying on the window.location.search
    result = if url? then @._parse(url) else @._parse(window.location)
    return result.query

  ###*
  @return {String} the URL's hash if any, an empty string if no hash
  @method
  @name #getHash
  @memberOf URLService.DefaultURLParser.DefaultURLParserImpl
  @param {String} url the url to parse, if not set use `window.location`
  ###
  getHash: (url) ->
    if not url? and window?.location?.hash? then return window.location.hash
    result = if url? then @._parse(url) else @._parse(window.location)
    return result.hash

  ###*
  @return {String} the URL's parameters.
  @method
  @name #getParameters
  @memberOf URLService.DefaultURLParser.DefaultURLParserImpl
  @param {String} url the url to parse, if not set use `window.location`
  ###
  getParameters: (url) ->
    result = if url? then @._parse(url) else @._parse(window.location)
    return result.parameters

  ###*
  @return {String} the query's parameter value. `null` if the parameter is not specified in the query. If the parameter has several values, returns the first value
  @method
  @name #getParameterValue
  @memberOf URLService.DefaultURLParser.DefaultURLParserImpl
  @param {String} parameter the parameter name
  @param {String} url the url to parse, if not set use `window.location`
  ###
  getParameterValue: (parameter, url) ->
    result = if url? then @._parse(url) else @._parse(window.location)
    return result.parameters[parameter][0] if result.parameters[parameter]?
    return null

  ###*
  @return {String} the query's parameter values. `null` if the parameter is not specified in the query. If the parameter has only one value, returns an array of one element
  @method
  @name #getParameterValues
  @memberOf URLService.DefaultURLParser.DefaultURLParserImpl
  @param {String} parameter the parameter name
  @param {String} url the url to parse, if not set use `window.location`
  ###
  getParameterValues: (parameter, url) ->
    result = if url? then @._parse(url) else @._parse(window.location)
    return result.parameters[parameter] if result.parameters[parameter]?
    return null

  _parse : (url) ->      
    result = {}

    # Extract base + path:
    fullpath = url.replace(/^(.*?)[?](.+?)(?:#.+)?$/, "$1");
    if fullpath.length is url.length then fullpath = null;
    # Extract hash:
    hash = url.replace(/^.*?[#](.+?)(?:\?.+)?$/, "$1");
    if hash.length is url.length then hash = "";
    # Extract query
    query = url.replace(/^.*?[?](.+?)(?:#.+)?$/, "$1");
    if query.length is url.length then query = null else query = decodeURI(query)

    # Extract scheme, host, and path
    scheme = url.split("://")[0]
    if scheme.length is url.length then scheme = null
    
    host = ""
    port = 0
    path = ""
    if (scheme isnt null)
      tmp = url.substring(scheme.length + 3) # ://
      if (scheme is "file")
        host = "localhost" #TODO Remote file url ?
        path = tmp
      else if tmp.indexOf('/') isnt -1
        host = tmp.substring(0, tmp.indexOf('/'))
        path = tmp.substring(tmp.indexOf('/'))
      else
        host = tmp
        path = ""  
      
      # Cut before the first # or ? 
      if (path isnt "")
        path = path.substring(0, path.indexOf("#")) if path.indexOf("#") > -1
        path = path.substring(0, path.indexOf("?")) if path.indexOf("?") > -1
      else
        host = host.substring(0, host.indexOf("#")) if host.indexOf("#") > -1
        host = host.substring(0, host.indexOf("?")) if host.indexOf("?") > -1

      if host.split(":").length is 2 then port = parseInt(host.split(":")[1]); host = host.split(":")[0] 


    port = 80 if port is 0 and scheme is "http" or scheme is "https"

    parameters = {}
    if query?
      q = query
      q = q.replace(/^[?#]/,''); # remove any leading ? || #
      q = q.replace(/[;&]$/,''); # remove any trailing & || ;
      q = q.replace(/[+]/g,' '); # replace +'s with spaces

      for param in q.split(/[&;]/)
        idx = param.indexOf('=')
        key = param
        val = null
        if idx > -1 then key = param.substring(0, idx); val = param.substring(idx+1)

        val = true if key? and not val? # Flag mode.
        key = key.replace(/\[\]$/,''); # remove any trailing []

        if val?
          if /^[+-]?[0-9]+\.[0-9]*$/.test(val) # simple float regex
              val = parseFloat(val);
          else if /^[+-]?[0-9]+$/.test(val) # simple int regex
              val = parseInt(val, 10);
          else if val is 'true' then val = true              
          else if val is 'false' then val = false
        
        if parameters[key]? then parameters[key].push(val) else parameters[key] = [val]

    result.url = url
    result.scheme = scheme
    result.host = host
    result.port = port
    result.path = path
    result.query= query
    result.hash = hash
    result.parameters = parameters

    return result

