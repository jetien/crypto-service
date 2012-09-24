# URL Service
The URL Service specifies a [h-ubu](http://nano-project.github.com/h-ubu/snapshot/) service to handle URLs (http, https and file).
The URL Parser service allows to parse url and extract the hostname, port, path, parameters...

This projects contains:

 * The contract (i.e. interfaces)
 * A default implementation supporting http, https and file urls

## Example of usage

### Declaring the component on the hub

	hub
            .registerComponent(new URLService.DefaultURLParser.DefaultURLParserImpl())
            .start();

### Using the service            

	var ref = hub.getServiceReference(URLService.URLParser)
    var svc =  hub.getService(hub, ref)
	url = "http://www.google.com/search?sugexp=chrome,mod=16&sourceid=chrome&ie=UTF-8&q=node.js"
    expect(svc.getScheme(url)).toBe("http");
    expect(svc.getHost(url)).toBe("www.google.com");
    expect(svc.getPort(url)).toBe(80);
    expect(svc.getPath(url)).toBe("/search");
    expect(svc.getQuery(url)).toBe("sugexp=chrome,mod=16&sourceid=chrome&ie=UTF-8&q=node.js");
    expect(svc.getHash(url)).toBe("");
    expect(svc.getParameterValue("sugexp", url)).toBe("chrome,mod=16");
    expect(svc.getParameterValue("sourceid", url)).toBe("chrome");
    expect(svc.getParameterValue("ie", url)).toBe("UTF-8");
    expect(svc.getParameterValue("q", url)).toBe("node.js");

### Others features    

* Multiple paramter values are supported as _array_ and are parsed from `foo[]=1&foo[]=2` as well as `foo=1&foo-2`.
* If the url parameter is not specified, it automatically use the `window.location.href`
* If possible the default implementation relies on the native support of `window.location`
* Parameters are decoded

# License
This project is licensed under the Apache License 2.0. The project is founded by [Arrow-Group](http://arrow-group.eu).
