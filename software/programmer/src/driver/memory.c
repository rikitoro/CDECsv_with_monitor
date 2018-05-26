/*
 * memory.c
 *
 *  Created on: 2018/05/25
 *      Author: yoshiaki
 */


#include "system.h"
#include "altera_avalon_pio_regs.h"

#include "memory.h"

void assert_prg_we() {
  IOWR_ALTERA_AVALON_PIO_DATA(PRG_WE_BASE, 1);
};

void negate_prg_we() {
  IOWR_ALTERA_AVALON_PIO_DATA(PRG_WE_BASE, 0);
};

void assert_prg_clock() {
  IOWR_ALTERA_AVALON_PIO_DATA(PRG_CLOCK_BASE, 1);
};

void negate_prg_clock() {
  IOWR_ALTERA_AVALON_PIO_DATA(PRG_CLOCK_BASE, 0);
};

////////
void memory_wd(const char addr, const char data) {
  IOWR_ALTERA_AVALON_PIO_DATA(PRG_MA_BASE, addr);
  IOWR_ALTERA_AVALON_PIO_DATA(PRG_WD_BASE, data);
  assert_prg_we();
  assert_prg_clock();
  negate_prg_clock();
  negate_prg_we();
}

char memory_rd(const char addr) {
  IOWR_ALTERA_AVALON_PIO_DATA(PRG_MA_BASE, addr);
  assert_prg_clock();
  negate_prg_clock();
  return (char)IORD_ALTERA_AVALON_PIO_DATA(PRG_RD_BASE);
}
