import 'dart:convert';
import 'package:biodata/helpers/api.dart';
import 'package:biodata/helpers/api_url.dart';
import 'package:biodata/model/biodata.dart';

class BiodataBloc {
  static Future<Biodata> tambahBiodata({
    String? nama,
    String? alamat,
    String? tanggalLahir,
    String? nomorTelepon,
  }) async {
    String apiUrl = ApiUrl.biodata; // pastikan di api_url.dart sudah ada endpoint biodata
    var body = {
      "nama": nama,
      "alamat": alamat,
      "tanggal_lahir": tanggalLahir,
      "nomor_telepon": nomorTelepon,
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return Biodata.fromJson(jsonObj);
  }
}
