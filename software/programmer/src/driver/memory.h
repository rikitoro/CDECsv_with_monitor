/*
 * memory.h
 *
 *  Created on: 2018/05/25
 *      Author: yoshiaki
 */

#ifndef DRIVER_MEMORY_H_
#define DRIVER_MEMORY_H_

void assert_prg_clk();
void negate_prg_clk();
void assert_prg_we();
void negate_prg_we();
char memory_rd(const char addr);
void memory_wd(const char addr, char data);

#endif /* DRIVER_MEMORY_H_ */
