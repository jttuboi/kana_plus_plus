import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class StudyTable extends StatelessWidget {
  const StudyTable({required String title, required List<Widget> rows, Key? key})
      : _title = title,
        _rows = rows,
        super(key: key);

  final String _title;
  final List<Widget> _rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.deepPurple),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_title, style: TextStyle(color: Colors.grey.shade300, fontSize: Device.get().isTablet ? 24.0 : 18.0)),
              ],
            ),
          ),
          ..._rows.fold<List<Widget>>(<Widget>[], (list, widget) {
            list.add(widget);
            if (widget != _rows.last) {
              list.add(const SizedBox(height: 4));
            }
            return list;
          }),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
