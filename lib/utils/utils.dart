
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