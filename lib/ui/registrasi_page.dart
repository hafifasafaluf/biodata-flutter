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
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
      appBar: AppBar(
        title: const Text("Daftar Akun Baru"),
        elevation: 0, // Hapus shadow AppBar
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [_buildHeader(context), _buildForm(context)],
              ),
            ),
    );
  }

  // Header dengan Icon atau Gambar
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Column(
        children: const [
          Icon(
            Icons.person_add_alt_1, // Icon yang relevan untuk registrasi
            size: 80,
            color: Colors.deepPurple, // Warna yang menarik
          ),
          SizedBox(height: 10),
          Text(
            "Bergabunglah Bersama Kami!",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            "Isi data diri Anda di bawah ini.",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // Bagian Form Registrasi
  Widget _buildForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _namaTextField(),
            const SizedBox(height: 20),
            _emailTextField(),
            const SizedBox(height: 20),
            _passwordTextField(),
            const SizedBox(height: 20),
            _passwordKonfirmasiTextField(),
            const SizedBox(height: 30),
            _buttonRegistrasi(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- Text Field Widgets dengan Dekorasi Modern ---

  // Text Field Nama
  Widget _namaTextField() {
    return TextFormField(
      decoration: _inputDecoration(
        labelText: "Nama Lengkap",
        icon: Icons.person_outline,
      ),
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
      decoration: _inputDecoration(
        labelText: "Alamat Email",
        icon: Icons.email_outlined,
      ),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email harus diisi';
        }
        final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
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
      decoration: _inputDecoration(
        labelText: "Password",
        icon: Icons.lock_outline,
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
      obscureText: _obscurePassword,
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
      decoration: _inputDecoration(
        labelText: "Konfirmasi Password",
        icon: Icons.lock_reset_outlined,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscureConfirmPassword = !_obscureConfirmPassword;
            });
          },
        ),
      ),
      obscureText: _obscureConfirmPassword,
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

  // Fungsi Dekorasi Input
  InputDecoration _inputDecoration({
    required String labelText,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(icon, color: Colors.deepPurple),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.deepPurple),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
      ),
    );
  }

  // Tombol Registrasi
  Widget _buttonRegistrasi() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple, // Warna tombol yang lebih hidup
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 5,
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
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

  // Fungsi Submit Registrasi (tetap sama)
  void _submit() {
    setState(() {
      _isLoading = true;
    });

    // Simulasikan atau panggil fungsi registrasi yang sebenarnya
    RegistrasiBloc.registrasi(
          nama: _namaTextboxController.text.trim(),
          email: _emailTextboxController.text.trim(),
          password: _passwordTextboxController.text,
        )
        .then((value) {
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
                Navigator.pop(
                  context,
                ); // kembali ke halaman sebelumnya (misal login)
              },
            ),
          );
        })
        .catchError((error) {
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
