%% ============================================================================
%% Author            :huangriq - huangriq2015@163.com
%% QQ                :466796514
%% Last modified     : 2018-01-18 11:30:15
%% Filename          
%% Description       :************************
%% ============================================================================

-module(stdlib).
-include("stdin.hrl").
-compile(export_all).

get_env(K) ->
  get_env(K, undefined).

get_env(K, Def) ->
  case application:get_env(gserver, K) of
    {ok, V} ->
      V;
    _ ->
      Def
  end.

set_env(K, V) ->
  application:set_env(gserver, K, V).

process_tag(Tag) ->
  process_tag(Tag, true).

process_tag(Tag, TrapExit) ->
  stdin:seed(),
  process_flag(trap_exit, TrapExit),
  put('__process_tag__', Tag).

encode(Msg) ->
  Bin0 = pt:write({element(1, Msg), Msg}),
  Len = byte_size(Bin0),
  {_, Bin1} = pt:read({uint16, Bin0}),
  <<(pt:write({uint16, Len}))/binary, Bin1/binary>>.

mh_set(FunLoop, FunAdd) ->
  set_mh_loop(FunLoop),
  set_mh(minheap:new(FunAdd)).

mh_set(FunLoop, FunAdd, Args) ->
  set_mh_loop(FunLoop),
  set_mh(minheap:new(FunAdd, Args)).

mh_empty() ->
  Mh = get_mh(),
  set_mh(minheap:empty(Mh)),
  ok.

mh_add(Elem) ->
  Mh = get_mh(),
  set_mh(minheap:push(Elem, Mh)),
  ok.

mh_del(ID) ->
  Mh = get_mh(),
  set_mh(minheap:remove(ID, Mh)),
  ok.

mh_loop(Index, Ref) ->
  Mh = get_mh(),
  {Mod, CMP} = get_mh_loop(),
  case minheap:size(Mh) of
    true ->
      Elem = minheap:top(Mh),
      case Mod:CMP(element(Index, Elem), Ref) of
        true ->
          set_mh(minheap:pop(Mh)),
          ?CATCH(Mod:handle_mh(Elem, Ref)),
          mh_loop(Index, Ref);
        false ->
          ignore
      end;
    false ->
      ignore
  end.

mh_chk(ID) ->
 mh_find(ID) =/= error.

mh_find(ID) ->
  Mh = get_mh(),
  minheap:find(ID, Mh).

set_mh_loop(Fun) ->
  put('__mh_loop__', Fun).

get_mh_loop() ->
  get('__mh_loop__').

set_mh(Mh) ->
  put('__mh__', Mh).

get_mh() ->
  get('__mh__').

