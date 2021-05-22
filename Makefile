TWEAK_NAME = PnamuLove

TARGET := iphone:clang:latest
INSTALL_TARGET_PROCESSES = SpringBoard hearthstone

export ARCHS=arm64 arm64e
include $(THEOS)/makefiles/common.mk

$(TWEAK_NAME)_FILES = $(wildcard sources/*.x) $(wildcard sources/*.m)
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -Wno-unused-variable -Wno-unused-function -I$(THEOS_PROJECT_DIR)/headers
$(TWEAK_NAME)_FRAMEWORKS = UIKit CoreGraphics

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += PnamuLoveCCModule
include $(THEOS_MAKE_PATH)/aggregate.mk
