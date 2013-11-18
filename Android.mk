LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := LunarTools
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk

LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED
include $(BUILD_PREBUILT)

$(shell mkdir -p $(OUT)/system)
$(shell mkdir -p $(OUT)/system/bin)
$(shell cp -rf $(LOCAL_PATH)/prebuilt/* $(OUT)/system/bin/)
