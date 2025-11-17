import 'package:flutter/material.dart';
import 'package:biodata/bloc/biodata_bloc.dart';
import 'package:biodata/model/biodata.dart';
import 'package:biodata/ui/biodata_page.dart';
import 'package:biodata/widget/warning_dialog.dart';

class BiodataForm extends StatefulWidget {
  final Biodata? biodata;
  const BiodataForm({Key? key, this.biodata}) : super(key: key);

  @override
  _BiodataFormState createState() => _BiodataFormState();
}

class _BiodataFormState extends State<BiodataForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH BIODATA";
  String tombolSubmit = "SIMPAN";

  final _namaTextboxController = TextEditingController();
  final _alamatTextboxController = TextEditingController();
  final _tanggalLahirController = TextEditingController();
  final _nomorTeleponTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  void isUpdate() {
    if (widget.biodata != null && widget.biodata!.id != null) {
      judul = "UBAH BIODATA";
      tombolSubmit = "UBAH";

      _namaTextboxController.text = widget.biodata!.nama ?? "";
      _alamatTextboxController.text = widget.biodata!.alamat ?? "";
      _tanggalLahirController.text = widget.biodata!.tanggalLahir ?? "";
      _nomorTeleponTextboxController.text = widget.biodata!.nomorTelepon ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _namaTextField(),
                _alamatTextField(),
                _tanggalLahirTextField(),
                _nomorTeleponTextField(),
                const SizedBox(height: 20),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TEXT FIELD

  Widget _namaTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama"),
      controller: _namaTextboxController,
      validator: (value) => value!.isEmpty ? "Nama harus diisi" : null,
    );
  }

  Widget _alamatTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Alamat"),
      controller: _alamatTextboxController,
      validator: (value) => value!.isEmpty ? "Alamat harus diisi" : null,
    );
  }

  // TANGGAL LAHIR PICKER
  Widget _tanggalLahirTextField() {
    return TextFormField(
      controller: _tanggalLahirController,
      decoration: const InputDecoration(
        labelText: "Tanggal Lahir",
        suffixIcon: Icon(Icons.calendar_today),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        if (pickedDate != null) {
          String formatted =
              "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
          setState(() {
            _tanggalLahirController.text = formatted;
          });
        }
      },
      validator: (value) =>
      value!.isEmpty ? "Tanggal lahir harus dipilih" : null,
    );
  }

  Widget _nomorTeleponTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nomor Telepon"),
      controller: _nomorTeleponTextboxController,
      keyboardType: TextInputType.phone,
      validator: (value) =>
      value!.isEmpty ? "Nomor telepon harus diisi" : null,
    );
  }

  // BUTTON SUBMIT
  Widget _buttonSubmit() {
    return OutlinedButton(
      child: Text(tombolSubmit),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          if (!_isLoading) {
            widget.biodata != null ? ubah() : simpan();
          }
        }
      },
    );
  }

  // SIMPAN DATA BARU
  Future<void> simpan() async {
    setState(() => _isLoading = true);

    try {
      final createBiodata = Biodata()
        ..nama = _namaTextboxController.text
        ..alamat = _alamatTextboxController.text
        ..tanggalLahir = _tanggalLahirController.text
        ..nomorTelepon = _nomorTeleponTextboxController.text;

      await BiodataBloc.addBiodata(biodata: createBiodata);

      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const BiodataPage()),
      );
    } catch (error) {
      await showDialog(
        context: context,
        builder: (_) => WarningDialog(
          description: "Simpan gagal.\nError: ${error.toString()}",
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // UPDATE DATA
  Future<void> ubah() async {
    setState(() => _isLoading = true);

    try {
      final updateBiodata = Biodata(id: widget.biodata!.id)
        ..nama = _namaTextboxController.text
        ..alamat = _alamatTextboxController.text
        ..tanggalLahir = _tanggalLahirController.text
        ..nomorTelepon = _nomorTeleponTextboxController.text;

      await BiodataBloc.updateBiodata(biodata: updateBiodata);

      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const BiodataPage()),
      );
    } catch (error) {
      await showDialog(
        context: context,
        builder: (_) => WarningDialog(
          description: "Ubah gagal.\nError: ${error.toString()}",
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
