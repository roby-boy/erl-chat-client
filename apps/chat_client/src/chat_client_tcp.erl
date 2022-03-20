-module(chat_client_tcp).
-behavior(gen_server).
-export([init/1, code_change/3, handle_call/3, handle_cast/2, handle_info/2, terminate/2]).
-export([start/0, receive_data/1, send_data/1]).

start() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
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

send_data(Socket) ->
  % timer:sleep(Sl),
  % io:format("send_data ~w~n", [self()]),
  Input = io:get_line("enter> "),
  case Input of
    "close" ++ _ ->
      close(Socket);
    _ ->
      ok = gen_tcp:send(Socket, Input),
      send_data(Socket)
  end.

receive_data(Socket) ->
  % io:format("receive_data ~w~n", [self()]),
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

handle_cast(_Msg, State) -> {noreply, State}.
handle_call(_Msg, _Caller, State) -> {noreply, State}.
handle_info(_Msg, Library) -> {noreply, Library}.
terminate(_Reason, _Library) -> ok.
code_change(_OldVersion, Library, _Extra) -> {ok, Library}.
