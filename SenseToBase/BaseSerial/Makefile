COMPONENT=BaseSerialAppC
BUILD_EXTRA_DEPS += BaseSerial.class
CLEAN_EXTRA = *.class BaseSerialMsg.java

CFLAGS += -I$(TOSDIR)/lib/T2Hack

BaseSerial.class: $(wildcard *.java) BaseSerialMsg.java
	javac -target 1.4 -source 1.4 *.java

BaseSerialMsg.java:
	mig java -target=null $(CFLAGS) -java-classname=BaseSerialMsg BaseSerial.h base_serial_msg -o $@


include $(MAKERULES)

