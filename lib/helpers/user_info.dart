import 'package:shared_preferences/shared_preferences.dart';

class BiodataInfo {
  Future setBiodataToken(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString("biodata_token", value);
  }

  Future<String?> getBiodataToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("biodata_token");
  }

  Future setBiodataID(int value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setInt("biodataID", value);
  }

  Future<int?> getBiodataID() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt("biodataID");
  }

  Future biodata() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
