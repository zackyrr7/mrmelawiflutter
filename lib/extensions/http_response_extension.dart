import 'package:http/http.dart' as http;

extension HttpResponseExtension on http.Response {
  bool get isSuccess {
    return statusCode >= 200 && statusCode <= 299;
  }
}
