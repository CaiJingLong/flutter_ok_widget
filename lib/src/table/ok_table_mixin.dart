import 'package:flutter/material.dart';
import 'package:flutter_ok_widget/flutter_ok_widget.dart';

/// {@template flutter_ok_widget.table_mixin}
///
/// Use [Column] and [ListView] to build a table.
///
/// Just support vertical table.
///
/// Use [buildTable] to build the table.
///
/// {@endtemplate}
mixin TableMixin<T> {
  List<int> get weightList => createWeightList();

  List<int> createWeightList();

  List<InlineSpan> createTableTitleList();

  List<InlineSpan> buildContentTextList(T item);

  RefreshCallback? onRefreshTable;

  OKTableThemeData tableTheme(BuildContext context) =>
      OKTableTheme.of(context)?.data ?? OKTableTheme.defaultTheme;

  Widget wrapperText(
    BuildContext context,
    InlineSpan textSpan, {
    required TextStyle style,
  }) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text.rich(
        textSpan,
        textAlign: TextAlign.center,
        style: style,
      ),
    );
  }

  TextStyle tableTitleTextStyle(BuildContext context) =>
      tableTheme(context).titleStyle;

  TextStyle tableBodyTextStyle(BuildContext context) =>
      tableTheme(context).bodyStyle;

  Widget _buildTitleRow(BuildContext context) {
    final List<InlineSpan> titleList = createTableTitleList();
    return Row(
      children: [
        for (int i = 0; i < titleList.length; i++)
          Expanded(
            flex: weightList[i],
            child: wrapperText(
              context,
              titleList[i],
              style: tableTitleTextStyle(context),
            ),
          ),
      ],
    );
  }

  Widget buildTableRow(BuildContext context, T item) {
    final textList = buildContentTextList(item);
    return Row(
      children: [
        for (int i = 0; i < textList.length; i++)
          Expanded(
            flex: weightList[i],
            child: wrapperText(
              context,
              textList[i],
              style: tableBodyTextStyle(context),
            ),
          ),
      ],
    );
  }

  Widget buildTable(BuildContext context, List<T> list) {
    // 使用 Column，ListView，构建表格
    Widget listView = ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return buildTableRow(context, item);
      },
    );

    if (onRefreshTable != null) {
      listView = RefreshIndicator(
        onRefresh: onRefreshTable!,
        child: listView,
      );
    }

    return Column(
      children: [
        _buildTitleRow(context),
        Expanded(
          child: listView,
        ),
      ],
    );
  }
}
