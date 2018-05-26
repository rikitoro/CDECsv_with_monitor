/*
 * hexformat.h
 *
 *  Created on: 2018/05/25
 *      Author: yoshiaki
 */

#ifndef UTILITY_HEXFORMAT_H_
#define UTILITY_HEXFORMAT_H_

int bytecount_of_hexformat(const char* hf);
int address_of_hexformat(const char* hf);
int recordtype_of_hexformat(const char* hf);
char data_of_hexformat(const char* hf, const int n);
char checksum_of_hexformat(const char* hf);


#endif /* UTILITY_HEXFORMAT_H_ */
