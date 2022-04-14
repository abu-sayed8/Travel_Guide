import 'package:flutter/material.dart';

InputDecoration FormDecoration = InputDecoration(
  // ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: 3,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: 3,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 3,
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
    color: Colors.red,
    width: 3,
  )),
  fillColor: Colors.white,
  filled: true,
);
