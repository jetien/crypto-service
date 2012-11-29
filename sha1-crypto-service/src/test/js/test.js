describe("MD5 Hash Service Test Suite", function () {

    afterEach(function () {
        hub.reset();
    });

    it("should compute the hash of messages", function () {

        hub
            .registerComponent(new CryptoService.SHA1HashService())
            .start();

        var ref = hub.getServiceReference(CryptoService.HashService)
        var svc =  hub.getService(hub, ref)

        runs(function () {
            // Test simple URL 
            expect(svc.hash("message")).toBe("6f9b9af3cd6e8b8a73c2cdced37fe9f59226e27d");
            expect(svc.hash("")).toBe("da39a3ee5e6b4b0d3255bfef95601890afd80709"); // Yes... weird, but this is the md5 of an empty string
            expect(svc.hash(null)).toBe("da39a3ee5e6b4b0d3255bfef95601890afd80709"); // Same as empty string
            expect(svc.hash("{'foo':'bar'}")).toBe("b1a7ca8b5f942cddd01d30faf01c1d2a9afbe474");
        });
    });


    it("should expose the hash.algorithm property", function () {

        hub
            .registerComponent(new CryptoService.SHA1HashService())
            .start();

        var ref = hub.getServiceReference(CryptoService.HashService, function(ref) {
            return ref.getProperty("hash.algorithm") === "sha1";
        });
        var svc =  hub.getService(hub, ref)

        runs(function () {
            // Test simple URL 
            expect(svc.hash("message")).toBe("6f9b9af3cd6e8b8a73c2cdced37fe9f59226e27d");
        });
    });

});