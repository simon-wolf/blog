---
date: 2024-12-08 18:00
title: My Supernote Notes
categories: supernote
---

Confession time... I've been a software devloper for 30 years and I've never had to dig into bits and bytes until very recently when I needed to be able to parse hex-encoded binary data. I've learnt quite a lot during the process and I've decided to write some of it down so that if I ever need to do so again I have some notes to refer back to.

## Back To School

When you were taught maths at school you were probably told about handling numbers as 1s, 10, 100s, etc.

To add 123 and 345 you add the 1s, then the 10s and then the 100s:

| 100s | 10s | 1s  | 
| :--: | :-: | :-: |
| 1    | 2   | 3   |
| 0    | 6   | 5   |
| *1*  | *8* | *8* |

And if necessary you carry numbers over:

| 100s | 10s | 1s  | 
| :--: | :-: | :-: |
| 1    | 7   | 6   |
| 3    | 4   | 6   |
| *5*  | *2* | *2* |

In the 1s column the total of 6 + 6 is 12. You keep the 2 in the 1s column and move the 1 into the 10s column. The 10s column now has 7 + 4 + 1 which is 12. You keep the 2 in the 10s column and move the 1 into the 100s column which now contains 1 + 3 + 1 = 5.

The numbers you are working with are base 10 which is why each column can only hold a number from 0 to 9.

The columns are:

1
1 * 10 = 10s
10 * 10 = 100s
100 * 10 = 1000s
... and so on ...

Similarly, the value of each row can be calculated from the columns:

| 100s | 10s | 1s  | 
| :--: | :-: | :-: |
| 1    | 2   | 3   |

This represents 100 * 1, 10 * 2, and 1 * 3 which totals 123.

## Binary Numbers

Binary numbers follow the same concept but they are base 2 rather than base 10 and the only valid numbers are 0 to 1.

So the columns we work with are:

1
1 * 2 = 2s
2 * 2 = 4s
4 * 2 = 8s
8 * 2 = 16s
16 * 2 = 32s
32 * 2 = 64s
64 * 2 = 128s
... and so on ...

| 64s  | 32s  | 16s  | 8s   | 4s   | 2s   | 1s   |
| :--: | :--: | :--: | :--: | :--: | :--: | :--: |
| 1    | 1    | 1    | 1    | 0    | 1    | 1    |
,
This represents 64*1 + 32*1 + 16*1 + 8*1 + 4*0 + 2*1 + 1*1 = 123.

Therefore the binary number 1111011 represents 123.

Similarly, maths can be done in the same way it is with base 10 numbers if we can follow some simple rules:

* If the two values and any carry-over value are all zeros then the result is a zero.
* If the two values and any carry-over value only contain a single one then the result is one.
* If the two values and any carry-over value only contains two ones then the result is zero and a one is carried over.
* If the two values and a carry-over values are all ones then the result is a one and one is carried over.

|                    | 16s | 8s  | 4s  | 2s  | 1s  |
| :----------------- | :-: | :-: | :-: | :-: | :-: |
| First Number       | 0   | 1   | 1   | 1   | 0   |
| Second Number      | 0   | 1   | 1   | 0   | 0   |
| Carried-Over Value | 1   | 1   | 0   | 0   | 0   |
| Result             | *1* | *1* | *0* | *1* | *0* |
| To Carry Over      | 0   | 1   | 1   | 0   | 0   |

So, to add 123 (1111011) and 65 (1000001):

|          | 128s | 64s  | 32s  | 16s  | 8s   | 4s   | 2s   | 1s   |
| :------- | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: |
| First    | 0    | 1    | 1    | 1    | 1    | 0    | 1    | 1    |
| Second   | 0    | 1    | 0    | 0    | 0    | 0    | 0    | 1    |
| Carried  | 1    | 0    | 0    | 0    | 0    | 1    | 1    | 0    |
| Result   | *1*  | *0*  | *1*  | *1*  | *1*  | *1*  | *0*  | *0*  |
| To Carry | 0    | 1    | 0    | 0    | 0    | 0    | 1    | 1    |

## Bits and Bytes

A bit is the smallest unit in computing and it is a binary digit... a `1` or a `0`. Sound familiar?

A 'group' of bits (`1010`) is a bit string.

Eight bits is called a byte and a byte can hold a number between 0 and 255:

128*1 + 64*1 + 32*1 + 16*1 + 8*1 + 4*1 + 2*1 + 1*1 = 255

## Byte Ordering

If we want to store a number greater than 255 then we need to use 10 bits. We'll use 632 as an example:

| 512s | 256s | 128s | 64s  | 32s  | 16s  | 8s   | 4s   | 2s   | 1s   |
| :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: |
| 1    | 0    | 0    | 1    | 1    | 1    | 1    | 0    | 0    | 0    |

Those 10 bits will fit into two bytes and the remaining 6 'spaces' are filled with zeros: 00000010 01111000.

This is called a 16-bit number because, in total, it takes 16 bits to store it.

The hazard is that bytes can be ordered from left-to-right or from right-to-left. In the example above the bytes are big-endian (BE) and they go from right-to-left. If the two bytes were stored as 01111000 00000010 then they would be little-endian (LE) and they go from left to right. Note that it is only the bytes themselves that change order; the bits within the byte are always right-to-left. Knowing the byte order is very important or our 632 suddenly becomes 30,722!

## Hexidecimal Numbers

If you need to talk about the value of bytes, reading out ones and zeros is not hugely practical. You can refer to the value of each byte (120 and 2 for the value 632 as big-endian bytes) but it is also common to use the hex values instead and hex is a common binary format for transmitting data too. In hex, the big-endian version of 632 is 02 78.

Hex values are base-16:

| 0   | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8   | 9   | 10  | 11  | 12  | 13  | 14  | 15  |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| 0   | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8   | 9   | A   | B   | C   | D   | E   | F   |

16*16 is 256 which means that 00 to FF represents 0 to 255 which happens to match what a byte can store which is why hex is a great solution for representing bytes.

## Buffers




02 78





As well as referring to the contents of a byte as eight ones and zeros or as a number between 0 and 255, it is common to use hexadecimal values. These are base 16 numbers which go from 00 to FF.






Assume we need to store the number 1,000. This is more than the 255 we can store in 8 bits or a single byte so 

In early computers which were 8-bit you were out of luck because they could only work with 8-bits and therefore numbers from 0 to 255 (larger numbers could be represented but that was by adding the values of multiple 

Early computers were 8-bit meaning that they could only store numbers 

So if we assume that values used by a computer are stored in bytes then a number such as 1,000 is too big to be stored in a single byte (maximum 255):

| 512s | 256s | 128s | 64s  | 32s  | 16s  | 8s   | 4s   | 2s   | 1s   |
| ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 1    | 1    | 1    | 1    | 1    | 0    | 1    | 0    | 0    | 0    |




so it needs to be stored in more bits and therefore more bytes:



A 16-bit number adds another eight colums for 256s, 512s, 1024s, 2048s, 4096s, 8192s, 16384s, and 32768s and can therefore range from 0000000000000000 to 1111111111111111 or 0 to 65,535.

> Note that whilst w

A 32-bit number can represent a range of numbers from 0 to 4,294,967,295 and a 64-bit number can range from 0 to 18,446,744,073,709,551,615.

256
512
1024
2048
4096
8192
16384
32768


## Bytes

A group of eight bits is a byte and a byte can represent a number from 0 to 255. We saw how 188 was represented above and 255 would be:

| 128s | 64s  | 32s  | 16s  | 8s   | 4s   | 2s   | 1s   |
| ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 1    | 1    | 1    | 1    | 1    | 1    | 1    | 1    |

As you will have also guessed, the index positions of bits in a byte are numbered from 0 to 7 and go from right to left (1s to 128s).




You might also have heard about 8-bit, 16-bit, 32-bit and 64-bit computers and similarly 8-bit, 16-bit-32-bit and 64-bit numbers. These all refer to the number of bits used to 'build' numbers.

An 8-bit number uses the eight columns we used above (1s to 128s) and can therefore range from 00000000 to 11111111 or, in base 10, 0 to 255.

A 16-bit number adds another eight colums for 256s, 512s, 1024s, 2048s, 4096s, 8192s, 16384s, and 32768s and can therefore range from 0000000000000000 to 1111111111111111 or 0 to 65,535.

> Note that whilst w

A 32-bit number can represent a range of numbers from 0 to 4,294,967,295 and a 64-bit number can range from 0 to 18,446,744,073,709,551,615.

256
512
1024
2048
4096
8192
16384
32768






The order of bytes is described as being little-endian (LE) if the bytes are ordered from right to left, and big-endian (BE) if the bytes are ordered from left to right.

### An Example

Consider you have four bytes representing the numbers 17, 87, 143, 208.  



