ARCHS = armv7 arm64
include theos/makefiles/common.mk

TWEAK_NAME = ForcePinyin10
ForcePinyin10_FILES = Tweak.xm
ForcePinyin10_LDFLAGS= -lsubstrate -lz -L.

include $(THEOS_MAKE_PATH)/tweak.mk
