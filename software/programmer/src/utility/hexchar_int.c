/*
 * hexchar_int.c
 *
 *  Created on: 2018/05/25
 *      Author: yoshiaki
 */


#include "hexchar_int.h"

int hexchar_to_int(const char c) {
  int value;
  switch (c) {
    case '0': value = 0x00; break;
    case '1': value = 0x01; break;
    case '2': value = 0x02; break;
    case '3': value = 0x03; break;
    case '4': value = 0x04; break;
    case '5': value = 0x05; break;
    case '6': value = 0x06; break;
    case '7': value = 0x07; break;
    case '8': value = 0x08; break;
    case '9': value = 0x09; break;
    case 'A': value = 0x0A; break;
    case 'B': value = 0x0B; break;
    case 'C': value = 0x0C; break;
    case 'D': value = 0x0D; break;
    case 'E': value = 0x0E; break;
    case 'F': value = 0x0F; break;
    default : value = HEX_CONVERTING_ERR; break;
  }
  return value;
}

int hex2chars_to_int(const char c0, const char c1) {
  const int v0 = hexchar_to_int(c0);
  const int v1 = hexchar_to_int(c1);

  if (v0 == HEX_CONVERTING_ERR || v1 == HEX_CONVERTING_ERR) {
    return HEX_CONVERTING_ERR;
  }

  return (v0 << 4) + v1;
}

int hex4chars_to_int(const char c0, const char c1, const char c2, const char c3) {
  const int v0 = hex2chars_to_int(c0, c1);
  const int v1 = hex2chars_to_int(c2, c3);

  if (v0 == HEX_CONVERTING_ERR || v1 == HEX_CONVERTING_ERR) {
    return HEX_CONVERTING_ERR;
  }

  return (v0 << 8) + v1;
}

char hex_nth_digit(const int number, const int nth) {
  const char nth_digit = (char)((number >> (nth * 4)) & 0xF);
  char hex;

  switch (nth_digit) {
    case 0x0: hex = '0'; break;
    case 0x1: hex = '1'; break;
    case 0x2: hex = '2'; break;
    case 0x3: hex = '3'; break;
    case 0x4: hex = '4'; break;
    case 0x5: hex = '5'; break;
    case 0x6: hex = '6'; break;
    case 0x7: hex = '7'; break;
    case 0x8: hex = '8'; break;
    case 0x9: hex = '9'; break;
    case 0xA: hex = 'A'; break;
    case 0xB: hex = 'B'; break;
    case 0xC: hex = 'C'; break;
    case 0xD: hex = 'D'; break;
    case 0xE: hex = 'E'; break;
    case 0xF: hex = 'F'; break;
    default:  hex = 'x'; break;
  }

  return hex;
}
