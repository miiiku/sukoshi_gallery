
// 量化数字大小
String quantizationNumber(int num, [int digit = 0]) {
  List<Map<String, dynamic>> SI = [
    {
      "symbol"  : "",
      "value"   : 1,
    },
    {
      "symbol"  : "K",
      "value"   : 1e3,
    },
    {
      "symbol"  : "M",
      "value"   : 1e6,
    },
    {
      "symbol"  : "G",
      "value"   : 1e9,
    },
  ];
  
  for (int i = SI.length - 1; i >= 0; i--) {
    if (num >= SI[i]['value']) {
      return (num / SI[i]['value']).toStringAsFixed(digit) + SI[i]['symbol'];
    }
  }
}

String add0(int number) {
  return number < 10 ? '0$number' : '$number';
}


String formatDate(int milliseconds) {
  DateTime dt = DateTime.fromMillisecondsSinceEpoch(milliseconds);
  int year       = dt.year;
  String month   = add0(dt.month);
  String day     = add0(dt.day);
  String hour    = add0(dt.hour);
  String minute  = add0(dt.minute);
  String second  = add0(dt.second);
  return '$year-$month-$day $hour:$minute:$second';
}