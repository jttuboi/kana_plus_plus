// ignore_for_file: one_member_abstracts

import 'package:flutter/material.dart';

abstract class IStrokeReducer {
  List<Offset> reduce(List<Offset> stroke);
}
