/// 安全解析[bool]
bool safeBool(dynamic src, {
  bool defaultValue = false,
}) {
  if (src == null) {
    return defaultValue;
  } else {
    if (src is bool) {
      return src;
    }else if (src is int){
      return (src == 1);
    } else {
      if (src.toString() == 'true' || src.toString() == 'false'){
        return (src.toString() == 'true');
      }
      return (src.toString() == '1');
    }
  }
}

/// 安全解析[int]
int safeInt(dynamic src, {
  int defaultValue = 0,
}) {
  if (src == null) {
    return defaultValue;
  } else if (src is int) {
    return src;
  } else {
    return int.tryParse(safeString(src)) ?? defaultValue;
  }
}

/// 安全解析[double]
double safeDouble(dynamic value,{
  double defaultValue = 0.0,
}) {
  return value == null ? defaultValue : (double.tryParse(value.toString()) ?? defaultValue);
}

/// 安全解析[String]
String safeString(dynamic src, {
  String defaultValue = '',
}) {
  if (src == null) {
    return defaultValue;
  } else {
    if (src is String) {
      return src;
    } else {
      return src.toString();
    }
  }
}