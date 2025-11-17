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
    final dataMap = (obj['data'] is Map<String, dynamic>)
        ? obj['data'] as Map<String, dynamic>
        : obj;

    return Biodata(
      code: obj['code'],
      status: obj['status'],
      id: dataMap['id'] == null ? null : int.tryParse(dataMap['id'].toString()),
      nama: dataMap['nama'],
      alamat: dataMap['alamat'],
      tanggalLahir: dataMap['tanggal_lahir'],
      nomorTelepon: dataMap['nomor_telepon'],
    );
  }
}
