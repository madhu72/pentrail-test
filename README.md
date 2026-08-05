# pentrail-test

**⚠️ INTENTIONALLY VULNERABLE — DO NOT DEPLOY, DO NOT REUSE THIS CODE.**

A deliberately insecure demo application used to exercise
[PenTrail](https://pentrail-erup.fly.dev) scanning across a secure-development
lifecycle. Every credential here is fabricated and inert; none uses a real
provider's token format and none authenticates against any system.

Each branch is a stage. Scan them in order and compare:

| Branch | Stage |
|---|---|
| `main` / `v1.0-vulnerable` | Initial project, multiple vulnerabilities |
| `v1.1-secrets-fixed`       | Hardcoded credentials removed |
| `v1.2-injection-fixed`     | SQL and command injection fixed |
| `v1.3-crypto-hardened`     | Weak crypto, `eval`, container and IaC hardening |
| `v2.0-secure`              | Dependencies patched, debug disabled |

Expect risk score, finding counts, severity mix and compliance posture to
improve measurably at each step.
