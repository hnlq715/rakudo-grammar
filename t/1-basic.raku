use v6;
use Test;
use lib 'lib';
use NginxParser;

plan 3;

my $match = NginxParser::Nginx.parse('server {
    location / {
        fastcgi_pass  localhost:9000;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param QUERY_STRING    $query_string;
    }

    location ~ \.(gif|jpg|png)$ {
        root /data/images;
    }
}');

say $match;

done-testing;