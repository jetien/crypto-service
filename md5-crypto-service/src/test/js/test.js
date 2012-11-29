describe("MD5 Hash Service Test Suite", function () {

    afterEach(function () {
        hub.reset();
    });

    it("should compute the hash of messages", function () {

        hub
            .registerComponent(new CryptoService.MD5HashService())
            .start();

        var ref = hub.getServiceReference(CryptoService.HashService)
        var svc =  hub.getService(hub, ref)

        runs(function () {
            // Test simple URL 
            expect(svc.hash("message")).toBe("78e731027d8fd50ed642340b7c9a63b3");
            expect(svc.hash("")).toBe("d41d8cd98f00b204e9800998ecf8427e"); // Yes... weird, but this is the md5 of an empty string
            expect(svc.hash(null)).toBe("d41d8cd98f00b204e9800998ecf8427e"); // Same as empty string
            expect(svc.hash("{'foo':'bar'}")).toBe("9bffc89ec69deef3508c2b02b0307a8e");
        });
    });


    it("should expose the hash.algorithm property", function () {

        hub
            .registerComponent(new CryptoService.MD5HashService())
            .start();

        var ref = hub.getServiceReference(CryptoService.HashService, function(ref) {
            return ref.getProperty("hash.algorithm") === "md5";
        });
        var svc =  hub.getService(hub, ref)

        runs(function () {
            // Test simple URL 
            expect(svc.hash("message")).toBe("78e731027d8fd50ed642340b7c9a63b3");
            expect(svc.hash("")).toBe("d41d8cd98f00b204e9800998ecf8427e"); // Yes... weird, but this is the md5 of an empty string
            expect(svc.hash(null)).toBe("d41d8cd98f00b204e9800998ecf8427e"); // Same as empty string
            expect(svc.hash("{'foo':'bar'}")).toBe("9bffc89ec69deef3508c2b02b0307a8e");
        });
    });

});