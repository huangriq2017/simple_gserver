-ifndef(M1_PB_H).
-define(M1_PB_H, true).
-record(m1, {
    i = [],
    b = erlang:error({required, b}),
    e = erlang:error({required, e}),
    sub = erlang:error({required, sub})
}).
-endif.

-ifndef(SUBMSG_PB_H).
-define(SUBMSG_PB_H, true).
-record(submsg, {
    s = erlang:error({required, s}),
    b = erlang:error({required, b})
}).
-endif.

