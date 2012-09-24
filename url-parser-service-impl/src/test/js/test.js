describe("URL Parser Test Suite", function () {

    afterEach(function () {
        hub.reset();
    });

    it("should parse correctly HTTP urls", function () {

        hub
            .registerComponent(new URLService.DefaultURLParser.DefaultURLParserImpl())
            .start();

        var ref = hub.getServiceReference(URLService.URLParser)
        var svc =  hub.getService(hub, ref)

        runs(function () {
            // Test simple URL 
            var url = "http://perdu.com"
            expect(svc.getScheme(url)).toBe("http");
            expect(svc.getHost(url)).toBe("perdu.com");
            expect(svc.getPort(url)).toBe(80);
            expect(svc.getPath(url)).toBe("");
            expect(svc.getQuery(url)).toBeNull();
            expect(svc.getHash(url)).toBe("");
            expect(svc.getParameterValue("toto", url)).toBeNull();
            expect(svc.getParameterValue("toto", url)).toBeNull();

            // Test simple URL with hash
            url = "http://perdu.com#zaz"
            expect(svc.getScheme(url)).toBe("http");
            expect(svc.getHost(url)).toBe("perdu.com");
            expect(svc.getPort(url)).toBe(80);
            expect(svc.getPath(url)).toBe("");
            expect(svc.getQuery(url)).toBeNull();
            expect(svc.getHash(url)).toBe("zaz");
            expect(svc.getParameterValue("toto", url)).toBeNull();
            expect(svc.getParameterValue("toto", url)).toBeNull();

            // Test simple URL with hash
            url = "http://perdu.com?foo=bar#zaz"
            expect(svc.getScheme(url)).toBe("http");
            expect(svc.getHost(url)).toBe("perdu.com");
            expect(svc.getPort(url)).toBe(80);
            expect(svc.getPath(url)).toBe("");
            expect(svc.getQuery(url)).toBe("foo=bar");
            expect(svc.getHash(url)).toBe("zaz");
            expect(svc.getParameterValue("foo", url)).toBe("bar");

            // Test url with parameter
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
            expect(svc.getParameterValue("toto", url)).toBeNull();

            // Test URL with encoded parameters and port
            url = "http://localhost:3000/foo_bar/?action=view&section=info&id=123&debug&testy%5B%5D=true&testy%5B%5D=false&testy%5B%5D"
            expect(svc.getScheme(url)).toBe("http");
            expect(svc.getHost(url)).toBe("localhost");
            expect(svc.getPort(url)).toBe(3000);
            expect(svc.getPath(url)).toBe("/foo_bar/");
            expect(svc.getQuery(url)).toBe("action=view&section=info&id=123&debug&testy[]=true&testy[]=false&testy[]");
            expect(svc.getHash(url)).toBe("");
            expect(svc.getParameterValue("action", url)).toBe("view");
            expect(svc.getParameterValue("section", url)).toBe("info");
            expect(svc.getParameterValue("id", url)).toBe(123);
            expect(svc.getParameterValue("debug", url)).toBe(true);
            expect(svc.getParameterValue("testy", url)).toBe(true); // First value from the array
            expect(svc.getParameterValues("testy", url)[0]).toBe(true);
            expect(svc.getParameterValues("testy", url)[1]).toBe(false);
            expect(svc.getParameterValues("testy", url)[2]).toBe(true);

            // Same with a different way to encode the array
            url = "http://localhost:3000/foo_bar/?action=view&section=info&id=123&debug&testy=true&testy=false&testy"
            expect(svc.getScheme(url)).toBe("http");
            expect(svc.getHost(url)).toBe("localhost");
            expect(svc.getPort(url)).toBe(3000);
            expect(svc.getPath(url)).toBe("/foo_bar/");
            expect(svc.getQuery(url)).toBe("action=view&section=info&id=123&debug&testy=true&testy=false&testy");
            expect(svc.getParameterValue("action", url)).toBe("view");
            expect(svc.getParameterValue("section", url)).toBe("info");
            expect(svc.getParameterValue("id", url)).toBe(123);
            expect(svc.getParameterValue("debug", url)).toBe(true);
            expect(svc.getParameterValue("testy", url)).toBe(true); // First value from the array
            expect(svc.getParameterValues("testy", url)[0]).toBe(true);
            expect(svc.getParameterValues("testy", url)[1]).toBe(false);
            expect(svc.getParameterValues("testy", url)[2]).toBe(true);
        });
    });

    it("should parse correctly HTTPS urls", function () {

        hub
            .registerComponent(new URLService.DefaultURLParser.DefaultURLParserImpl())
            .start();

        var ref = hub.getServiceReference(URLService.URLParser)
        var svc =  hub.getService(hub, ref)

        runs(function () {
            // Test simple URL 
            var url = "https://perdu.com"
            expect(svc.getScheme(url)).toBe("https");
            expect(svc.getHost(url)).toBe("perdu.com");
            expect(svc.getPort(url)).toBe(80);
            expect(svc.getPath(url)).toBe("");
            expect(svc.getQuery(url)).toBeNull();
            expect(svc.getHash(url)).toBe("");
            expect(svc.getParameterValue("toto", url)).toBeNull();
            expect(svc.getParameterValue("toto", url)).toBeNull();

            // Test url with parameter
            url = "https://www.google.com/search?sugexp=chrome,mod=16&sourceid=chrome&ie=UTF-8&q=node.js"
            expect(svc.getScheme(url)).toBe("https");
            expect(svc.getHost(url)).toBe("www.google.com");
            expect(svc.getPort(url)).toBe(80);
            expect(svc.getPath(url)).toBe("/search");
            expect(svc.getQuery(url)).toBe("sugexp=chrome,mod=16&sourceid=chrome&ie=UTF-8&q=node.js");
            expect(svc.getHash(url)).toBe("");
            expect(svc.getParameterValue("sugexp", url)).toBe("chrome,mod=16");
            expect(svc.getParameterValue("sourceid", url)).toBe("chrome");
            expect(svc.getParameterValue("ie", url)).toBe("UTF-8");
            expect(svc.getParameterValue("q", url)).toBe("node.js");
            expect(svc.getParameterValue("toto", url)).toBeNull();
        });
    });

    it("should parse correctly file urls", function () {

        hub
            .registerComponent(new URLService.DefaultURLParser.DefaultURLParserImpl())
            .start();

        var ref = hub.getServiceReference(URLService.URLParser)
        var svc =  hub.getService(hub, ref)

        runs(function () {
            // Test simple URL 
            var url = "file:///Users/Clement/Home/index.html"
            expect(svc.getScheme(url)).toBe("file");
            expect(svc.getHost(url)).toBe("localhost"); // Constant
            expect(svc.getPort(url)).toBe(0);
            expect(svc.getPath(url)).toBe("/Users/Clement/Home/index.html");
            expect(svc.getQuery(url)).toBeNull();
            expect(svc.getHash(url)).toBe("");

            // File url with hash
            url = "file:///Users/Clement/Home/index.html#here"
            expect(svc.getScheme(url)).toBe("file");
            expect(svc.getHost(url)).toBe("localhost"); // Constant
            expect(svc.getPort(url)).toBe(0);
            expect(svc.getPath(url)).toBe("/Users/Clement/Home/index.html");
            expect(svc.getQuery(url)).toBeNull();
            expect(svc.getHash(url)).toBe("here");

            // Test url with parameters
            url = "file:///Users/Clement/Home/index.html?sugexp=chrome,mod=16&sourceid=chrome&ie=UTF-8&q=node.js"
            expect(svc.getQuery(url)).toBe("sugexp=chrome,mod=16&sourceid=chrome&ie=UTF-8&q=node.js");
            expect(svc.getParameterValue("sugexp", url)).toBe("chrome,mod=16");
            expect(svc.getParameterValue("sourceid", url)).toBe("chrome");
            expect(svc.getParameterValue("ie", url)).toBe("UTF-8");
            expect(svc.getParameterValue("q", url)).toBe("node.js");
            expect(svc.getParameterValue("toto", url)).toBeNull();
        });
    });

});