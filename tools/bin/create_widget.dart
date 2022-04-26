import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

void main(List<String> args) {
  final widgetDir = '..';
  final dir = Directory(widgetDir);

  print('The directory is: ${dir.absolute.path}');

  // 1. 根据传入参数，创建 dart 文件
  try {
    final pathName = args[0];
    final filePathName = convertToFileName(pathName);
    final targetFile = File('${dir.absolute.path}/lib/src/$filePathName.dart');
    targetFile.createSync(recursive: true);

    // 2. 写入文件内容，读取模板文件
    final templateFile = File('template/src.dart.tmpl');
    final src = templateFile.readAsStringSync();
    final className = convertClassName(pathName);
    final content = convertContent(src, className);
    targetFile.writeAsStringSync(content);
  } catch (e) {
    print('No widget name is provided.');
  } finally {
    makeIndexDartFile(dir);
    formatDartFile(dir);
  }
}

void formatDartFile(Directory dir) {
  final formatPath = '${dir.absolute.path}/lib';
  final shellCommand = 'flutter';
  final process = Process.runSync(shellCommand, ['format', formatPath]);
  print('${process.stdout}');
  print('${process.stderr}');
}

String _convertTemplate(String src, Map<String, String> map) {
  for (final key in map.entries) {
    src = src.replaceAll('%${key.key}%', key.value);
  }
  return src;
}

String convertContent(String src, String className) {
  return _convertTemplate(src, {
    'Name': className,
    'Date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
  });
}

void makeIndexDartFile(Directory dir) {
  final srcDir = Directory('${dir.absolute.path}/lib/src');

  final files = srcDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((element) => element.path.endsWith('.dart'));

  print('The files are: ${files.map((element) => element.path).toList()}');

  final exportList = files
      .map((element) =>
          relative(element.absolute.path, from: srcDir.absolute.path))
      .map((element) => "export 'src/$element';")
      .toList();
  final indexFilePath = '${dir.absolute.path}/lib/flutter_ok_widget.dart';
  final indexFile = File(indexFilePath);
  indexFile.createSync(recursive: true);

  final widgetList = files
      .map((e) => basename(e.absolute.path))
      .map((e) => e.substring(0, e.length - 5))
      .map(convertClassName)
      .toList();

  final widgetTableMarkdown = '''
${widgetList.map((e) => '[$e]').join('\n')}
'''
      .trim()
      .split('\n')
      .map((e) => '/// - $e')
      .toList()
      .join('\n');

  final indexHeader = '''
// Generated by create_widget.dart
// Date: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}
''';

  final StringBuffer sb = StringBuffer();
  sb.writeln(indexHeader);
  sb.writeln();
  sb.writeln('/// List of all widgets:');
  sb.writeln(widgetTableMarkdown);
  // sb.writeln('library flutter_ok_widget;');
  // sb.writeln();
  sb.writeln("import 'flutter_ok_widget.dart';");
  sb.writeln(exportList.join('\n'));

  indexFile.writeAsStringSync(sb.toString());
}

/// 将文件名转为大驼峰格式
///
/// 例如：hello-widget -> HelloWidget
/// hello_widget -> HelloWidget
String convertClassName(String name) {
  final list = name.split(RegExp(r'[-_]'));
  final result = list
      .map((element) =>
          element.substring(0, 1).toUpperCase() +
          element.substring(1).toLowerCase())
      .join();
  return result;
}

/// 将文件名转为下划分分割的形式, 每一部分均为小写
String convertToFileName(String name) {
  final list = name.split(RegExp(r'[-_]'));
  return list.map((e) => e.toLowerCase()).join('_');
}