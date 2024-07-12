import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/features/notification/database/db_helper.dart';
import 'package:flutter_project/features/notification/model/notification_model.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class PaymentSuccess extends StatefulWidget {
  static const String routeName = '/payment-success';
  String uid;
  String firstname;
  String nama_penginapan;
  String startDate;
  String endDate;
  PaymentSuccess({
    required this.uid,
    required this.firstname,
    required this.nama_penginapan,
    required this.startDate,
    required this.endDate,
    super.key,
  });

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  @override
  void initState() {
    super.initState();

    // Inisialisasi konfigurasi notifikasi
    AwesomeNotifications().initialize(
      '',
      [
        NotificationChannel(
          channelKey: 'basic channel',
          channelName: 'basic notif',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
        ),
      ],
    );

    // Membuat dan menampilkan notifikasi
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic channel',
        title:
            'Transaksi berhasil untuk pemesanan \n ${widget.nama_penginapan}',
        body:
            'Terimakasih ${widget.firstname} karena telah melakukan pembayaran untuk ${widget.nama_penginapan} untuk tanggal ${widget.startDate} sampai dengan tanggal ${widget.endDate}, jangan lupa untuk menjaga kesehatan dan datang ke hotel sesuai dengan waktu check-in',
      ),
    );

    NotifModel notifModel = NotifModel(
      title: 'Transaksi berhasil untuk pemesanan ${widget.nama_penginapan}',
      body:
          'Terimakasih ${widget.firstname} karena telah melakukan pembayaran untuk ${widget.nama_penginapan} untuk tanggal ${widget.startDate} sampai dengan tanggal ${widget.endDate}, jangan lupa untuk menjaga kesehatan dan datang ke hotel sesuai dengan waktu check-in',
      uid: widget.uid,
      time: DateTime.now(),
    );
    NotificationDatabaseHelper.insertNotification(notifModel);

    // Tunggu selama 5 detik, lalu navigasikan ke halaman beranda
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushNamedAndRemoveUntil(
          context, '/home-screen', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.blue),
        child: Center(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 172,
                ),
                Image.asset(
                  'assets/images/check.png',
                  height: 120,
                ),
                SizedBox(
                  height: 43,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "You're\ntranscation ",
                    style: GoogleFonts.manrope(
                      fontSize: 24,
                      color: const Color(0xFFDEE1FE),
                      letterSpacing: 3.5 / 100,
                      height: 152 / 100,
                    ),
                    children: const [
                      TextSpan(
                        text: "successfull",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(text: "\nThank you!"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
