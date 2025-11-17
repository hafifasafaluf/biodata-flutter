class ApiUrl {
  static const String baseUrl = 'http://localhost/biodata-api/public';

  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listBiodata = baseUrl + '/biodata';
  static const String createBiodata = baseUrl + '/biodata';

  static String updateBiodata(int id) {
    return baseUrl + '/biodata/' + id.toString();
  }

  static String showBiodata(int id) {
    return baseUrl + '/biodata/' + id.toString();
  }

  static String deleteBiodata(int id) {
    return baseUrl + '/biodata/' + id.toString();
  }
}
