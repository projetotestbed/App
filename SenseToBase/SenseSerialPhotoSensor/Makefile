COMPONENT=SenseSerialAppC
BUILD_EXTRA_DEPS += SenseSerial.class
CLEAN_EXTRA = *.class SenseSerialMsg.java

CFLAGS += -I$(TOSDIR)/lib/T2Hack

SenseSerial.class: $(wildcard *.java) SenseSerialMsg.java
	javac -target 1.4 -source 1.4 *.java

SenseSerialMsg.java:
	mig java -target=null $(CFLAGS) -java-classname=SenseSerialMsg SenseSerial.h sense_serial_msg -o $@


include $(MAKERULES)

