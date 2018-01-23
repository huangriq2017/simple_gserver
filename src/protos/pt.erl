%% ============================================================================
%% Author            :huangriq - huangriq2015@163.com
%% QQ                :466796514
%% Last modified     :2018-01-22 10:42:55
%% Filename          :*********
%% Description       :************************
%% ============================================================================
-module(pt).
-export([read/1,write/1]).

read({binary, V0}) ->
  case byte_size(V0) >= 4 of
    true ->
      <<Len:16, V1/binary>> = V0,
      RLen = Len - 2,
      BLen = RLen * 8,
      case V1 of
        <<Val:BLen,V2/binary>> ->
          {<<Len:16, Val:BLen>>, V2};
        _ ->
          V0
      end;
    false ->
      V0
  end;
read({Type, Bin}) ->
  <<_Len:16, ModID:8, MothedID:8, Bin1/binary>> = Bin,
 {Mod, RName} = get_mod(Type, ModID, MothedID),
 Msg = Mod:decode_msg(Bin1, RName),
 {ModID, MothedID, Msg}.

write(Msg) ->
  RName = element(1, Msg),
  {Mod, ModID, MothedID} = get_mod_mothed(RName),
  Bin0 = Mod:encode_msg(Msg),
  Len = byte_size(Bin0) + 4,
  <<Len:16, ModID:8, MothedID:8, Bin0/binary>>.
  
get_mod(tos, 1, 1) ->
  {test, m_login_tos};
get_mod(toc, 1, 1) ->
  {test, m_login_toc};
get_mod(_, _, _) ->
  {test, m_login_tos}.

get_mod_mothed(m_login_tos) ->
  {test, 1, 1};
get_mod_mothed(m_login_toc) ->
  {test, 1, 1};
get_mod_mothed(_) ->
  {test, 1, 1}.
