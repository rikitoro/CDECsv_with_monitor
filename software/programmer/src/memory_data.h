/*
 * memory_data.h
 *
 *  Created on: 2018/05/25
 *      Author: yoshiaki
 */

#ifndef MEMORY_DATA_H_
#define MEMORY_DATA_H_


typedef enum{
  DATA_TYPE = 0,
  EOF_TYPE = 1
} RecordType;

typedef struct {
  int bytecount;
  int address;
  RecordType recordtype;
  char data[0x200];
} MemoryData;

// memory access
void write_memory(const MemoryData* md);
void read_memory(MemoryData* md);

// hex format string <-> memory_data
void hexformat_to_memorydata(const char* hf, MemoryData* md);
void shorthexformat_to_memorydata(const char* hf, MemoryData* md);

void memorydata_to_hexformat(const MemoryData* md, char* hf);

//
char checksum_of_memorydata(const MemoryData* md);

#endif /* MEMORY_DATA_H_ */
