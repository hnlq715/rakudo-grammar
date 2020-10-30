use v6;

use lib 'lib';
use NginxParser;

my $match = NginxParser::Grammar.parse('server {
    location / {
        fastcgi_pass  localhost:9000;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param QUERY_STRING    $query_string;
    }

}', actions => NginxParser::Actions.new);

say $match<server><location>;