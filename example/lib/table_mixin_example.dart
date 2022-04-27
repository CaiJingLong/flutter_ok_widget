import 'package:flutter/material.dart';
import 'package:flutter_ok_widget/flutter_ok_widget.dart';

class ProgrammingLanguage {
  final String name;
  final String url;

  const ProgrammingLanguage({
    required this.name,
    required this.url,
  });
}

/// [programmingLanguages] is a list of programming languages.
///
/// dart, java, kotlin, python, ruby, scala, swift
const languageList = <ProgrammingLanguage>[
  ProgrammingLanguage(
    name: 'dart',
    url: 'https://dart.dev/',
  ),
  ProgrammingLanguage(
    name: 'java',
    url: 'https://www.java.com/en/',
  ),
  ProgrammingLanguage(
    name: 'kotlin',
    url: 'https://kotlinlang.org/',
  ),
  ProgrammingLanguage(
    name: 'python',
    url: 'https://www.python.org/',
  ),
  ProgrammingLanguage(
    name: 'ruby',
    url: 'https://www.ruby-lang.org/',
  ),
  ProgrammingLanguage(
    name: 'scala',
    url: 'https://www.scala-lang.org/',
  ),
  ProgrammingLanguage(
    name: 'swift',
    url: 'https://developer.apple.com/swift/',
  ),
];

class TableMixinExample extends StatefulWidget {
  const TableMixinExample({Key? key}) : super(key: key);

  @override
  State<TableMixinExample> createState() => _TableMixinExampleState();
}

class _TableMixinExampleState extends State<TableMixinExample>
    with OKTableMixin<ProgrammingLanguage> {
  @override
  Widget build(BuildContext context) {
    return buildTable(context, languageList);
  }

  @override
  List<InlineSpan> buildContentTextList(ProgrammingLanguage item) {
    return [
      TextSpan(
        text: item.name,
      ),
      TextSpan(
        text: item.url,
      ),
    ];
  }

  @override
  List<InlineSpan> createTableTitleList() {
    return const [
      TextSpan(
        text: 'Name',
      ),
      TextSpan(
        text: 'URL',
      ),
    ];
  }

  @override
  List<int> createWeightList() {
    return [1, 1];
  }
}
