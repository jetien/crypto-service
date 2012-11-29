describe("AES Cipher Service Test Suite", function () {

    afterEach(function () {
        hub.reset();
    });

    it("should compute the AES of messages", function () {

        hub
            .registerComponent(new CryptoService.AESCipherService())
            .start();

        var ref = hub.getServiceReference(CryptoService.CipherService)
        var svc =  hub.getService(hub, ref)

        runs(function () {
            var encoded = svc.encode("clement", "key");
            expect(svc.decode(encoded, "key")).toBe("clement");
            expect(svc.decode(encoded, "key2")).not.toBe("clement");
        });
    });


    it("should expose the cipher.algorithm property", function () {

        hub
            .registerComponent(new CryptoService.AESCipherService())
            .start();

        var ref = hub.getServiceReference(CryptoService.CipherService, function(ref) {
            return ref.getProperty("cipher.algorithm") === "aes";
        });
        var svc =  hub.getService(hub, ref)

        runs(function () {
            expect(svc).not.toBe(null)
        });
    });

});