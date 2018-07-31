#	Copyright (C) 2015 Matt Booth (Kryten2k35).
# 
# 	Licensed under the Attribution-NonCommercial-ShareAlike 4.0 International 
# 	(the "License") you may not use this file except in compliance with the License.
# 	You may obtain a copy of the License at
# 
# 		http://creativecommons.org/licenses/by-nc-sa/4.0/legalcode
# 
# 	Unless required by applicable law or agreed to in writing, software
# 	distributed under the License is distributed on an "AS IS" BASIS,
#	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#	See the License for the specific language governing permissions and
#	limitations under the License.

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

ifndef TARGET_ARCH_ABI
TARGET_ARCH_ABI := armeabi-v7a
endif

# Cardview Dir
cardview_dir := ../../../frameworks/support/v7/cardview

src_dirs := src src_bypass
res_dirs := res $(chips_dir) $(cardview_dir)/res

LOCAL_SRC_FILES := $(call all-java-files-under, $(src_dirs))
LOCAL_RESOURCE_DIR := $(addprefix $(LOCAL_PATH)/, $(res_dirs))

LOCAL_AAPT_FLAGS := \
	--auto-add-overlay \
	--extra-packages com.google.android.gms \
	--extra-packages android.support.v7.cardview

LOCAL_PACKAGE_NAME := OTAUpdates

LOCAL_STATIC_JAVA_LIBRARIES := \
	RootTools \
	android-support-v4 \
	android-support-v7-cardview \

# Create $(TARGET_OUT_SHARED_LIBRARIES) if not already exists,
# hence prevent build errors.
$(shell mkdir -p $(TARGET_OUT_SHARED_LIBRARIES))
$(shell cp $(LOCAL_PATH)/libs/$(TARGET_ARCH_ABI)/libbypass.so $(TARGET_OUT_SHARED_LIBRARIES))

LOCAL_JNI_SHARED_LIBRARIES := libs/$(TARGET_ARCH_ABI)/libbypass

LOCAL_CERTIFICATE := platform

LOCAL_PRIVILEGED_MODULE := true

LOCAL_PROGUARD_ENABLED := disabled

include $(BUILD_PACKAGE)

include $(CLEAR_VARS)

LOCAL_PREBUILT_STATIC_JAVA_LIBRARIES := \
libs/RootTools.jar \

include $(BUILD_MULTI_PREBUILT)
