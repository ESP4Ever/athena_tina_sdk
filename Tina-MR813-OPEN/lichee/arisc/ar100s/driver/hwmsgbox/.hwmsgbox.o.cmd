cmd_driver/hwmsgbox/hwmsgbox.o := or32-elf-gcc -Wp,-MD,driver/hwmsgbox/.hwmsgbox.o.d -Wp,-MT,driver/hwmsgbox/hwmsgbox.o -Iinclude -Iinclude/driver -Iinclude/service -Iinclude/system -Ilibrary/libfdt/include -Iarch/openrisc/plat-sun50iw10p1/inc -Iservice/standby/suspend_resume/mem-sun50iw10p1/ -Iinclude/generated -include include/generated/autoconf.h -include conf.h -g -c -nostdlib -Wall -Werror -Os -mhard-mul -msoft-div -msoft-float -Idriver/hwmsgbox/ -D"BUILD_STR(s)=$(pound)s" -D"KBUILD_NAME=BUILD_STR(hwmsgbox)" -c -o driver/hwmsgbox/hwmsgbox.o driver/hwmsgbox/hwmsgbox.c

source_driver/hwmsgbox/hwmsgbox.o := driver/hwmsgbox/hwmsgbox.c

deps_driver/hwmsgbox/hwmsgbox.o := \
  include/generated/autoconf.h \
  include/generated/conf.h \
  driver/hwmsgbox/hwmsgbox_i.h \
  include/include.h \
  arch/openrisc/plat-sun50iw10p1/inc/platform_regs.h \
  arch/openrisc/plat-sun50iw10p1/inc/cpucfg_regs.h \
  arch/openrisc/plat-sun50iw10p1/inc/irqnum_config.h \
  /home/xuquan/work/aw/Tina-MR813-OPEN/lichee/arisc/ar100s/tools/toolchain/bin/../lib/gcc/or32-elf/4.5.1-or32-1.0rc4/include/stdarg.h \
  /home/xuquan/work/aw/Tina-MR813-OPEN/lichee/arisc/ar100s/tools/toolchain/bin/../lib/gcc/or32-elf/4.5.1-or32-1.0rc4/include/stddef.h \
  include/generated/autoconf.h \
  arch/openrisc/plat-sun50iw10p1/inc/platform_config.h \
  include/./types.h \
  include/./error.h \
  include/./messages.h \
  include/./system/cpu.h \
  include/./system/daemon.h \
  include/./system/debugger.h \
  include/./system/notifier.h \
  include/./system/message_manager.h \
  include/./system/para.h \
  include/./system/../driver/dram.h \
  include/./system/../driver/ir.h \
  include/./system/../driver/pmu.h \
  include/./system/../service/standby.h \
  include/./driver/prcm.h \
  include/./driver/cpucfg.h \
  include/./driver/dram.h \
  include/./driver/hwmsgbox.h \
  include/./driver/intc.h \
  include/./driver/twi.h \
  include/./driver/pin.h \
  include/./driver/pmu.h \
  include/./driver/timer.h \
  include/./driver/uart.h \
  include/./driver/watchdog.h \
  include/./service/standby.h \
  include/./service/mem_include.h \
  include/./dbgs.h \
  include/./library.h \

driver/hwmsgbox/hwmsgbox.o: $(deps_driver/hwmsgbox/hwmsgbox.o)

$(deps_driver/hwmsgbox/hwmsgbox.o):