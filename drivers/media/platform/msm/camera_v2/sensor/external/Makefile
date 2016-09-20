ccflags-y += -Idrivers/media/platform/msm/camera_v2
ccflags-y += -Idrivers/media/platform/msm/camera_v2/common
ccflags-y += -Idrivers/media/platform/msm/camera_v2/sensor/io
ccflags-y += -Idrivers/media/platform/msm/camera_v2/sensor/cci
ccflags-y += -DEXPORT_SYMTAB

obj-$(CONFIG_SAMSUNG_OIS) += msm_ois.o
ifeq ($(SEC_BUILD_OPTION_HW_REVISION), 00)
obj-$(CONFIG_COMPANION2) += msm_companion2.o
else ifeq ($(SEC_BUILD_OPTION_HW_REVISION), 02)
obj-$(CONFIG_COMPANION3) += msm_companion3.o
else
obj-$(CONFIG_COMPANION2) += msm_companion2.o
endif
