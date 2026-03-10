# EXPLANATION.md

## What was the bug?
HttpClient's OAuth2 refresh logic failed for plain object tokens. When `oauth2Token` was `{ accessToken: "stale", expiresAt: 0 }`, it bypassed refresh and received no Authorization header.

## Why did it happen?
The condition `!this.oauth2Token || (this.oauth2Token instanceof OAuth2Token && this.oauth2Token.expired)` missed plain objects because they're truthy and not OAuth2Token instances. Authorization headers were only set for OAuth2Token instances.

## Why does your fix solve it?
Added `|| !(this.oauth2Token instanceof OAuth2Token)` forces refresh for any non-OAuth2Token token. After refresh, tokens become proper OAuth2Token instances with correct Authorization headers.

## One realistic case your tests still don't cover
Plain object token with future expiration time that still needs refresh due to missing `asHeader()` method for header generation.
