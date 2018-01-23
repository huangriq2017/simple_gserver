%% ============================================================================
%% Author            :huangriq - huangriq2015@163.com
%% QQ                :466796514
%% Last modified     :2017-06-27 14:18:46
%% Filename          :*********
%% Description       :************************
%% ============================================================================
-module(gate_data).
-include("gate.hrl").
-compile(export_all).

set_sockaddr(V) ->
  put('__sockaddr__', V).

get_sockaddr() ->
  get('__sockaddr__').

get_socket() ->
  #b_sockaddr{sock = Sock} = get_sockaddr(),
  Sock.

get_ip() ->
  #b_sockaddr{peer_ip = V} = get_sockaddr(),
  V.

set_buff(V) ->
  put('__sock_buff__', V).

get_buff() ->
  get('__sock_buff__').

set_seq(V) ->
  put('__sock_seq__', V).

get_seq() ->
  get('__sock_seq__').

set_roleid(V) ->
  put('__roleid__', V).

get_roleid() ->
  get('__roleid__').

set_rolepid(V) ->
  put('__rolepid__', V).

get_rolepid() ->
  get('__rolepid__').

set_roleref(V) ->
  put('__roleref__', V).

get_roleref() ->
  get('__roleref__').

set_packet_time(V) ->
  put('__packet_time__', V).

get_packet_time() ->
  get('__packet_time__').

set_timeout_count(V) ->
  put('__timeout_count__', V).

get_timeout_count() ->
  get('__timeout_count__').

get_heartbeat() ->
  get('__heartbeat__').

set_heartbeat(N) ->
  put('__heartbeat__', N).

set_packet_count(V) ->
  put('__packet_count__', V).

get_packet_count() ->
  get('__packet_count__').

set_packet_unexpected(V) ->
  put('__packet_unexpected__', V).

get_packet_unexpected() ->
  get('__packet_unexpected__').
  


