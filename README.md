# Container Viware PHP WEB

Repositório para gerenciamento de imagem Linux com todo o setup base, necessário para todos os meus projetos web com PHP.

## Recursos

* PHP 7.3/7.4/8.0
    - CLI
    - FPM
    - extensions
        - bcmath
        - calendar
        - Core
        - ctype
        - curl
        - date
        - decimal
        - dom
        - exif
        - FFI
        - fileinfo
        - filter
        - ftp
        - gd
        - gettext
        - gmp
        - grpc
        - hash
        - http
        - iconv
        - igbinary
        - imagick
        - imap
        - inotify
        - intl
        - json
        - ldap
        - libxml
        - mbstring
        - mcrypt
        - memcache
        - memcached
        - mongodb
        - msgpack
        - mysqli
        - mysqlnd
        - OAuth
        - odbc
        - openssl
        - pcntl
        - pcov
        - pcre
        - PDO
        - pdo_mysql
        - PDO_ODBC
        - pdo_pgsql
        - pdo_sqlite
        - pdo_sqlsrv
        - pgsql
        - Phar
        - posix
        - protobuf
        - psr
        - raphf
        - readline
        - redis
        - Reflection
        - session
        - shmop
        - SimpleXML
        - soap
        - sockets
        - sodium
        - SPL
        - sqlite3
        - sqlsrv
        - standard
        - swoole
        - sysvmsg
        - sysvsem
        - sysvshm
        - tokenizer
        - uuid
        - xdebug
        - xml
        - xmlreader
        - xmlrpc
        - xmlwriter
        - xsl
        - yaml
        - Zend OPcache
        - zip
        - zlib
        - zmq
        - zstd


* Supervisor
* Apache 2.4
    - Loaded Modules:
        - core_module (static)
        - so_module (static)
        - watchdog_module (static)
        - http_module (static)
        - log_config_module (static)
        - logio_module (static)
        - version_module (static)
        - unixd_module (static)
        - access_compat_module (shared)
        - alias_module (shared)
        - auth_basic_module (shared)
        - authn_core_module (shared)
        - authn_file_module (shared)
        - authz_core_module (shared)
        - authz_host_module (shared)
        - authz_user_module (shared)
        - autoindex_module (shared)
        - deflate_module (shared)
        - dir_module (shared)
        - env_module (shared)
        - fcgid_module (shared)
        - filter_module (shared)
        - headers_module (shared)
        - mime_module (shared)
        - mpm_event_module (shared)
        - negotiation_module (shared)
        - proxy_module (shared)
        - proxy_ajp_module (shared)
        - proxy_balancer_module (shared)
        - proxy_connect_module (shared)
        - proxy_fcgi_module (shared)
        - proxy_html_module (shared)
        - proxy_http_module (shared)
        - reqtimeout_module (shared)
        - rewrite_module (shared)
        - setenvif_module (shared)
        - slotmem_shm_module (shared)
        - socache_shmcb_module (shared)
        - ssl_module (shared)
        - status_module (shared)
        - xml2enc_module (shared)

* MySQL Client
* PostgreSQL Client

## Portas abertas:

* Apache
    - 80

* PHP 7.3-FPM
    - 7003

* PHP 7.4-FPM
    - 7004

* PHP 8.0-FPM
    - 8008