# Crypto Service
The Crypto Service specifies a [h-ubu](http://nano-project.github.com/h-ubu/snapshot/) service to handle hashes and ciphers.
The `HashService` allows hashing messages using several implementations (MD5 and SHA1).
The `CipherService` allows encoding and decoding messages using several implementations (AES)

This projects contains:

 * The contract (i.e. interfaces)
 * An implementation of the hash service for MD5
 * An implementation of the hash service for SHA1
 * An implementation of the cipher service for AES

## MD5

### Declaring the component on the hub

	hub
            .registerComponent(new CryptoService.MD5HashService())
            .start();

### Using the service            

	var ref = hub.getServiceReference(CryptoService.HashService)
    var svc =  hub.getService(hub, ref)

    expect(svc.hash("message")).toBe("78e731027d8fd50ed642340b7c9a63b3");

## SHA1

### Declaring the component on the hub

    hub
            .registerComponent(new CryptoService.SHA1HashService())
            .start();

### Using the service            

    var ref = hub.getServiceReference(CryptoService.HashService)
    var svc =  hub.getService(hub, ref)

    expect(svc.hash("message")).toBe("6f9b9af3cd6e8b8a73c2cdced37fe9f59226e27d");

## AES

### Declaring the component on the hub

    hub
            .registerComponent(new CryptoService.AESCipherService())
            .start();

### Using the service            

    var ref = hub.getServiceReference(CryptoService.CipherService)
    var svc =  hub.getService(hub, ref)

    var encoded = svc.encode("clement", "key");
    expect(svc.decode(encoded, "key")).toBe("clement");

# License
This project is licensed under the Apache License 2.0. The project is founded by [Arrow-Group](http://arrow-group.eu).
