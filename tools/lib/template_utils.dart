String convertTemplate(String src, Map<String, String> map) {
  for (final key in map.entries) {
    src = src.replaceAll('%${key.key}%', key.value);
  }
  return src;
}