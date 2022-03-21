import 'package:http/http.dart' as http;

String httpErrorHandler(http.Response response) {
  final satatusCode = response.statusCode;
  final reasonPhrase = response.reasonPhrase;

  final String errorMessage = 'Request failed\nReason: $reasonPhrase';

  return errorMessage;
}
