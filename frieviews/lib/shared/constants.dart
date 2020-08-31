import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white70,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white70, width: 2.0)
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.redAccent, width: 2.0)
  ),
);