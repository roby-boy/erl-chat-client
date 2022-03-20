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

Note. Below does not work
```
rebar3 escriptize
./_build/default/bin/chat_client
```