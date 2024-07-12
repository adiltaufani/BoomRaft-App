import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  final Function onConfirmLogout;

  LogoutDialog({required this.onConfirmLogout});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white, // Mengubah warna latar belakang dialog
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Mengubah sudut dialog
      ),
      title: Text(
        "Konfirmasi Logout",
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold), // Mengubah gaya teks judul
      ),
      content: Text(
        "Apakah Anda yakin ingin logout?",
        style: TextStyle(color: Colors.black), // Mengubah gaya teks konten
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Tutup dialog
          },
          child: Text(
            "Batal",
            style: TextStyle(color: Colors.black), // Mengubah gaya teks tombol
          ),
        ),
        TextButton(
          onPressed: () {
            onConfirmLogout(); // Panggil fungsi logout
            Navigator.of(context).pop(); // Tutup dialog
          },
          child: Text(
            "OK",
            style: TextStyle(color: Colors.red), // Mengubah warna teks tombol
          ),
        ),
      ],
    );
  }
}
