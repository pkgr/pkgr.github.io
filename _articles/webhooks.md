---
title: Webhooks
order: 8
categories:
  - reference
---

## Webhooks

Packager.io supports sending HTTP webhooks to an endpoint of your choice,
whenever a new package is published. You can specify new webhooks in your
application settings. Just enter the HTTP(S) URL to which the following JSON
payload will be `POST`ed:

```json
{
  "event":"package",
  "filename":"openproject_4.2.9-1452166686.e6da738.wheezy_amd64.deb",
  "commit":"e6da738e86e616e1046199a7720f5f028e39b96f",
  "branch":"release/4.2",
  "tag":"4.2.9",
  "tagged":false,
  "real_tag":null,
  "distribution":"debian-7",
  "package_url":"https://pkgr-production-deb.s3.amazonaws.com/gh/opf/openproject/pool/o/op/openproject_4.2.9-1452166686.e6da738.wheezy_amd64.deb?AWSAccessKeyId=AKIAJFGZVGZONQB4NGVA\u0026Expires=1455913612\u0026Signature=C5tGwhN5MtL37GQKbLPaP7RXf%2FM%3D",
  "upstream_url":"https://github.com/opf/openproject/commit/e6da738e86e616e1046199a7720f5f028e39b96f",
  "build_url":"https://packager.io/gh/opf/openproject/build_runs/1717"
}
```

Only the `package` event type is supported for the time being.

Note that the `package_url` is a signed S3 URL, which has an expiration date of
+1month. This may be reduced in the future, so do not wait too long before
downloding the package if you need it.

Webhook requests have a timeout of 10 seconds.
