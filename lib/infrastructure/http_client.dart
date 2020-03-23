import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpClient {

    HttpClient(this.baseUrl);

    final String baseUrl;

    Future<Response> get(String path, {Map<String, String> headers}) async {
      try {
        var url = baseUrl + path;
        var response = await http.get(url, headers: headers);
        _ensureSuccessStatusCode(response);
        return response;
      } catch(e) {
        log('Failed GET request to resource $path');
        log(e.toString());
        rethrow;
      }
    }

    Future<Response> post(String path, dynamic body, {Map<String, String> headers}) async {
      try {
        var url = baseUrl + path;
        var response = await http.post(url, body: jsonEncode(body), headers: headers);
        _ensureSuccessStatusCode(response);
        return response;
      } catch(e) {
        log('Failed POST request to resource $path');
        log(e.toString());
        rethrow;
      }
    }

    Future<Response> put(String path, dynamic body, {Map<String, String> headers}) async {
      try {
        var url = baseUrl + path;
        var response = await http.put(url, body: jsonEncode(body), headers: headers);
        _ensureSuccessStatusCode(response);
        return response;
      } catch(e) {
        log('Failed PUT request to resource $path');
        log(e.toString());
        rethrow;
      }
    }

    Future<Response> delete(String path, {Map<String, String> headers}) async {
      try {
        var url = baseUrl + path;
        var response = await http.delete(url, headers: headers);
        _ensureSuccessStatusCode(response);
        return response;
      } catch(e) {
        log('Failed DELETE request to resource $path');
        log(e.toString());
        rethrow;
      }
    }

    void _ensureSuccessStatusCode(Response response) {
        if (response.statusCode - 200 > 99) {
            throw http.ClientException(response.reasonPhrase);
        }
    }
}