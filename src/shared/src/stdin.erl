%% ============================================================================
%% Author            :huangriq - huangriq2015@163.com
%% QQ                :466796514
%% Last modified     :2018-01-18 15:41:53
%% Filename          :*********
%% Description       :************************
%% ============================================================================
-module(stdin).
-include("stdin.hrl").

-compile(export_all).

seed() ->
  random:seed(now()).

tou(S) ->
  if
    is_list(S) andalso length(S) =:= 4 -> list_to_tuple(S);
    is_list(S)            -> {ok, T1} = inet_parse:address(S), T1;
    is_integer(S) andalso S < 16#FFFFFFFF -> list_to_tuple([(S bsr X) band 16#FF || X <- [24, 16, 8, 0]]);
    true -> S
  end.
