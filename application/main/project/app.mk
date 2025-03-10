PROJECT_NAME     := ble_app_hids_keyboard
TARGETS          := nrf52_kbd

ifndef OUTPUT_DIRECTORY
	OUTPUT_DIRECTORY := _build
endif

ifndef TEMPLATE_PATH
	TEMPLATE_PATH := $(ROOT_DIR)/template
endif

ifeq ($(NRF_CHIP), nrf52810)
	include $(APP_PROJ_DIR)/nrf52810.mk
else ifeq ($(NRF_CHIP), nrf52811)
	include $(APP_PROJ_DIR)/nrf52811.mk
else ifeq ($(NRF_CHIP), nrf52832)
	include $(APP_PROJ_DIR)/nrf52832.mk
else
	$(error cannot handle NRF_CHIP [$(NRF_CHIP)])
endif

ifndef NRF_PACKAGE_NAME
	NRF_PACKAGE_NAME := $(OUTPUT_DIRECTORY)/nrf52_kbd_$(VERSION).zip
endif

ifndef NRF_MERGE_SIGN_NAME
	NRF_MERGE_SIGN_NAME := $(OUTPUT_DIRECTORY)/nrf52_kbd_sign.hex
endif

ifndef NRF_MERGE_SD_NAME
	NRF_MERGE_SD_NAME := $(OUTPUT_DIRECTORY)/nrf52_kbd_with_sd.hex
endif

ifndef NRF_MERGE_SIGN_SD_NAME
	NRF_MERGE_SIGN_SD_NAME := $(OUTPUT_DIRECTORY)/nrf52_kbd_sign_with_sd.hex
endif

ifndef NRF_MERGE_ALL_NAME
	NRF_MERGE_ALL_NAME := $(OUTPUT_DIRECTORY)/nrf52_all.hex
endif

$(OUTPUT_DIRECTORY)/nrf52_kbd.out: \
	LINKER_SCRIPT  := $(APP_PROJ_DIR)/$(LD_NAME)

# Source files common to all targets
SRC_FILES += \
	$(SDK_ROOT)/components/libraries/util/app_error.c \
	$(SDK_ROOT)/components/libraries/util/app_error_handler_gcc.c \
	$(SDK_ROOT)/components/libraries/util/app_error_weak.c \
	$(SDK_ROOT)/components/libraries/scheduler/app_scheduler.c \
  $(SDK_ROOT)/components/libraries/timer/app_timer2.c \
	$(SDK_ROOT)/components/libraries/util/app_util_platform.c \
	$(SDK_ROOT)/components/libraries/crc16/crc16.c \
  $(SDK_ROOT)/components/libraries/timer/drv_rtc.c \
	$(SDK_ROOT)/components/libraries/fds/fds.c \
	$(SDK_ROOT)/components/libraries/hardfault/hardfault_implementation.c \
	$(SDK_ROOT)/components/libraries/util/nrf_assert.c \
	$(SDK_ROOT)/components/libraries/atomic_fifo/nrf_atfifo.c \
	$(SDK_ROOT)/components/libraries/atomic_flags/nrf_atflags.c \
	$(SDK_ROOT)/components/libraries/atomic/nrf_atomic.c \
	$(SDK_ROOT)/components/libraries/balloc/nrf_balloc.c \
	$(SDK_ROOT)/external/fprintf/nrf_fprintf.c \
	$(SDK_ROOT)/external/fprintf/nrf_fprintf_format.c \
	$(SDK_ROOT)/components/libraries/fstorage/nrf_fstorage.c \
	$(SDK_ROOT)/components/libraries/fstorage/nrf_fstorage_sd.c \
	$(SDK_ROOT)/components/libraries/memobj/nrf_memobj.c \
	$(SDK_ROOT)/components/libraries/pwr_mgmt/nrf_pwr_mgmt.c \
	$(SDK_ROOT)/components/libraries/ringbuf/nrf_ringbuf.c \
	$(SDK_ROOT)/components/libraries/experimental_section_vars/nrf_section_iter.c \
  $(SDK_ROOT)/components/libraries/sortlist/nrf_sortlist.c \
	$(SDK_ROOT)/components/libraries/strerror/nrf_strerror.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_svci.c \
	$(SDK_ROOT)/components/libraries/low_power_pwm/low_power_pwm.c \
	$(SDK_ROOT)/components/libraries/uart/app_uart_fifo.c \
	$(SDK_ROOT)/components/libraries/fifo/app_fifo.c \
	$(SDK_ROOT)/integration/nrfx/legacy/nrf_drv_uart.c \
	$(SDK_ROOT)/modules/nrfx/soc/nrfx_atomic.c \
	$(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_clock.c \
	$(SDK_ROOT)/modules/nrfx/drivers/src/prs/nrfx_prs.c \
	$(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_saadc.c \
	$(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_wdt.c \
	$(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_uart.c \
	$(APP_SRC_DIR)/main.c \
	$(APP_SRC_DIR)/ble/ble_services.c \
	$(APP_SRC_DIR)/ble/ble_hid_service.c \
	$(APP_SRC_DIR)/ble/ble_bas_service.c \
	$(SDK_ROOT)/external/segger_rtt/SEGGER_RTT.c \
	$(SDK_ROOT)/external/segger_rtt/SEGGER_RTT_Syscalls_GCC.c \
	$(SDK_ROOT)/external/segger_rtt/SEGGER_RTT_printf.c \
	$(SDK_ROOT)/components/ble/peer_manager/auth_status_tracker.c \
	$(SDK_ROOT)/components/ble/common/ble_advdata.c \
	$(SDK_ROOT)/components/ble/ble_advertising/ble_advertising.c \
	$(SDK_ROOT)/components/ble/common/ble_conn_params.c \
	$(SDK_ROOT)/components/ble/common/ble_conn_state.c \
	$(SDK_ROOT)/components/ble/ble_link_ctx_manager/ble_link_ctx_manager.c \
	$(SDK_ROOT)/components/ble/common/ble_srv_common.c \
	$(SDK_ROOT)/components/ble/peer_manager/gatt_cache_manager.c \
	$(SDK_ROOT)/components/ble/peer_manager/gatts_cache_manager.c \
	$(SDK_ROOT)/components/ble/peer_manager/id_manager.c \
	$(SDK_ROOT)/components/ble/nrf_ble_gatt/nrf_ble_gatt.c \
	$(SDK_ROOT)/components/ble/nrf_ble_qwr/nrf_ble_qwr.c \
	$(SDK_ROOT)/components/ble/peer_manager/peer_data_storage.c \
	$(SDK_ROOT)/components/ble/peer_manager/peer_database.c \
	$(SDK_ROOT)/components/ble/peer_manager/peer_id.c \
	$(SDK_ROOT)/components/ble/peer_manager/peer_manager.c \
	$(SDK_ROOT)/components/ble/peer_manager/peer_manager_handler.c \
	$(SDK_ROOT)/components/ble/peer_manager/pm_buffer.c \
	$(SDK_ROOT)/components/ble/peer_manager/security_dispatcher.c \
	$(SDK_ROOT)/components/ble/peer_manager/security_manager.c \
	$(SDK_ROOT)/components/ble/ble_services/ble_bas/ble_bas.c \
	$(SDK_ROOT)/components/ble/ble_services/ble_dis/ble_dis.c \
	$(SDK_ROOT)/components/ble/ble_services/ble_hids/ble_hids.c \
	$(SDK_ROOT)/components/ble/ble_services/ble_dfu/ble_dfu.c \
	$(SDK_ROOT)/components/ble/ble_services/ble_dfu/ble_dfu_bonded.c \
	$(SDK_ROOT)/components/ble/ble_services/ble_dfu/ble_dfu_unbonded.c \
	$(SDK_ROOT)/components/softdevice/common/nrf_sdh.c \
	$(SDK_ROOT)/components/softdevice/common/nrf_sdh_ble.c \
	$(SDK_ROOT)/components/softdevice/common/nrf_sdh_soc.c \

# Include folders common to all targets
INC_FOLDERS += \
	$(SDK_ROOT)/components/libraries/pwm \
	$(SDK_ROOT)/modules/nrfx/hal \
	$(SDK_ROOT)/components/libraries/log \
	$(SDK_ROOT)/components/libraries/fstorage \
	$(SDK_ROOT)/components/libraries/mutex \
	$(SDK_ROOT)/components/libraries/gpiote \
	$(SDK_ROOT)/components/libraries/bootloader/ble_dfu \
	$(SDK_ROOT)/components/ble/ble_advertising \
	$(SDK_ROOT)/components/ble/ble_services/ble_bas_c \
	$(SDK_ROOT)/modules/nrfx/drivers/include \
	$(SDK_ROOT)/components/libraries/experimental_task_manager \
	$(SDK_ROOT)/components/libraries/queue \
	$(SDK_ROOT)/components/libraries/pwr_mgmt \
	$(SDK_ROOT)/components/toolchain/cmsis/include \
	$(SDK_ROOT)/components/ble/common \
	$(SDK_ROOT)/components/ble/ble_services/ble_bas \
	$(SDK_ROOT)/components/libraries/mpu \
	$(SDK_ROOT)/components/libraries/experimental_section_vars \
	$(SDK_ROOT)/components/libraries/slip \
	$(SDK_ROOT)/components/libraries/delay \
	$(SDK_ROOT)/components/libraries/csense_drv \
	$(SDK_ROOT)/components/libraries/memobj \
	$(SDK_ROOT)/components/libraries/bootloader \
	$(SDK_ROOT)/components/libraries/bootloader/dfu \
	$(SDK_ROOT)/components/libraries/bootloader/ble_dfu \
	$(SDK_ROOT)/components/libraries/low_power_pwm \
	$(SDK_ROOT)/components/softdevice/common \
	$(SDK_ROOT)/components/libraries/low_power_pwm \
	$(SDK_ROOT)/components/ble/ble_services/ble_dfu \
	$(SDK_ROOT)/external/fprintf \
	$(SDK_ROOT)/components/libraries/svc \
	$(SDK_ROOT)/components/libraries/atomic \
	$(SDK_ROOT)/components \
	$(SDK_ROOT)/components/libraries/scheduler \
	$(SDK_ROOT)/components/libraries/cli \
	$(SDK_ROOT)/components/libraries/crc16 \
	$(SDK_ROOT)/components/libraries/util \
	$(APP_SRC_DIR)/config \
	$(APP_SRC_DIR) \
	$(SDK_ROOT)/components/libraries/csense \
	$(SDK_ROOT)/components/libraries/balloc \
	$(SDK_ROOT)/components/libraries/ecc \
	$(SDK_ROOT)/components/libraries/hardfault \
	$(SDK_ROOT)/components/libraries/hci \
	$(SDK_ROOT)/components/libraries/timer \
	$(SDK_ROOT)/components/libraries/uart \
	$(SDK_ROOT)/components/libraries/fifo \
	$(SDK_ROOT)/integration/nrfx \
	$(SDK_ROOT)/components/libraries/sortlist \
	$(SDK_ROOT)/components/libraries/spi_mngr \
	$(SDK_ROOT)/components/libraries/led_softblink \
	$(SDK_ROOT)/modules/nrfx/mdk \
	$(SDK_ROOT)/components/ble/ble_link_ctx_manager \
	$(SDK_ROOT)/components/ble/ble_services/ble_hids \
	$(SDK_ROOT)/components/libraries/strerror \
	$(SDK_ROOT)/components/libraries/crc32 \
	$(SDK_ROOT)/components/ble/peer_manager \
	$(SDK_ROOT)/components/libraries/mem_manager \
	$(SDK_ROOT)/components/libraries/ringbuf \
	$(SDK_ROOT)/components/ble/ble_services/ble_tps \
	$(SDK_ROOT)/components/ble/ble_services/ble_dis \
	$(SDK_ROOT)/components/ble/nrf_ble_gatt \
	$(SDK_ROOT)/components/ble/nrf_ble_qwr \
	$(SDK_ROOT)/modules/nrfx \
	$(SDK_ROOT)/integration/nrfx/legacy \
	$(SDK_ROOT)/external/segger_rtt \
	$(SDK_ROOT)/components/libraries/atomic_fifo \
	$(SDK_ROOT)/components/libraries/crypto \
	$(SDK_ROOT)/components/ble/ble_racp \
	$(SDK_ROOT)/components/libraries/fds \
	$(SDK_ROOT)/components/libraries/atomic_flags \
	$(SDK_ROOT)/components/libraries/stack_guard \
	$(SDK_ROOT)/components/libraries/log/src \

# Libraries common to all targets
LIB_FILES += \

# Optimization flags
ifeq (yes,$(strip $(DEBUG)))
    OPT_DEFS += -DDEBUG
	OPT = -O1
else
	OPT = -Os -g3
endif
# Uncomment the line below to enable link time optimization
#OPT += -flto
OPT += $(OPT_DEFS)

# C flags common to all targets
CFLAGS += $(OPT)
CFLAGS += -DAPP_TIMER_V2
CFLAGS += -DAPP_TIMER_V2_RTC1_ENABLED
CFLAGS += -DNRF52_APP
CFLAGS += -DNRFX_COREDEP_DELAY_US_LOOP_CYCLES=3
CFLAGS += -DNRF_DFU_SVCI_ENABLED
CFLAGS += -DNRF_DFU_TRANSPORT_BLE=1
CFLAGS += -DNRF_SD_BLE_API_VERSION=7
CFLAGS += -DSOFTDEVICE_PRESENT
CFLAGS += -DUSE_CUSTOM_CONFIG
CFLAGS += -mcpu=cortex-m4
CFLAGS += -mthumb -mabi=aapcs
CFLAGS += -Wall -Werror
# keep every function in a separate section, this allows linker to discard unused ones
CFLAGS += -ffunction-sections -fdata-sections -fno-strict-aliasing
CFLAGS += -fno-builtin -fshort-enums
ifdef CONFIG_H
	 CFLAGS += -DCONFIG_H_FILE=\"$(CONFIG_H)\"
#    CFLAGS += -include $(CONFIG_H)
endif

# C++ flags common to all targets
CXXFLAGS += $(OPT)

# Assembler flags common to all targets
ASMFLAGS += -g3
ASMFLAGS += -mcpu=cortex-m4
ASMFLAGS += -mthumb -mabi=aapcs
ASMFLAGS += -DAPP_TIMER_V2
ASMFLAGS += -DAPP_TIMER_V2_RTC1_ENABLED
ASMFLAGS += -DNRF52_PAN_74
ASMFLAGS += -DNRFX_COREDEP_DELAY_US_LOOP_CYCLES=3
ASMFLAGS += -DNRF_DFU_SVCI_ENABLED
ASMFLAGS += -DNRF_DFU_TRANSPORT_BLE=1
ASMFLAGS += -DNRF_SD_BLE_API_VERSION=7
ASMFLAGS += -DSOFTDEVICE_PRESENT
ASMFLAGS += -DUSE_CUSTOM_CONFIG
ifdef CONFIG_H
#    ASFLAGS += -include $(CONFIG_H)
endif

ifeq ($(SOFTDEVICE), S112)
	CFLAGS += -DS112
	ASMFLAGS += -DS112
	SOFTDEVICE_NAME := s112_nrf52_7.2.0_softdevice.hex
	SOFTDEVICE_VER  := 0x103
ifndef SOFTDEVICE_PATH
	SOFTDEVICE_PATH := $(SDK_ROOT)/components/softdevice/s112/hex/s112_nrf52_7.2.0_softdevice.hex
endif
    INC_FOLDERS += \
		$(SDK_ROOT)/components/softdevice/s112/headers/nrf52 \
		$(SDK_ROOT)/components/softdevice/s112/headers

else ifeq ($(SOFTDEVICE), S132)
	CFLAGS += -DS132
	ASMFLAGS += -DS132
	SOFTDEVICE_NAME := s112_nrf52_7.2.0_softdevice.hex
	SOFTDEVICE_VER  := 0x101
ifndef SOFTDEVICE_PATH
	SOFTDEVICE_PATH := $(SDK_ROOT)/components/softdevice/s132/hex/s132_nrf52_7.2.0_softdevice.hex
endif
	INC_FOLDERS += \
		$(SDK_ROOT)/components/softdevice/s132/headers/nrf52 \
		$(SDK_ROOT)/components/softdevice/s132/headers

else
	$(error cannot handle softdevice [$(SOFTDEVICE)])
endif

# Linker flags
LDFLAGS += $(OPT)
LDFLAGS += -mthumb -mabi=aapcs -L$(SDK_ROOT)/modules/nrfx/mdk -T$(LINKER_SCRIPT)
LDFLAGS += -mcpu=cortex-m4
# let linker dump unused sections
LDFLAGS += -Wl,--gc-sections
# use newlib in nano version
LDFLAGS += --specs=nano.specs

nrf52_kbd: CFLAGS += -D__HEAP_SIZE=$(HEAP_SIZE)
nrf52_kbd: CFLAGS += -D__STACK_SIZE=$(STACK_SIZE)
nrf52_kbd: ASMFLAGS += -D__HEAP_SIZE=$(HEAP_SIZE)
nrf52_kbd: ASMFLAGS += -D__STACK_SIZE=$(STACK_SIZE)

# Add standard libraries at the very end of the linker input, after all objects
# that may need symbols provided by these libraries.
LIB_FILES += -lc -lnosys -lm

.PHONY: default help

# Default target - first one defined
default: nrf52_kbd

# Print all targets that can be built
help:
	@echo following targets are available:
	@echo		nrf52_kbd           - default： build KBD firmware
	@echo		setting             - generate dfu setting
	@echo		bootloader          - build BootLoader firmware
	@echo		package             - pack firmware for DFU
	@echo		all                 - merge bootloader softdevice and dfu setting with application
	@echo		erase               - erase the chip
	@echo		merge_setting       - merge dfu setting with application
	@echo		merge_softdevice    - merge softdevice with application
	@echo		flash               - Flashing KBD firmware
	@echo		flash_setting       - Flashing KBD firmware and dfu setting
	@echo		flash_bootloader    - Flashing bootloader
	@echo		flash_softdevice    - Flashing softdevice
	@echo		flash_all           - Flashing bootloader softdevice and application with dfu setting
	@echo		whole               - make all keyboards firmware in the keyboard folder
	@echo All targets starts with "flash" could has prefix "pyocd_" or "openocd", which \
	means use pyocd  or openocd to flash chip. 


include $(TEMPLATE_PATH)/Makefile.common

$(foreach target, $(TARGETS), $(call define_target, $(target)))

.PHONY: flash setting flash_setting flash_softdevice erase pyocd_flash pyocd_flash_softdevice pyocd_erase

# Flash the program
flash: default
	@echo Flashing: $(OUTPUT_DIRECTORY)/nrf52_kbd.hex
	nrfjprog -f nrf52 --program $(OUTPUT_DIRECTORY)/nrf52_kbd.hex --sectorerase
	nrfjprog -f nrf52 --reset

pyocd_flash: default
	@echo Flashing: $(OUTPUT_DIRECTORY)/nrf52_kbd.hex
	pyocd flash -t nrf52 -e sector -f 2M $(OUTPUT_DIRECTORY)/nrf52_kbd.hex
	pyocd cmd -t nrf52 -c reset

# Generate and Flash the DFU setting
setting: default
	@echo Setting generate $(OUTPUT_DIRECTORY)/nrf52_settings.hex
	nrfutil settings generate --family $(NRF_FAMILY) --application $(OUTPUT_DIRECTORY)/nrf52_kbd.hex --application-version 1 --bootloader-version 1 --bl-settings-version 2 $(OUTPUT_DIRECTORY)/nrf52_settings.hex

flash_setting: setting
	@echo Flashing: $(OUTPUT_DIRECTORY)/nrf52_kbd.hex and $(OUTPUT_DIRECTORY)/nrf52_settings.hex
	nrfjprog -f nrf52 --program $(OUTPUT_DIRECTORY)/nrf52_kbd.hex --sectorerase
	nrfjprog -f nrf52 --program $(OUTPUT_DIRECTORY)/nrf52_settings.hex --sectorerase
	nrfjprog -f nrf52 --reset

pyocd_flash_setting: setting
	@echo Flashing: $(OUTPUT_DIRECTORY)/nrf52_kbd.hex and $(OUTPUT_DIRECTORY)/nrf52_settings.hex
	pyocd flash -t nrf52 -e sector -f 2M $(OUTPUT_DIRECTORY)/nrf52_kbd.hex
	pyocd flash -t nrf52 -e sector -f 2M $(OUTPUT_DIRECTORY)/nrf52_settings.hex
	pyocd cmd -t nrf52 -c reset

# Package DFU firmware pack
package: default
	@echo Packing: $(OUTPUT_DIRECTORY)/nrf52_kbd.hex
	nrfutil pkg generate --hw-version 52 --application-version 1 --application $(OUTPUT_DIRECTORY)/nrf52_kbd.hex \
	--sd-req $(SOFTDEVICE_VER) --key-file $(APP_PROJ_DIR)/private.key $(NRF_PACKAGE_NAME)

# Flash softdevice
flash_softdevice:
	@echo Flashing: $(SOFTDEVICE_NAME)
	nrfjprog -f nrf52 --program $(SOFTDEVICE_PATH) --sectorerase
	nrfjprog -f nrf52 --reset

pyocd_flash_softdevice:
	@echo Flashing: $(SOFTDEVICE_NAME)
	pyocd flash -t nrf52 -e sector -f 2M $(SOFTDEVICE_PATH)
	pyocd cmd -t nrf52 -c reset

# Merge Package for download
merge_setting: setting
	@echo Merging program with signature to $(NRF_MERGE_SIGN_NAME)
	mergehex -m $(OUTPUT_DIRECTORY)/nrf52_settings.hex $(OUTPUT_DIRECTORY)/nrf52_kbd.hex -o $(NRF_MERGE_SIGN_NAME)

merge_softdevice: default
	@echo Merging program and SoftDevice $(SOFTDEVICE_NAME) to $(NRF_MERGE_SD_NAME)
	mergehex -m $(SOFTDEVICE_PATH) $(OUTPUT_DIRECTORY)/nrf52_kbd.hex -o $(NRF_MERGE_SD_NAME)

all: setting bootloader
	@echo Merging program, signature, bootloader and SoftDevice $(SOFTDEVICE_NAME) to $(NRF_MERGE_ALL_NAME)
	mergehex -m $(SOFTDEVICE_PATH) $(OUTPUT_DIRECTORY)/nrf52_settings.hex $(OUTPUT_DIRECTORY)/nrf52_kbd.hex -o $(NRF_MERGE_SIGN_SD_NAME)
	mergehex -m $(OUTPUT_DIRECTORY)/$(NRF_CHIP)_bootloader.hex $(NRF_MERGE_SIGN_SD_NAME) -o $(NRF_MERGE_ALL_NAME)

flash_all: all
	@echo Flashing: $(OUTPUT_DIRECTORY)/nrf52_all.hex
	nrfjprog -f nrf52 --program $(OUTPUT_DIRECTORY)/nrf52_all.hex --sectorerase
	nrfjprog -f nrf52 --reset

pyocd_flash_all: all
	@echo Flashing: $(OUTPUT_DIRECTORY)/nrf52_all.hex
	pyocd flash -t nrf52 -e sector -f 2M $(OUTPUT_DIRECTORY)/nrf52_all.hex
	pyocd cmd -t nrf52 -c reset

openocd_flash: default
	@echo Flashing: $(OUTPUT_DIRECTORY)/nrf52_kbd.hex
	$(OCD) -f $(OCD_CFG) -c "program $(OUTPUT_DIRECTORY)/nrf52_kbd.hex verify reset exit"

openocd_flash_setting: setting
	@echo Flashing: $(OUTPUT_DIRECTORY)/nrf52_kbd.hex and $(OUTPUT_DIRECTORY)/nrf52_settings.hex
	$(OCD) -f $(OCD_CFG) -c "program $(OUTPUT_DIRECTORY)/nrf52_settings.hex verify" -c "program $(OUTPUT_DIRECTORY)/nrf52_kbd.hex verify reset exit"

openocd_flash_softdevice:
	@echo Flashing: $(SOFTDEVICE_PATH)
	$(OCD) -f $(OCD_CFG) -c "program $(SOFTDEVICE_PATH) verify reset exit"

openocd_flash_all: all
	@echo Flashing: $(OUTPUT_DIRECTORY)/nrf52_all.hex
	$(OCD) -f $(OCD_CFG) -c "program $(OUTPUT_DIRECTORY)/nrf52_all.hex verify reset exit"

# Erase chip
erase:
	nrfjprog -f nrf52 --eraseall

pyocd_erase:
	pyocd erase -t nrf52 -c

openocd_erase:
	$(OCD) -f $(OCD_CFG) -c "init; halt; nrf5 mass_erase; exit"

SDK_CONFIG_FILE := ../config/sdk_config.h
CMSIS_CONFIG_TOOL := $(SDK_ROOT)/external_tools/cmsisconfig/CMSIS_Configuration_Wizard.jar
sdk_config:
	java -jar $(CMSIS_CONFIG_TOOL) $(SDK_CONFIG_FILE)

include $(APP_PROJ_DIR)/bl.mk
