# For more information on configuration, see:
# * Official English Documentation: http://nginx.org/en/docs/
# * Official Russian Documentation: http://nginx.org/ru/docs/
user <%= $user %>;
worker_processes 1;
error_log <%= $logdir %>/error.log;
events {
worker_connections 1024;
}
http {
include <%= $confdir %>/mime.types;
default_type application/octet-stream;
log_format main '$remote_addr - $remote_user [$time_local] "$request" '
'$status $body_bytes_sent "$http_referer" '
'"$http_user_agent" "$http_x_forwarded_for"';
access_log <%= $logdir %>/access.log main;
sendfile on;
#tcp_nopush on;
#keepalive_timeout 0;
keepalive_timeout 65;
#gzip on;
# Load config files from the conf.d directory
# The default server is in conf.d/default.conf
include <%= $confdir %>/conf.d/*.conf;
}
