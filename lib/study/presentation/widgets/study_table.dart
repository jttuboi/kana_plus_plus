import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:kwriting/study/presentation/notifiers/study_table.change_notifier.dart';
import 'package:kwriting/study/presentation/widgets/study_table_row.dart';
import 'package:provider/provider.dart';

class StudyTable extends StatelessWidget {
  const StudyTable({required this.title, required this.rows, Key? key}) : super(key: key);

  final String title;
  final List<StudyTableRow> rows;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudyTableProvider(),
      builder: (context2, child) {
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
                    Text(title, style: TextStyle(color: Colors.grey.shade300, fontSize: Device.get().isTablet ? 24.0 : 18.0)),
                    //IconButton(onPressed: () => _onShowAllPressed(context2), icon: SvgPicture.asset(IconUrl.showAll, color: studyTableTitleColor)),
                  ],
                ),
              ),
              ..._buildStudyRowsWithSpace(),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildStudyRowsWithSpace() {
    final list = <Widget>[rows[0]];
    for (var i = 1; i < rows.length; i++) {
      list
        ..add(const SizedBox(height: 4))
        ..add(rows[i]);
    }
    return list;
  }

  // void _onShowAllPressed(BuildContext context) {
  //   Provider.of<StudyTableProvider>(context, listen: false).showKana();
  // }
}