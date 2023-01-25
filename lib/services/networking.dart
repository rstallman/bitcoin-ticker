import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

// Network helper to fetch data
class NetworkHelper {
  final Uri url;

  NetworkHelper(this.url);

  Future getData() async {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      return convert.jsonDecode(data);
    } else {
      print('Response status: ${response.statusCode}');
    }
  }
}
