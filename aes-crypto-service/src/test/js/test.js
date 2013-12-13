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

        var salt = "3FF2EC019C627B945225DEBAD71A01B6985FE84C95A70EB132882F88C0A59A55"
        var iv = "F27D5C9927726BCEFE7510B1BDD3D137"

        runs(function () {
            var encoded = svc.encode("clement", "key", salt, iv);
            expect(svc.decode(encoded, "key", salt, iv)).toBe("clement");
            expect(svc.decode(encoded, "key2", salt, iv)).not.toBe("clement");
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