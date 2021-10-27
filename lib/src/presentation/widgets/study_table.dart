import 'package:flutter/material.dart';
import 'package:kwriting/src/presentation/state_management/study_table.change_notifier.dart';
import 'package:kwriting/src/presentation/utils/consts.dart';
import 'package:kwriting/src/presentation/widgets/study_table_row.dart';
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
          decoration: studyTableDecoration,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: studyTableTitleTextStyle),
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
