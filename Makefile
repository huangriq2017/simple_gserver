.PHONY: all compile clean build_plt dialyze

REBAR=./rebar

all:
	${REBAR} -j 8 compile

check:
	${REBAR} -vvv -j 8 compile

compile:
	${REBAR} dialyze
	${REBAR} compile

clean:
	${REBAR} clean

build-plt:
	${REBAR} build-plt

dialyze:
	${REBAR} dialyze
