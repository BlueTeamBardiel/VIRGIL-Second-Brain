# The Binary Number System

## What it is
Like a light switch that can only be ON or OFF, binary is a base-2 numbering system where every value is expressed using only two digits: 0 and 1. Each position in a binary number represents a power of 2, allowing any integer to be encoded as a sequence of bits. Eight bits form one byte, the fundamental unit of digital data storage and transmission.

## Why it matters
When analyzing a buffer overflow attack, security analysts must read raw memory dumps in hexadecimal — which is directly derived from binary. Understanding that `0xFF` equals `11111111` in binary (255 in decimal) lets an analyst recognize when a memory register has been maxed out or overwritten with a shellcode NOP sled. Without binary fluency, reading packet captures or disassembled malware is like trying to read a book without knowing the alphabet.

## Key facts
- A single **bit** is the smallest unit of data (0 or 1); 8 bits = 1 byte = values 0–255
- Binary converts to hexadecimal in groups of 4 bits (called **nibbles**): `1010` = `0xA` = decimal 10
- IP addresses are stored and processed in binary — subnetting math (CIDR notation) only makes sense in binary
- **Bitwise operations** (AND, OR, XOR, NOT) manipulate binary values directly and are critical in cryptography and network masking
- XOR (`^`) is foundational in encryption: the same key XORed twice returns the original value, making it reversible and computationally cheap

## Related concepts
[[Hexadecimal Notation]] [[Bitwise Operations]] [[IP Addressing and Subnetting]] [[Buffer Overflow]]