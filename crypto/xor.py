#!/usr/bin/env python3
import sys

if len(sys.argv) != 3:
	print(f'Usage: {sys.argv[0]} str1 str2')

str1 = bytearray.fromhex(sys.argv[1])
str2 = bytearray.fromhex(sys.argv[2])

xor = [bytes([l ^ r]) for l, r in zip(str1, str2)]
print(b''.join(xor).hex(), end='')