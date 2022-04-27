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
/// See the [example][] for more details.
///
/// [example]: https://gitee.com/kikt/flutter_ok_widget/blob/master/example/lib/table_mixin_example.dart
///
/// {@endtemplate}
mixin OKTableMixin<T> {
  /// {@macro flutter_ok_widget.createWeightList}
  List<int> get weightList => createWeightList();

  /// {@template flutter_ok_widget.createWeightList}
  ///
  /// Create a list of weights.
  ///
  /// {@endtemplate}
  List<int> createWeightList();

  /// The header of the table.
  List<InlineSpan> createTableTitleList();

  /// The content of the table row.
  List<InlineSpan> buildContentTextList(T item);

  /// If your table is need pull down refresh,
  /// just implement this method.
  ///
  /// The content will be warp by [RefreshIndicator].
  RefreshCallback? onRefreshTable;

  /// The table theme.
  OKTableThemeData _tableTheme(BuildContext context) =>
      OKTableTheme.of(context);

  /// Wrapper every table title cell and content cell.
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

  /// The text style of the table title.
  TextStyle tableTitleTextStyle(BuildContext context) =>
      _tableTheme(context).titleStyle;

  /// The text style of the table content.
  TextStyle tableBodyTextStyle(BuildContext context) =>
      _tableTheme(context).bodyStyle;

  /// Build every table title row.
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

  /// Build every table content row.
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

  /// Build the table.
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
