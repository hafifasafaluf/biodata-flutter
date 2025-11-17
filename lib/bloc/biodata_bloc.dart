import 'dart:convert';
import 'package:biodata/helpers/api.dart';
import 'package:biodata/helpers/api_url.dart';
import 'package:biodata/model/biodata.dart';

class BiodataBloc {
  // GET LIST
  static Future<List<Biodata>> getBiodataList() async {
    String apiUrl = ApiUrl.listBiodata;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);

    final listData = (jsonObj is Map && jsonObj['data'] is List)
        ? jsonObj['data']
        : jsonObj;

    return (listData as List)
        .map((item) => Biodata.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  // CREATE
  static Future addBiodata({Biodata? biodata}) async {
    String apiUrl = ApiUrl.createBiodata;

    var body = {
      "nama": biodata!.nama,
      "alamat": biodata.alamat,
      "tanggal_lahir": biodata.tanggalLahir,
      "nomor_telepon": biodata.nomorTelepon,
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  // UPDATE
  static Future<bool> updateBiodata({required Biodata biodata}) async {
    String apiUrl = ApiUrl.updateBiodata(biodata.id!);

    var body = {
      "nama": biodata.nama,
      "alamat": biodata.alamat,
      "tanggal_lahir": biodata.tanggalLahir,
      "nomor_telepon": biodata.nomorTelepon,
    };

    var response = await Api().put(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'] == true;
  }

  // DELETE
  static Future<bool> deleteBiodata({int? id}) async {
    try {
      String apiUrl = ApiUrl.deleteBiodata(id!);

      var response = await Api().delete(apiUrl);
      var jsonObj = json.decode(response.body);

      if (jsonObj is Map<String, dynamic>) {
        if (jsonObj['status'] == true) {
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

}
