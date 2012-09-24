###*
@class URLService.URLParser
@classDesc The URL Parser contract.
Service defining methods to parser urls. It allows extracting the
 parameters, path, query, base, anchor and so one. By default methods are applied on the `window.location`, however the url can be specified
 as parameter. The service providers must publish the supported _schemes_ using the `schemes` service property.
 
Be aware that this class cannot be instantiated directly. It must be implementated by a component and consumed as a service.

###
window.URLService.URLParser = {

    ###*
    @return {String} the URL's scheme.
    @method
    @name #getScheme
    @memberOf URLService.URLParser
    @param {String} url the url to parse, if not set use `window.location`
    ###
    getScheme: ->

    ###*
    @return {String} the URL's host.
    @method
    @name #getHost
    @memberOf URLService.URLParser
    @param {String} url the url to parse, if not set use `window.location`
    ###
    getHost: ->

    ###*
    @return {String} the URL's port.
    @method
    @name #getPort
    @memberOf URLService.URLParser
    @param {String} url the url to parse, if not set use `window.location`
    ###
    getPort: ->

    ###*
    @return {String} the URL's path.
    @method
    @name #getPath
    @memberOf URLService.URLParser
    @param {String} url the url to parse, if not set use `window.location`
    ###
    getPath: ->

    ###*
    @return {String} the URL's query segment.
    @method
    @name #getQuery
    @memberOf URLService.URLParser
    @param {String} url the url to parse, if not set use `window.location`
    ###
    getQuery: ->

    ###*
    @return {String} the URL's hash if any, an emtpty string if no hash
    @method
    @name #getHash
    @memberOf URLService.URLParser
    @param {String} url the url to parse, if not set use `window.location`
    ###
    getHash: ->

    ###*
    @return {String} the URL's parameters.
    @method
    @name #getParameters
    @memberOf URLService.URLParser
    @param {String} url the url to parse, if not set use `window.location`
    ###
    getParameters: ->

    ###*
    @return {String} the query's parameter value. `null` if the parameter is not specified in the query. If the parameter has several values, returns the first value
    @method
    @name #getParameterValue
    @memberOf URLService.URLParser
    @param {String} parameter the parameter name
    @param {String} url the url to parse, if not set use `window.location`
    ###
    getParameterValue: ->

    ###*
    @return {String} the query's parameter values. `null` if the parameter is not specified in the query. If the parameter has only one value, returns an array of one element
    @method
    @name #getParameterValues
    @memberOf URLService.URLParser
    @param {String} parameter the parameter name
    @param {String} url the url to parse, if not set use `window.location`
    ###
    getParameterValues: ->

}