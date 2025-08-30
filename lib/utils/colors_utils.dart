import 'package:flutter/material.dart';

Color colorFromCode(int code) {
  const int alpha = 255;
  final int r = (code >> 16) & 0xFF;
  final int g = (code >> 8) & 0xFF;
  final int b = code & 0xFF;

  return Color.fromARGB(alpha, r, g, b);
}

// After comaparing between LCG(Linear Congruential Generator) and
// Bit Manipulation Shuffle to avoid memory issues,i decided to use
// LCG formula for pseudo-random generator to avoid repeated colors
// where Bit Manipulation Shuffle can lead to repeated colors.
int nextColorCode(int currentColor) {
  // LCG formula (current * multiplier + increment) % modulus
  const int multiplier = 1664525;
  const int increment = 1013904223;
  const int modulus = 16777216;

  return (currentColor * multiplier + increment) % modulus;
}
