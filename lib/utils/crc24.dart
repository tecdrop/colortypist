// Copyright 2020-2022 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.
//
// Adapted from [CRC24.java](https://github.com/bcgit/bc-java/blob/master/pg/src/main/java/org/bouncycastle/bcpg/CRC24.java)
// by Bouncy Castle.

/// Default, iterative CRC-24 implementation as described in RFC4880.
class CRC24 {
  static const int _crc24Init = 0x0b704ce;
  static const int _crc24Poly = 0x1864cfb;
  static const int _crc24OutMask = 0xffffff;

  /// The current CRC-24 value.
  int _crc = _crc24Init;

  /// Updates the CRC-24 checksum with the given byte.
  void update(int b) {
    _crc ^= b << 16;
    for (int i = 0; i < 8; i++) {
      _crc <<= 1;
      if ((_crc & 0x1000000) != 0) {
        _crc ^= _crc24Poly;
      }
    }
  }

  /// Returns the CRC-24 checksum value.
  int getValue() {
    return _crc & _crc24OutMask;
  }

  /// Resets the CRC-24 checksum to its initial value.
  void reset() {
    _crc = _crc24Init;
  }
}
