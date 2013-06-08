#
# Copyright (C) 2011 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

## (2) Also get non-open-source specific aspects if available
$(call inherit-product-if-exists, vendor/samsung/sc06d/sc06d-vendor.mk)

## overlays
DEVICE_PACKAGE_OVERLAYS += device/samsung/sc06d/overlay

# Inherit from d2-common
$(call inherit-product, device/samsung/d2-common/d2-common.mk)

$(call inherit-product-if-exists, vendor/samsung/sc06d/sc06d-vendor.mk)


# kernel modules for ramdisk
RAMDISK_MODULES = $(addprefix device/samsung/sc06d/,btlock.ko dhd.ko evbug.ko gspca_main.ko qce40.ko qcedev.ko qcrypto.ko scsi_wait_scan.ko spidev.ko)

#PRODUCT_COPY_FILES += $(foreach module,\
#        $(RAMDISK_MODULES),\
#        $(module):root/lib/modules/$(notdir $(module)))

PRODUCT_COPY_FILES += $(foreach module,\
        $(RAMDISK_MODULES),\
        $(module):system/lib/modules/$(notdir $(module)))

# other kernel modules not in ramdisk
# PRODUCT_COPY_FILES += $(foreach module,\
#         $(filter-out $(RAMDISK_MODULES),$(wildcard device/samsung/sc06d/*.ko)),\
#         $(module):system/lib/modules/$(notdir $(module)))

ifeq ($(TARGET_PREBUILT_KERNEL),)
    LOCAL_KERNEL := device/samsung/sc06d/kernel
else
    LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel
