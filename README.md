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

Production uses Neon Object Storage (S3-compatible, in the same Neon project as
the database) whenever these environment variables are set in the Render
dashboard, and falls back to local disk when they are not:

| Variable | Example | Where to find it |
| --- | --- | --- |
| `S3_BUCKET` | `sarcocarebucket` | the bucket name in Neon |
| `AWS_ENDPOINT_URL_S3` | `https://…` | Neon → Object Storage → the branch's endpoint |
| `AWS_ACCESS_KEY_ID` | | Neon scoped credential with storage read/write |
| `AWS_SECRET_ACCESS_KEY` | | shown once when the credential is created |
| `AWS_REGION` | optional, defaults to `auto` | |

The bucket stays private: photos are served through the app's own
`/rails/active_storage/...` URLs, not from the bucket directly.

The same config works against Cloudflare R2 or Amazon S3 — only the endpoint,
bucket and keys change.
