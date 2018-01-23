%% ============================================================================
%% Author            :huangriq - huangriq2015@163.com
%% QQ                :466796514
%% Last modified     :2018-01-22 16:52:39
%% Filename          :*********
%% Description       :************************
%% ============================================================================
-module(bot).
-include("gate.hrl").

-compile(export_all).

open(Sock, ID) ->
  stdlib:process_tag(?MODULE),
  set_id(ID),
  Accname = to_accname(ID),
  Procname = procname(ID),
  set_accname(Accname),
  erlang:register(Procname, self()),

  {ok, {LocalIP, LocalPort}} = inet:sockname(Sock),
  {ok, {PeerIP, PeerPort}}   = inet:peername(Sock),
  gate_data:set_sockaddr(#b_sockaddr{sock = Sock, local_ip = LocalIP, local_port = LocalPort,
              peer_ip = PeerIP, peer_port = PeerPort}),

  set_buff(<<>>),
  ?ERROR("启动机器人：~w", [ID]).

close(_Sock,_Reason) ->
  ?ERROR("关闭机器人：~w", [get_id()]).

recv(_Sock, Msg) ->
  handle_bin(<<(get_buff())/binary, Msg/binary>>).

message(Msg) ->
  handle(Msg).

message_return(Msg) ->
  handle(Msg).

handle_bin(Msg0) ->
  case pt:read({binary, Msg0}) of
    {Msg1, Msg2} ->
      {_Module, _Method, Msg} = pt:read({toc, Msg1}),
      message(Msg),
      handle_bin(Msg2);
    _ ->
      set_buff(Msg0)
  end.

send(Msg) ->
  Bin = pt:write(Msg),
  erlang:port_command(get_sock(), Bin, [force]).

handle({send, Msg}) ->
  send(Msg);

handle(Msg) ->
  ?ERROR("Recv ~w", [Msg]).

send(ID, Msg) ->
  Pid = whereis(procname(ID)),
  Pid ! {send, Msg}.

set_id(ID) ->
  put('__id__', ID).

get_id() ->
  get('__id__').

set_sockaddr(SA) ->
  put('__sockaddr__', SA).

get_sockaddr() ->
  get('__sockaddr__').

get_sock() ->
  #b_sockaddr{sock = Sock} = get_sockaddr(),
  Sock.

set_buff(Buff) ->
  put('__buff__', Buff).

get_buff() ->
  get('__buff__').

set_accname(Accname) ->
  put('__accname__', Accname).

get_accname() ->
  get('__accname__').

to_accname(ID) ->
  lists:concat(["rbt_", ID]).

procname(ID) ->
  list_to_atom(to_accname(ID)).
