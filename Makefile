CC = gcc
CXX = g++
JAVAC = javac
GO = go
CSC = mcs
OUTDIR = bin
TARGET = helloWorld

# Scripting languages

run-js: compile-js
	node $(OUTDIR)/$(TARGET).js

compile-js: $(OUTDIR)/$(TARGET).js

$(OUTDIR)/$(TARGET).js: $(TARGET).js
	cp $(TARGET).js $@

run-py: compile-py

compile-py: $(OUTDIR)/$(TARGET).py

$(OUTDIR)/$(TARGET).py: $(TARGET).py
	cp $(TARGET).py $@

run-r: compile-r
	Rscript --vanilla $(OUTDIR)/$(TARGET).R

compile-r: $(OUTDIR)/$(TARGET).R

$(OUTDIR)/$(TARGET).R: $(TARGET).R
	cp $(TARGET).R $@

run-sh: compile-sh
	$(OUTDIR)/$(TARGET).sh

compile-sh: $(OUTDIR)/$(TARGET).sh

$(OUTDIR)/$(TARGET).sh: $(TARGET).sh
	cp $(TARGET).sh $@

# Compiled languages

run-c: compile-c
	$(OUTDIR)/$(TARGET)-c

compile-c: $(OUTDIR)/$(TARGET)-c

$(OUTDIR)/$(TARGET)-c: $(TARGET).c
	$(CC) -o $@ $(TARGET).c

run-cpp: compile-cpp
	$(OUTDIR)/$(TARGET)-cpp

compile-cpp: $(OUTDIR)/$(TARGET)-cpp

$(OUTDIR)/$(TARGET)-cpp: $(TARGET).cpp
	$(CXX) -o $@ $(TARGET).cpp

run-cs: compile-cs
	$(OUTDIR)/$(TARGET)-cs

compile-cs: $(OUTDIR)/$(TARGET)-cs

$(OUTDIR)/$(TARGET)-cs: $(TARGET).cs
	$(CSC) -out:$(OUTDIR)/$(TARGET)-cs $(TARGET).cs

run-go: compile-go
	$(OUTDIR)/$(TARGET)-go

compile-go: $(OUTDIR)/$(TARGET)-go

$(OUTDIR)/$(TARGET)-go: $(TARGET).go
	$(GO) build -o $@ $(TARGET).go

run-java: compile-java
	java -jar $(OUTDIR)/$(TARGET).jar

compile-java: $(OUTDIR)/$(TARGET).jar

$(OUTDIR)/$(TARGET).jar: $(TARGET).java
	mkdir -p $(OUTDIR)/java-class
	$(JAVAC) -d $(OUTDIR)/java-class $(TARGET).java
	jar -cfe $@ Program -C $(OUTDIR)/java-class .

run-rs: compile-rs
	$(OUTDIR)/$(TARGET)-rs

compile-rs: $(OUTDIR)/$(TARGET)-rs

$(OUTDIR)/$(TARGET)-rs: $(TARGET).rs
	rustc -o $@ $(TARGET).rs

compile-all: compile-c compile-cpp compile-cs compile-go compile-java compile-js compile-py compile-r compile-rs compile-sh

clean:
	rm -rf bin/java-class
	if [ "$(wildcard bin/helloWorld-* )" ]; then rm -rf $(wildcard bin/helloWorld-*); fi
	if [ "$(wildcard bin/helloWorld.* )" ]; then rm -rf $(wildcard bin/helloWorld.*); fi