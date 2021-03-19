import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;
  final String baseUrl = "https://zipu.me/api/userapp/v1/";

  NetworkHelper({this.url});

  // Future getData() async {
  //   http.Response response = await http.get(this.url);
  //   if (response.statusCode == 200) {
  //     String received = response.body;
  //     print(response.statusCode);
  //     return jsonDecode(received);
  //   } else
  //     print(response.statusCode);
  // }

  Future<http.Response> getApiData(String apiUrl) async {
    Uri _url = Uri.dataFromString(baseUrl + apiUrl);
    return await http.get(_url);
  }

  Future<http.Response> postApiData(
      String apiUrl, Map<String, dynamic> parameters) async {
    Uri _url = Uri.dataFromString(baseUrl + apiUrl);
    return await http.post(_url, body: parameters);
  }
}
