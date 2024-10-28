import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(), // Menampilkan indikator loading
            SizedBox(height: 20), // Memberikan jarak
            Text(
              'Sedang memuat...',
              style: TextStyle(fontSize: 20), // Menentukan ukuran font
            ),
          ],
        ),
      ),
    );
  }
}
