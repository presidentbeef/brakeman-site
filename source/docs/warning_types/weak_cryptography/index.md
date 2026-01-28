---
layout: docs
title: "Weak Cryptography"
---

### Key Size

Brakeman will warn about RSA key sizes that are smaller than recommended.

Note that key sizes generally must increase over time (when using the same cryptographic algorithm), so the recommendations here will change over time.

For short-term uses (up to year 2030), current recommendation is a minimum of 2048 bits. If data is expected to be stored longer than that, consider using 3072 or 4096.

RSA keys are becoming quite large, so for new use cases consider using [Elliptic Curve Cryptography (ECC)](https://docs.ruby-lang.org/en/4.0/OpenSSL/PKey/EC.html) instead.
ECC can provide strong security at smaller key sizes. ([Ruby examples](https://github.com/presidentbeef/ruby_crypto_examples/tree/main/ec_pkey_signatures))

```ruby
OpenSSL::PKey::RSA.generate(4096)
OpenSSL::PKey.generate_key("rsa", rsa_keygen_bits: 4096)
```

### Padding Mode

Brakeman will warn about uses of insecure padding modes for RSA.

The only recommended padding mode at this time is OAEP. Note that Ruby will default to using PKCS1 if no mode is specified, which is not safe.

If using the RSA interface directly, pass the padding as the second argument to `public_encrypt`, `private_encrypt`, `public_decrypt`, etc.

```ruby
pkey = OpenSSL::PKey::RSA.generate(4096)
pkey.public_encrypt(data, OpenSSL::PKey::RSA::PKCS1_OAEP_PADDING)
```

If using the `PKey` interface, set it as the `rsa_padding_mode` option:

```ruby
pkey = OpenSSL::PKey.generate_key("rsa", rsa_keygen_bits: 2048)
pkey.encrypt(data, "rsa_padding_mode" => "oaep")
```

---
Back to [Warning Types](/docs/warning_types)
