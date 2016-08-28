
dtb-$(CONFIG_SEC_HEROQLTE_PROJECT) += msm8996-sec-heroqlte-r00.dtb \
			 msm8996-sec-heroqlte-r01.dtb \
			 msm8996-sec-heroqlte-r02.dtb \
			 msm8996-sec-heroqlte-r03.dtb \
			 msm8996-sec-heroqlte-r05.dtb \
			 msm8996-sec-heroqlte-r06.dtb \
			 msm8996-sec-heroqlte-r07.dtb \
			 msm8996-sec-heroqlte-r08.dtb \
			 msm8996-sec-heroq-r09.dtb \
			 msm8996-sec-heroq-r09-v3.dtb \
			 msm8996-sec-heroqlte-r10.dtb \
			 msm8996-sec-heroqlte-r11.dtb \
			 msm8996-sec-heroqlte-r13.dtb \
			 msm8996-sec-heroqlte-r15.dtb

dtb-$(CONFIG_SEC_HERO2QLTE_PROJECT) += msm8996-sec-hero2qlte-r00.dtb \
			 msm8996-sec-hero2qlte-r01.dtb \
			 msm8996-sec-hero2qlte-r02.dtb \
			 msm8996-sec-hero2qlte-r03.dtb \
			 msm8996-sec-hero2qlte-r05.dtb \
			 msm8996-sec-hero2qlte-r06.dtb \
			 msm8996-sec-hero2qlte-r07.dtb \
			 msm8996-sec-hero2qlte-r08.dtb \
			 msm8996-sec-heroq-r09.dtb \
			 msm8996-sec-heroq-r09-v3.dtb \
			 msm8996-sec-hero2qlte-r10.dtb \
			 msm8996-sec-hero2qlte-r11.dtb \
			 msm8996-sec-hero2qlte-r13.dtb \
			 msm8996-sec-hero2qlte-r15.dtb

dtb-$(CONFIG_SEC_AEROQLTE_PROJECT) += msm8996-sec-aeroqlte-r00.dtb \
			msm8996-sec-aeroqlte-r01.dtb \
			msm8996-sec-aeroqlte-r02.dtb \
			msm8996-sec-aeroqlte-r03.dtb

ifeq ($(filter y,$(CONFIG_MACH_HEROQLTE_DCM) $(CONFIG_MACH_HEROQLTE_KDI)),y)
dtb-y = msm8996-sec-heroqlte-jpn-r00.dtb \
			 msm8996-sec-heroqlte-jpn-r01.dtb \
			 msm8996-sec-heroqlte-jpn-r05.dtb \
			 msm8996-sec-heroqlte-jpn-r06.dtb \
			 msm8996-sec-heroqlte-jpn-r07.dtb \
			 msm8996-sec-heroqlte-jpn-r08.dtb \
			 msm8996-sec-heroqlte-jpn-r10.dtb \
			 msm8996-sec-heroqlte-jpn-r11.dtb \
			 msm8996-sec-heroqlte-jpn-r13.dtb \
			 msm8996-sec-heroqlte-jpn-r15.dtb
endif

ifeq ($(filter y,$(CONFIG_MACH_HERO2QLTE_DCM) $(CONFIG_MACH_HERO2QLTE_KDI)),y)
dtb-y = msm8996-sec-hero2qlte-jpn-r00.dtb \
			 msm8996-sec-hero2qlte-jpn-r01.dtb \
			 msm8996-sec-hero2qlte-jpn-r05.dtb \
			 msm8996-sec-hero2qlte-jpn-r06.dtb \
			 msm8996-sec-hero2qlte-jpn-r07.dtb \
			 msm8996-sec-hero2qlte-jpn-r08.dtb \
			 msm8996-sec-hero2qlte-jpn-r10.dtb \
			 msm8996-sec-hero2qlte-jpn-r11.dtb \
			 msm8996-sec-hero2qlte-jpn-r13.dtb \
			 msm8996-sec-hero2qlte-jpn-r15.dtb
endif

ifeq ($(filter y,$(CONFIG_MACH_HEROQLTE_CHNZC)),y)
dtb-y = msm8996-sec-heroqlte-r00.dtb \
			 msm8996-sec-heroqlte-r01.dtb \
			 msm8996-sec-heroqlte-r02.dtb \
			 msm8996-sec-heroqlte-r03.dtb \
			 msm8996-sec-heroqlte-chn-r05.dtb \
			 msm8996-sec-heroqlte-chn-r06.dtb \
			 msm8996-sec-heroqlte-chn-r07.dtb \
			 msm8996-sec-heroqlte-chn-r08.dtb \
			 msm8996-sec-heroq-r09.dtb \
			 msm8996-sec-heroq-r09-v3.dtb \
			 msm8996-sec-heroqlte-chn-r10.dtb \
			 msm8996-sec-heroqlte-chn-r11.dtb \
			 msm8996-sec-heroqlte-chn-r13.dtb \
			 msm8996-sec-heroqlte-chn-r15.dtb

endif

ifeq ($(filter y,$(CONFIG_MACH_HERO2QLTE_CHNZC)),y)
dtb-y = msm8996-sec-hero2qlte-r00.dtb \
			 msm8996-sec-hero2qlte-r01.dtb \
			 msm8996-sec-hero2qlte-r02.dtb \
			 msm8996-sec-hero2qlte-r03.dtb \
			 msm8996-sec-hero2qlte-chn-r05.dtb \
			 msm8996-sec-hero2qlte-chn-r06.dtb \
			 msm8996-sec-hero2qlte-chn-r07.dtb \
			 msm8996-sec-hero2qlte-chn-r08.dtb \
			 msm8996-sec-heroq-r09.dtb \
			 msm8996-sec-heroq-r09-v3.dtb \
			 msm8996-sec-hero2qlte-chn-r10.dtb \
			 msm8996-sec-hero2qlte-chn-r11.dtb \
			 msm8996-sec-hero2qlte-chn-r13.dtb \
			 msm8996-sec-hero2qlte-chn-r15.dtb
endif

ifeq ($(CONFIG_ARM64),y)
always          := $(dtb-y)
subdir-y        := $(dts-dirs)
else
targets += dtbs
targets += $(addprefix ../, $(dtb-y))

$(obj)/../%.dtb: $(src)/%.dts FORCE
        $(call if_changed_dep,dtc)

dtbs: $(addprefix $(obj)/,$(dtb-y))
endif
clean-files := *.dtb *.reverse.dts
