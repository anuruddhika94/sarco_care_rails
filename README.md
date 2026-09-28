# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Uploaded photos (Active Storage)

Profile photos and meal-plan photos are Active Storage attachments.

In development they go to `storage/` on disk. **In production they must go to
object storage**: Render runs the app from a Docker container whose filesystem
is wiped on every deploy and restart, so anything on local disk disappears (and
the app then falls back to placeholder images).

Production uses Cloudflare R2 (S3-compatible) whenever these environment
variables are set in the Render dashboard, and silently falls back to local disk
when they are not:

| Variable | Example | Where to find it |
| --- | --- | --- |
| `R2_BUCKET` | `sarco-care` | the bucket you create in R2 |
| `R2_ENDPOINT` | `https://<account-id>.r2.cloudflarestorage.com` | R2 bucket settings → S3 API |
| `R2_ACCESS_KEY_ID` | | R2 → Manage API tokens |
| `R2_SECRET_ACCESS_KEY` | | shown once when the token is created |

The bucket stays private: photos are served through the app's own
`/rails/active_storage/...` URLs, not from the bucket directly.
