-module(chat_client).
% -export([main/0]).
-export([main/1, main/0, send_data/1, receive_data/1]).

%% escript Entry point
main(_Args) ->
  case gen_tcp:connect("localhost", 7000, [binary, {packet, 0}]) of
    {ok, Socket} ->
      io:format("~s ~w~n", ["connetion", self()]),
      Pid_receive = spawn_link(?MODULE, receive_data, [Socket]),
      gen_tcp:controlling_process(Socket, Pid_receive),
      spawn_link(?MODULE, send_data, [Socket]),
      {ok, []};
    {error, Reason} ->
      io:format("error connetion - ~s~n", [Reason]),
      {stop, Reason}
  end.

main() -> 
  main([]).

send_data(Socket) ->
  Input = io:get_line("enter> "),
  case Input of
    "close" ++ _ ->
      close(Socket);
    _ ->
      ok = gen_tcp:send(Socket, Input),
      send_data(Socket)
  end.

receive_data(Socket) ->
  receive
    {tcp, Socket, Bin} ->
      Str = binary_to_list(Bin),
      io:format("~s", [Str]),
      receive_data(Socket);
    {tcp_closed, Socket} ->
      ok
  end.

close(Socket) ->
  ok = gen_tcp:close(Socket),
  erlang:halt().
