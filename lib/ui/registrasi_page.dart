import 'package:flutter/material.dart';
import 'package:biodata/bloc/registrasi_bloc.dart';
import 'package:biodata/widget/success_dialog.dart';
import 'package:biodata/widget/warning_dialog.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({Key? key}) : super(key: key);

  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _namaTextboxController = TextEditingController();
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();
  final _passwordKonfirmasiController = TextEditingController();

  @override
  void dispose() {
    _namaTextboxController.dispose();
    _emailTextboxController.dispose();
    _passwordTextboxController.dispose();
    _passwordKonfirmasiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registrasi")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _namaTextField(),
              const SizedBox(height: 16),
              _emailTextField(),
              const SizedBox(height: 16),
              _passwordTextField(),
              const SizedBox(height: 16),
              _passwordKonfirmasiTextField(),
              const SizedBox(height: 24),
              _buttonRegistrasi(),
            ],
          ),
        ),
      ),
    );
  }

  // Text Field Nama
  Widget _namaTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama"),
      controller: _namaTextboxController,
      validator: (value) {
        if (value == null || value.trim().length < 3) {
          return "Nama harus diisi minimal 3 karakter";
        }
        return null;
      },
    );
  }

  // Text Field Email
  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Email"),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email harus diisi';
        }

        final regex = RegExp(
          r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
        );
        if (!regex.hasMatch(value)) {
          return "Email tidak valid";
        }

        return null;
      },
    );
  }

  // Text Field Password
  Widget _passwordTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Password"),
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        if (value == null || value.length < 6) {
          return "Password harus minimal 6 karakter";
        }
        return null;
      },
    );
  }

  // Text Field Konfirmasi Password
  Widget _passwordKonfirmasiTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Konfirmasi Password"),
      obscureText: true,
      controller: _passwordKonfirmasiController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Konfirmasi password harus diisi";
        }
        if (value != _passwordTextboxController.text) {
          return "Konfirmasi password tidak cocok";
        }
        return null;
      },
    );
  }

  // Tombol Registrasi
  Widget _buttonRegistrasi() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: const Text("Registrasi"),
        onPressed: _isLoading
            ? null
            : () {
          if (_formKey.currentState!.validate()) {
            _submit();
          }
        },
      ),
    );
  }

  // Fungsi Submit Registrasi
  void _submit() {
    setState(() {
      _isLoading = true;
    });

    RegistrasiBloc.registrasi(
      nama: _namaTextboxController.text.trim(),
      email: _emailTextboxController.text.trim(),
      password: _passwordTextboxController.text,
    ).then((value) {
      setState(() {
        _isLoading = false;
      });

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => SuccessDialog(
          description: "Registrasi berhasil, silakan login",
          okClick: () {
            Navigator.pop(context); // tutup dialog
            Navigator.pop(context); // kembali ke halaman sebelumnya (misal login)
          },
        ),
      );
    }).catchError((error) {
      setState(() {
        _isLoading = false;
      });

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => WarningDialog(
          description: "Registrasi gagal: ${error.toString()}",
        ),
      );
    });
  }
}
