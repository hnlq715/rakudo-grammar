unit module NginxParser;
use Grammar::Tracer;

grammar Grammar {
    rule TOP {
        'server' '{' <server> '}'
    }

    rule server {
        "location" '/' '{' [ <location> ]+ '}'
    };

    rule location {
        | <location_cmd> <fastcgi_pass_value> ";"
        | <location_cmd> $<key>=<keyword> $<variable>=<variable> ";"
    }

    proto token location_cmd {*}
    token location_cmd:sym<fastcgi_pass> {<sym>}
    token location_cmd:sym<fastcgi_param> {<sym>}

    token keyword {
        \w+
    }

    token variable {
        # |\$\w+
        |((\$\w+)_?)+
    }

    token fastcgi_pass_value {
        \w+':'\w+
    }
}

class Actions {
    method say(*@x) { }; method print(*@x) { }; method flush(*@x) { }
}