import 'dart:convert';
import 'package:biodata/helpers/api.dart';
import 'package:biodata/helpers/api_url.dart';
import 'package:biodata/model/registrasi.dart';

class RegistrasiBloc {
  static Future<Registrasi> registrasi({
    required String nama,
    required String email,
    required String password,
  }) async {
    String apiUrl = ApiUrl.registrasi;
    var body = {"nama": nama, "email": email, "password": password};

    final response = await Api().post(apiUrl, body);

    if (response.statusCode == 200) {
      final jsonObj = json.decode(response.body);
      return Registrasi.fromJson(jsonObj);
    } else {
      throw Exception("Registrasi gagal: ${response.body}");
    }
  }
}
