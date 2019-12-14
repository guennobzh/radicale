#!/bin/sh

MAX_CONNECTIONS=${MAX_CONNECTIONS:-"20"}
MAX_CONTENT_LENGTH=${MAX_CONTENT_LENGTH:-"10000000"}
TIMEOUT=${TIMEOUT:-"10"}
SSL=${SSL:-""}
SSL_CERTIFICATE=${SSL_CERTIFICATE:-"/config/radicale.crt"}
SSL_KEY=${SSL_KEY:-"/config/radicale.key"}
SSL_CA=${SSL_CA:-"/config/radicale.pem"}
DNS_LOOKUP=${DNS_LOOKUP:-""}
REALM=${REALM:-"Radicale - Password Required"}
ENCODING=${ENCODING:-"UTF-8"}
AUTH_TYPE=${AUTH_TYPE:-"htpasswd"}
AUTH_HTPASSWD_PATH=${AUTH_HTPASSWD_PATH:-"/config/htpasswd"}
AUTH_HTPASSWD_ENCRYPTION=${AUTH_HTPASSWD_ENCRYPTION:-"bcrypt"}
AUTH_DELAY=${AUTH_DELAY:-"1"}
AUTH_RIGHTS=${AUTH_RIGHTS:-"owner_only"}
AUTH_RIGHTS_PATH=${AUTH_RIGHTS_PATH:-""}
STORAGE_TYPE=${STORAGE_TYPE:-"multifilesystem"}
STORAGE_FOLDER=${STORAGE_FOLDER:-"/data"}

exec radicale \
    --host 0.0.0.0:5232 \
    --debug \
    --no-server-daemon \
    --server-max-connections=${MAX_CONNECTIONS} \
    --server-max-content-length=${MAX_CONTENT_LENGTH} \
    --server-timeout=${TIMEOUT} \
    ${SSL:+"--no-server-ssl"} \
        ${SSL:+"--server-certificate=${SSL_CERTIFICATE}"} \
        ${SSL:+"--server-key=${SSL_KEY}"} \
        ${SSL:+"--certificate-authority=${SSL_CA}"} \
    `if [ "x${DNS_LOOKUP}" = "xTrue" ]; then echo "--server-dns-lookup"; else echo "--no-server-dns-lookup"; fi` \
    --server-realm="${REALM}" \
    --encoding-request=${ENCODING} \
    --encoding-stock=${ENCODING} \
    --auth-type=${AUTH_TYPE} \
    `if [ "${AUTH_TYPE}" = "htpasswd" ]; then echo --auth-htpasswd-filename=${AUTH_HTPASSWD_PATH}; fi` \
    `if [ "${AUTH_TYPE}" = "htpasswd" ]; then echo --auth-htpasswd-encryption=${AUTH_HTPASSWD_ENCRYPTION}; fi` \
    --auth-delay=${AUTH_DELAY} \
    --rights-type=${AUTH_RIGHTS} \
    `if [ "${AUTH_RIGHTS}" = "from_file" ]; then echo "--rights-file=${AUTH_RIGHTS_PATH}"; fi` \
    --storage-type=${STORAGE_TYPE} \
    `if [ "${STORAGE_TYPE}" = "multifilesystem" ]; then echo "--storage-filesystem-folder=${STORAGE_FOLDER}"; fi`;
