class Biodata {
  int? code;
  bool? status;
  String? token;
  int? biodataID;
  String? biodataNama;
  Biodata({this.code, this.status, this.token, this.biodataID, this.biodataNama});
  factory Biodata.fromJson(Map<String, dynamic> obj) {
    return Biodata(
      code: obj['code'],
      status: obj['status'],
      token: obj['data']['token'],
      biodataID: obj['data']['biodata']['id'] == null
          ? null
          : int.tryParse(obj['data']['biodata']['id'].toString()),
      biodataNama: obj['data']['biodata']['nama'],
    );
  }

}
