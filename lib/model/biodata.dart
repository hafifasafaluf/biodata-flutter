class Biodata {
  int? code;
  bool? status;
  int? id;
  String? nama;
  String? alamat;
  String? tanggalLahir;
  String? nomorTelepon;

  Biodata({
    this.code,
    this.status,
    this.id,
    this.nama,
    this.alamat,
    this.tanggalLahir,
    this.nomorTelepon,
  });

  factory Biodata.fromJson(Map<String, dynamic> obj) {
    return Biodata(
      code: obj['code'],
      status: obj['status'],
      id: obj['data']['id'] == null
          ? null
          : int.tryParse(obj['data']['id'].toString()),
      nama: obj['data']['nama'],
      alamat: obj['data']['alamat'],
      tanggalLahir: obj['data']['tanggal_lahir'],
      nomorTelepon: obj['data']['nomor_telepon'],
    );
  }
}
