import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';

class ApiClient {
  final String baseUrl;

  ApiClient({this.baseUrl = AppConfig.apiBaseUrl});

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.get(url, headers: headers);
    return _handleResponse(response);
  }

  Future<dynamic> post(String endpoint, dynamic data, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.post(
      url,
      headers: headers ?? {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  Future<dynamic> put(String endpoint, dynamic data, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.put(
      url,
      headers: headers ?? {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  Future<dynamic> delete(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.delete(url, headers: headers);
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final body = response.body;
    if (statusCode >= 200 && statusCode < 300) {
      return jsonDecode(body);
    } else {
      throw Exception('Error: $statusCode - $body');
    }
  }
}
