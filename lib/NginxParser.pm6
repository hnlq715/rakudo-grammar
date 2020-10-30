unit module NginxParser;

grammar Nginx {
    rule TOP {
        'server'<.ns> '{'<.ns> <serverBlock> <.ns>'}' <.ns>
    }

    rule serverBlock {
        "location"<.ns> '/'<.ns> '{' 
            [ <locationBlock> ]+
        '<.ns>}<.ns>'
    };

    token locationBlock {
        |[ "fastcgi_param" <fastcgi_param> ]+ {
            say "fastcgi_param",$<name>,$<value>
        }
        |"fastcgi_pass"<.ns> <ipport><.ns>';'{
            say 'fastcgi_pass:',$<ipport>
        }
    }

    rule fastcgi_param {
        <.ns> $<name>=\w+<.ns> $<value>=((\$\w+)+)<.ns>';'
    }

    token keyword {
        \w+
    }
    token ipport {
        \w+':'\w+
    }
    token ns {
        # network space 
        # <ws> would consume, e.g., newlines, and \h (and \s) would accept 
        # more codepoints than just ASCII single space and the tab character. 
        [ ' ' | <[\t]> ]*
    }
}
