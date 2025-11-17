import 'package:flutter/material.dart';
import 'package:biodata/model/biodata.dart';
import 'package:biodata/ui/biodata_form.dart';
import 'package:biodata/bloc/biodata_bloc.dart';

class BiodataDetail extends StatefulWidget {
  final Biodata? biodata;
  const BiodataDetail({Key? key, this.biodata}) : super(key: key);

  @override
  _BiodataDetailState createState() => _BiodataDetailState();
}

class _BiodataDetailState extends State<BiodataDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Biodata')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ID : ${widget.biodata!.id}",
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 10),
            Text(
              "Nama : ${widget.biodata!.nama}",
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10),
            Text(
              "Alamat : ${widget.biodata!.alamat}",
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10),
            Text(
              "Tanggal Lahir : ${widget.biodata!.tanggalLahir}",
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10),
            Text(
              "Nomor Telepon : ${widget.biodata!.nomorTelepon}",
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20),
            _tombolHapusEdit(),
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BiodataForm(biodata: widget.biodata!),
              ),
            );
          },
        ),
        const SizedBox(width: 10),
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () async {
            bool isDeleted =
            await BiodataBloc.deleteBiodata(id: widget.biodata!.id);

            if (isDeleted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Biodata berhasil dihapus")),
              );
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Gagal menghapus biodata")),
              );
            }
          },
        ),
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
