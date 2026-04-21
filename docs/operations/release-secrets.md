# Release Secrets and Variables Reference

This document describes every GitHub Actions secret and repository
variable required by the Naked Products release pipeline. All secrets
are stored under **Settings → Secrets and variables → Actions** in the
`mfcollins3/products` repository.

---

## macOS Code Signing and Notarization

These secrets are used by `_build-sea.yml` (binary signing +
notarization) and `release.yml` → `package-macos` (installer .pkg
signing + notarization).

### `APPLE_DEVELOPER_ID_CERT_P12`

| Field | Value |
|---|---|
| Type | Secret |
| Used by | `_build-sea.yml`, `release.yml` (`package-macos`) |

Base64-encoded Developer ID Application certificate (.p12 / PKCS#12
bundle). This certificate is used to sign the raw SEA binary with
`codesign`. The `package-macos` job also expects a Developer ID
**Installer** certificate in the same P12 bundle (or a separate one
stored under the same secret) for `productbuild` signing.

**How to obtain:**

1. In Xcode → Settings → Accounts, log in with your Apple ID.
2. Under your team, click **Manage Certificates**.
3. Create (or confirm you have) a **Developer ID Application** and a
   **Developer ID Installer** certificate.
4. Export both to a single .p12 file from Keychain Access
   (right-click → Export).
5. Base64-encode the file:
   ```plain
   base64 -i developer-id.p12 | pbcopy
   ```
6. Paste the result as the secret value.

---

### `APPLE_DEVELOPER_ID_CERT_PASSWORD`

| Field | Value |
|---|---|
| Type | Secret |
| Used by | `_build-sea.yml`, `release.yml` (`package-macos`) |

The passphrase you set when exporting the .p12 file in the step above.

---

### `APPLE_TEAM_ID`

| Field | Value |
|---|---|
| Type | Secret |
| Used by | `_build-sea.yml`, `release.yml` (`package-macos`) |

Your 10-character Apple Developer Team ID. Find it at
<https://developer.apple.com/account> under Membership Details.

Example value: `AB12CD34EF`

---

### `APPLE_NOTARY_APPLE_ID`

| Field | Value |
|---|---|
| Type | Secret |
| Used by | `_build-sea.yml`, `release.yml` (`package-macos`) |

The Apple ID (email address) of the account used for notarization. This
is passed as `--apple-id` to `xcrun notarytool`.

---

### `APPLE_NOTARY_APP_SPECIFIC_PASSWORD`

| Field | Value |
|---|---|
| Type | Secret |
| Used by | `_build-sea.yml`, `release.yml` (`package-macos`) |

An app-specific password for the Apple ID above. Required by
`notarytool` because two-factor authentication is mandatory for Apple ID
accounts and `notarytool` cannot prompt for a 2FA code in CI.

**How to obtain:**

1. Sign in to <https://appleid.apple.com>.
2. Under **Sign-In and Security → App-Specific Passwords**, click
   **Generate an app-specific password**.
3. Label it "GitHub Actions Notarytool" (or similar).
4. Copy and store the generated password as this secret.

---

## Windows Code Signing (Azure Trusted Signing)

Used by `_build-sea.yml` (binary signing) and `release.yml`
(`package-windows`, MSI signing).

### `AZURE_TENANT_ID`

| Field | Value |
|---|---|
| Type | Secret |
| Used by | `_build-sea.yml`, `release.yml` (`package-windows`) |

The Azure Active Directory tenant ID that owns the Trusted Signing
account. Found in Azure Portal → Microsoft Entra ID → Overview.

---

### `AZURE_CLIENT_ID`

| Field | Value |
|---|---|
| Type | Secret |
| Used by | `_build-sea.yml`, `release.yml` (`package-windows`) |

The Application (client) ID of the Azure service principal or managed
identity that has the **Trusted Signing Certificate Profile Signer**
role on the Trusted Signing account.

**How to obtain:**

1. In Azure Portal → Microsoft Entra ID → App registrations, create a
   new app registration (or use an existing service principal).
2. Note the **Application (client) ID**.
3. Assign the **Trusted Signing Certificate Profile Signer** role to
   this service principal on the Trusted Signing account resource.

---

### `AZURE_CLIENT_SECRET`

| Field | Value |
|---|---|
| Type | Secret |
| Used by | `_build-sea.yml`, `release.yml` (`package-windows`) |

A client secret for the service principal above.

**How to obtain:**
In Azure Portal → App registrations → [your app] →
Certificates & secrets → New client secret. Copy the secret **value**
immediately (it is not shown again after leaving the page).

---

### `AZURE_TRUSTED_SIGNING_ENDPOINT` (Variable)

| Field | Value |
|---|---|
| Type | Variable (not a secret) |
| Used by | `_build-sea.yml`, `release.yml` (`package-windows`) |

The HTTPS endpoint of your Trusted Signing account. Format:
`https://<account-name>.<region>.codesigning.azure.net`

Example: `https://nakedproducts.eus.codesigning.azure.net`

---

### `AZURE_TRUSTED_SIGNING_ACCOUNT` (Variable)

| Field | Value |
|---|---|
| Type | Variable (not a secret) |
| Used by | `_build-sea.yml`, `release.yml` (`package-windows`) |

The name of your Azure Trusted Signing account resource.

---

### `AZURE_TRUSTED_SIGNING_CERT_PROFILE` (Variable)

| Field | Value |
|---|---|
| Type | Variable (not a secret) |
| Used by | `_build-sea.yml`, `release.yml` (`package-windows`) |

The name of the certificate profile within the Trusted Signing account.

---

## Distribution Channels

### `HOMEBREW_TAP_TOKEN`

| Field | Value |
|---|---|
| Type | Secret |
| Used by | `release.yml` (`publish-homebrew`) |

A GitHub Personal Access Token (PAT) with `repo` (read + write) scope
on the `mfcollins3/homebrew-tap` repository. The release workflow uses
this token to clone the tap, write `Formula/nakedproducts.rb`, and push
the commit.

**How to obtain:**

1. Go to <https://github.com/settings/tokens> → **Fine-grained tokens**.
2. Create a token scoped to the `mfcollins3/homebrew-tap` repository.
3. Grant **Contents: Read and Write**.
4. Set an expiration date and rotate before it expires.

---

### `WINGET_SOURCE_TOKEN`

| Field | Value |
|---|---|
| Type | Secret |
| Used by | `release.yml` (`publish-winget-custom`) |

An API key (Azure Function host key or function key) for the custom
WinGet REST source at `https://winget.michaelfcollins3.dev`. This key
is sent as the `x-functions-key` HTTP header when posting package
manifests.

**How to obtain:**
In Azure Portal → Function App → Functions → [function name] →
Function Keys, copy the default function key or create a dedicated one.

---

### `WINGET_PKGS_TOKEN`

| Field | Value |
|---|---|
| Type | Secret |
| Used by | `release.yml` (`publish-winget-official`) |
| Condition | Only used for stable releases (`vX.Y.Z`, X ≥ 1) |

A GitHub PAT with `repo` scope on a fork of `microsoft/winget-pkgs`.
`wingetcreate` uses this token to fork `microsoft/winget-pkgs` (if not
already forked), commit the new manifest, and open a pull request.

**How to obtain:**

1. Fork `microsoft/winget-pkgs` under the `mfcollins3` account if not
   already done.
2. Create a classic PAT at <https://github.com/settings/tokens> with
   the `public_repo` scope (fine-grained tokens do not yet support
   cross-repo PRs for `wingetcreate`).
3. Ensure the `mfcollins3` account has commit access to its fork.

---

## GitHub Actions Built-in Token

### `GITHUB_TOKEN`

| Field | Value |
|---|---|
| Type | Automatically provisioned by GitHub |
| Used by | `release.yml` (`github-release`), `dependabot-automerge.yml` |

The automatically-provisioned workflow token. No configuration required.
The `github-release` job requests `contents: write` permission to
create the GitHub Release.

---

## Quick-Reference Table

| Name | Type | Where to set | Used by |
|---|---|---|---|
| `APPLE_DEVELOPER_ID_CERT_P12` | Secret | Repo Actions secrets | `_build-sea.yml`, `package-macos` |
| `APPLE_DEVELOPER_ID_CERT_PASSWORD` | Secret | Repo Actions secrets | `_build-sea.yml`, `package-macos` |
| `APPLE_TEAM_ID` | Secret | Repo Actions secrets | `_build-sea.yml`, `package-macos` |
| `APPLE_NOTARY_APPLE_ID` | Secret | Repo Actions secrets | `_build-sea.yml`, `package-macos` |
| `APPLE_NOTARY_APP_SPECIFIC_PASSWORD` | Secret | Repo Actions secrets | `_build-sea.yml`, `package-macos` |
| `AZURE_TENANT_ID` | Secret | Repo Actions secrets | `_build-sea.yml`, `package-windows` |
| `AZURE_CLIENT_ID` | Secret | Repo Actions secrets | `_build-sea.yml`, `package-windows` |
| `AZURE_CLIENT_SECRET` | Secret | Repo Actions secrets | `_build-sea.yml`, `package-windows` |
| `AZURE_TRUSTED_SIGNING_ENDPOINT` | Variable | Repo Actions variables | `_build-sea.yml`, `package-windows` |
| `AZURE_TRUSTED_SIGNING_ACCOUNT` | Variable | Repo Actions variables | `_build-sea.yml`, `package-windows` |
| `AZURE_TRUSTED_SIGNING_CERT_PROFILE` | Variable | Repo Actions variables | `_build-sea.yml`, `package-windows` |
| `HOMEBREW_TAP_TOKEN` | Secret | Repo Actions secrets | `publish-homebrew` |
| `WINGET_SOURCE_TOKEN` | Secret | Repo Actions secrets | `publish-winget-custom` |
| `WINGET_PKGS_TOKEN` | Secret | Repo Actions secrets | `publish-winget-official` |

---

## Important Notes

### Homebrew formula and .pkg files

The current `Formula/nakedproducts.rb` template references `.pkg`
installer URLs. Homebrew formulae cannot extract a raw binary from a
macOS `.pkg` payload with `bin.install`. Before the first release,
either:

- Convert the formula to a **Homebrew cask** (handles `.pkg`
  natively via `pkg :allow_untrusted` or standard flow), or
- Add a macOS binary tarball (`.tar.gz`) to the release pipeline and
  update the formula URL to point at the tarball.

This is a known gap in the current template and needs resolution before
`brew install mfcollins3/tap/nakedproducts` will work correctly.

### WiX UpgradeCode GUID

The GUID `00000000-0000-0000-0000-000000000001` in
`packaging/windows/nakedproducts.wxs` is a placeholder. It **must** be
replaced with a real, unique, permanent GUID before any Windows installer
is published. Use `uuidgen` (macOS/Linux) or `[guid]::NewGuid()` in
PowerShell to generate one. Once set and shipped, this GUID must never
change.

### WinGet custom source infrastructure

The Azure Function App backing `winget.michaelfcollins3.dev` must be
provisioned before the first release. See `microsoft/winget-cli-restsource`
for the deployment template. A CNAME record pointing
`winget.michaelfcollins3.dev` to the Function App's default hostname is
also required (Michael owns `michaelfcollins3.dev`).
