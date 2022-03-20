Simple Chat Client
=====

Simple chat server on port 7000<br /> 
An Erlang/OTP 22 application<br /> 
Rebar3 project

Build & Launch
-----
Note. Project does not work with supervisor.
Follow instructions below.

```
cd apps/chat_client/src
erlc only_client.erl
erl -noshell -s only_client
```
