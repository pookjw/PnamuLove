TARGET := iphone:clang:latest
export ARCHS=arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = PnamuLoveCCModule

$(BUNDLE_NAME)_BUNDLE_EXTENSION = bundle
$(BUNDLE_NAME)_CFLAGS +=  -fobjc-arc -I$(THEOS_PROJECT_DIR)/headers
$(BUNDLE_NAME)_FRAMEWORKS = UIKit CoreGraphics
$(BUNDLE_NAME)_FILES = $(wildcard sources/*.m)
$(BUNDLE_NAME)_INSTALL_PATH = /Library/ControlCenter/Bundles/

include $(THEOS_MAKE_PATH)/bundle.mk
