all: fetchmyip

CURL_AVAILABLE=$(shell pkg-config libcurl 2>&1 > /dev/null; echo $$?)
GTK_AVAILABLE=$(shell pkg-config gtk+-3.0 2>&1 > /dev/null; echo $$?)

EXTRA_CXXFLAGS=-g -O0

ifeq ($(GTK_AVAILABLE), 0)
EXTRA_LDFLAGS=$(shell pkg-config --libs-only-l gtk+-3.0)
EXTRA_CXXFLAGS+=$(shell pkg-config --cflags gtk+-3.0)
EXTRA_CXXFLAGS+=-DUSEGTK
endif

fetchmyip: fetch.cpp Makefile
ifeq ($(CURL_AVAILABLE), 1)
	$(warning You must have libcurl installed to use this application.)
	$(warning Download/install with 'apt-get install libcurl'.)
	$(error ***)
endif
	g++ -o fetchmyip fetch.cpp -lcurl $(EXTRA_CXXFLAGS) $(EXTRA_LDFLAGS)

clean:
	rm -f fetchmyip *.o core
