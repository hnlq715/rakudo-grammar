unit module Protobuf;
use Grammar::Tracer;

grammar Grammar {
    rule TOP {
        [ <expr> ]*
    }

    rule expr {
        |<.ws> "syntax" "=" "\"" <syntax> "\"" ";"
        |<.ws> "package" <package>";"
    }

    token syntax {
        \w+
    }
    token package {
        \w+
    }
}

class Actions {
    method say(*@x) { }; method print(*@x) { }; method flush(*@x) { }
}