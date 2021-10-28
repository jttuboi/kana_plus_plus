import 'package:flutter/material.dart';
import 'package:kwriting/study/study.dart';

class StudyTableRow extends StatelessWidget {
  const StudyTableRow({List<String>? a, List<String>? i, List<String>? u, List<String>? e, List<String>? o, Key? key})
      : _a = a,
        _i = i,
        _u = u,
        _e = e,
        _o = o,
        super(key: key);

  final List<String>? _a;
  final List<String>? _i;
  final List<String>? _u;
  final List<String>? _e;
  final List<String>? _o;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.grey.shade50),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (_a != null) StudyTableContent(romaji: _a![0], kana: _a![1]),
          if (_i != null) StudyTableContent(romaji: _i![0], kana: _i![1]),
          if (_u != null) StudyTableContent(romaji: _u![0], kana: _u![1]),
          if (_e != null) StudyTableContent(romaji: _e![0], kana: _e![1]),
          if (_o != null) StudyTableContent(romaji: _o![0], kana: _o![1]),
        ],
      ),
    );
  }
}
