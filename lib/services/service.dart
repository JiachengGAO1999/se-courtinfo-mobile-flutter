import 'package:http/http.dart' as http;

class ReturnHttpPost<T> {
  var body;
  ReturnHttpPost(http.Response res) {
    body = res.body;
  }
}

class HttpService {
  final String address = "http://127.0.0.1/api";

  Uri apiAddress(String apiAddr) => Uri.parse(address + apiAddr);
}
