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
        | [ <fastcgi_param> ]+
        |"fastcgi_pass" <fastcgi_pass>";"
    }

    rule fastcgi_param {
        "fastcgi_param" $<key>=<keyword> $<variable>=<variable>";"
    }

    token keyword {
        \w+
    }
    token variable {
        # |\$\w+
        |((\$\w+)_?)+
    }
    token fastcgi_pass {
        \w+':'\w+
    }
    token ns {
        # network space 
        # <ws> would consume, e.g., newlines, and \h (and \s) would accept 
        # more codepoints than just ASCII single space and the tab character. 
        [ ' ' | <[\t]> ]*
    }
}

class Actions {
    method TOP($/) {
        make {
            ipport => $<ipport>.made;
        }
    }

    method serverBlock($/) {
        make $/;
    }
    method locationBlock($/) {
        make $/
    }
    method ipport($/) {
        make $/;
    }

    method say(*@x) { }; method print(*@x) { }; method flush(*@x) { }
}