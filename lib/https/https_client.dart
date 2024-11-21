import 'package:http/http.dart' as http;

abstract class IHttpClient{
  Future get({required String url});
}

class HttpsClient implements IHttpClient{
  final client = http.Client();

  @override
  Future get({required String url}) async{
    return await client.get(Uri.parse(url));
  }
}