// ignore_for_file: file_names

import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('ne'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'ne':
        return '🇳🇵';
      case 'en':
        return '🇱🇷';
      default:
        return '🇱🇷';
    }
  }
}
