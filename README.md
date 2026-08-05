# pentrail-test

**⚠️ INTENTIONALLY VULNERABLE — DO NOT DEPLOY, DO NOT REUSE THIS CODE.**

A deliberately insecure demo application used to exercise
[PenTrail](https://pentrail-erup.fly.dev) scanning across a secure-development
lifecycle. Every credential here is fabricated and inert; none uses a real
provider's token format and none authenticates against any system.

Each branch is a stage. Scan them in order and compare:

| Branch | Stage | Findings | Risk |
|---|---|---|---|
| `main` / `v1.0-vulnerable` | Initial project, multiple vulnerabilities | 63 | F (100) |
| `v1.1-secrets-fixed` | Hardcoded credentials and committed key removed | 54 | D (100) |
| `v1.2-injection-fixed` | SQL and command injection fixed; urllib3 + PyYAML patched | 39 | D (96) |
| `v1.3-crypto-hardened` | Strong hashing, no `eval`, non-root container, bucket hardened; Flask + requests patched | 20 | D (73) |
| `v2.0-secure` | Last dependency patched, infrastructure closed, debug disabled | 0 | A (0) |

Dependency upgrades are deliberately spread across v1.2, v1.3 and v2.0 rather than
landing all at once. Applied only at the end, they pinned every earlier stage near a
maximum score and made the remediation work in v1.1 and v1.2 invisible in the numbers.

Counts were measured with the full engine profile (semgrep, bandit, gosec, trivy,
checkov, kics, hadolint, gitleaks) on 2026-08-05. They drift as new CVEs are published
against the pinned versions — that is the dependency lane working, not a broken fixture.

Expect risk score, finding counts, severity mix and compliance posture to
improve measurably at each step.
