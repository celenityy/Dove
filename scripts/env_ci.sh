# shellcheck shell=bash
# Dove CI environment variables

# Log directory
export DOVE_LOG_DIR="${DOVE_LOG_ARTIFACTS}"

# S3

## Artifacts
export DOVE_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE='/opt/celenity/celenity-artifacts-s3-access-key.txt'
export DOVE_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE='/opt/celenity/celenity-artifacts-s3-bucket-name.txt'
export DOVE_CEL_ARTIFACTS_S3_ENDPOINT_FILE='/opt/celenity/celenity-artifacts-s3-endpoint.txt'
export DOVE_CEL_ARTIFACTS_S3_SECRET_KEY_FILE='/opt/celenity/celenity-artifacts-s3-secret-key.txt'

## Releases
export DOVE_CEL_RELEASES_S3_ACCESS_KEY_FILE='/opt/celenity/celenity-releases-s3-access-key.txt'
export DOVE_CEL_RELEASES_S3_BUCKET_NAME_FILE='/opt/celenity/celenity-releases-s3-bucket-name.txt'
export DOVE_CEL_RELEASES_S3_ENDPOINT_FILE='/opt/celenity/celenity-releases-s3-endpoint.txt'
export DOVE_CEL_RELEASES_S3_SECRET_KEY_FILE='/opt/celenity/celenity-releases-s3-secret-key.txt'
