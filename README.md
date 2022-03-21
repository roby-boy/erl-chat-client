Simple Chat Client
=====

Simple chat client on port 7000<br /> 
An Erlang/OTP 22 script<br /> 

Build & Launch
-----
```
erlc src/chat_client.erl
erl -noshell -s chat_client main
```

<!-- Note. Below does not work
```
rebar3 escriptize
./_build/default/bin/chat_client
``` -->

Client Commands
-----
Type whatever you want.<br />
The commands interpreted from the server are described at [server page](https://github.com/roby-boy/erl-chat-server/).<br />
To exit from the client type "close".