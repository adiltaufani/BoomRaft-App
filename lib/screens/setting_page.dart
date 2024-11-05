import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project/routes/router.dart' as router;
import 'package:flutter_project/routes/router.dart';
import 'package:flutter_project/screens/contactus_screen.dart';
import 'package:flutter_project/screens/faq_screen.dart';
import 'package:flutter_project/screens/main_screen.dart';
import 'package:flutter_project/screens/notification_page.dart';
import 'package:flutter_project/services/auth_service.dart';
import 'package:flutter_project/services/google_auth_service.dart';
import 'package:flutter_project/services/user_services.dart';
import 'package:flutter_project/themes/theme.dart';
import 'package:flutter_project/widgets/loading.dart';
import 'package:flutter_project/widgets/logout_dialog.dart';
import 'package:flutter_project/variables.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/profile_setting.dart';
import 'package:flutter_project/screens/transaction_screen.dart';
import 'package:flutter_project/zzunused/wishlist/screens/wishlist_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingPage extends StatefulWidget {
  static const String routeName = '/setting-page';
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String? firstname;
  String? lastname;
  String? email;
  String pp = '';
  bool isDataAvail = false;
  Future<Map<String, dynamic>>? userProfile;
  Map<String, dynamic> userData = {};
  final GoogleAuthService authService = GoogleAuthService();

  @override
  void initState() {
    userProfile = UserServices().getProfile();
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    await fetchUserData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: buildScreen(context));
            // } else if (snapshot.hasError) {
            //   return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            userData = snapshot.data!;
          }
          return buildScreen(context);
        });
  }

  Widget buildScreen(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 180,
                  decoration: const BoxDecoration(color: Color(0xFFFFF492)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, ProfileSetting.routeName);
                          },
                          child: Container(
                              margin: const EdgeInsets.only(left: 24),
                              height: 124,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF8F8F8),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  bottomLeft: Radius.circular(40),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: AspectRatio(
                                        aspectRatio:
                                            1.0, // Mengatur aspect ratio menjadi 1:1 (persegi)
                                        child: isDataAvail
                                            ? CircleAvatar(
                                                radius: 26,
                                                backgroundColor: Colors.white30,
                                                backgroundImage:
                                                    NetworkImage(pp),
                                              )
                                            : CircleAvatar(
                                                radius: 26,
                                                backgroundColor: Colors.white30,
                                                backgroundImage: AssetImage(
                                                    'assets/images/profile.png')),
                                        // CircularProgressIndicator(),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 18.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${userData['name'] ?? 'loading'}',
                                            style: GoogleFonts.montserrat(
                                                textStyle: const TextStyle(
                                              fontSize: 24,
                                              color: AppTheme.darkBlue,
                                              fontWeight: FontWeight.w800,
                                            )),
                                          ),
                                          Text(
                                            '${userData['email'] ?? 'loading'}',
                                            style: GoogleFonts.montserrat(
                                                textStyle: const TextStyle(
                                              fontSize: 14,
                                              color: AppTheme.darkBlue,
                                              fontWeight: FontWeight.w600,
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 32,
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: AppTheme.darkBlue,
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account',
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                          fontSize: 20,
                          color: AppTheme.darkBlue,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 4, bottom: 12),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, ProfileSetting.routeName);
                          },
                          child: Row(
                            children: [
                              Text(
                                'Edit Profile',
                                style: AppTheme.settingTextStyle,
                              ),
                              Expanded(
                                  child: Container(
                                color: Colors.white10,
                              )),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.black45,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 4, bottom: 12),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              // Mengubah _currentScreen menjadi NotificationPage saat tombol ditekan
                              currentScreen = const TransactionScreen();
                              Navigator.pushNamed(
                                  context, MainScreen.routeName);
                            });
                          },
                          child: Row(
                            children: [
                              Text('Transaction',
                                  style: AppTheme.settingTextStyle),
                              Expanded(
                                  child: Container(
                                color: Colors.white10,
                              )),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.black45,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 6,
                  color: Colors.black12,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Settings',
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                          fontSize: 20,
                          color: AppTheme.darkBlue,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 12),
                        child: InkWell(
                          onTap: () {
                            //
                          },
                          child: Row(
                            children: [
                              Text(
                                'Language',
                                style: AppTheme.settingTextStyle,
                              ),
                              Expanded(
                                  child: Container(
                                color: Colors.white10,
                              )),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.black45,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 4, bottom: 12),
                        child: InkWell(
                          onTap: () {
                            //
                          },
                          child: Row(
                            children: [
                              Text(
                                'Change Password',
                                style: AppTheme.settingTextStyle,
                              ),
                              Expanded(
                                  child: Container(
                                color: Colors.white10,
                              )),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.black45,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 6,
                  color: Colors.black12,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Support',
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                          fontSize: 20,
                          color: AppTheme.darkBlue,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 12),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              // Mengubah _currentScreen menjadi NotificationPage saat tombol ditekan
                              currentScreen = const ContactusScreen();
                              Navigator.pushNamed(
                                  context, MainScreen.routeName);
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                'Contact Us',
                                style: AppTheme.settingTextStyle,
                              ),
                              Expanded(
                                  child: Container(
                                color: Colors.white10,
                              )),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.black45,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 4, bottom: 12),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              // Mengubah _currentScreen menjadi NotificationPage saat tombol ditekan
                              currentScreen = const FaqScreen();
                              Navigator.pushNamed(
                                  context, MainScreen.routeName);
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                'FAQ',
                                style: AppTheme.settingTextStyle,
                              ),
                              Expanded(
                                  child: Container(
                                color: Colors.white10,
                              )),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.black45,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 6,
                  color: Colors.black12,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 12),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return LogoutDialog(
                                  onConfirmLogout: () {
                                    // Panggil fungsi logout di sini
                                    AuthService().signOut(context);
                                  },
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Image.asset('assets/images/logout.png'),
                              const SizedBox(width: 20),
                              Text(
                                'Logout',
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF6B0B0B),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.white10,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.black45,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 6,
                  color: Colors.black12,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchUserData() async {
    var user = FirebaseAuth.instance.currentUser;

    // Pastikan user sudah login
    if (user == null) {
      // Jika user belum login, tampilkan pesan
      print("Silakan login terlebih dahulu");
      return; // Keluar dari metode fetchUserData
    }

    var url = Uri.parse("${ipaddr}/ta_projek/crudtaprojek/view_data.php");
    String uid = user.uid;

    var response = await http.post(url, body: {
      "uid": uid,
    });

    var data = json.decode(response.body);
    if (data != null) {
      // Data berhasil diterima, tampilkan firstname dan lastname
      firstname = data['firstname'];
      lastname = data['lastname'];
      email = data['email'];
      pp = await getImageUrl('images/image_$uid.jpg');
      print('Firstname: $firstname, Lastname: $lastname');
      // Lakukan apapun yang Anda ingin lakukan dengan data ini
      setState(() {
        isDataAvail = true;
      });
    } else {
      print("Gagal mendapatkan data pengguna");
    }
  }

  Future<String> getImageUrl(String imagePath) async {
    try {
      // Buat referensi Firebase Storage untuk gambar yang diunggah
      Reference ref = FirebaseStorage.instance.ref().child(imagePath);

      // Dapatkan URL download gambar
      String imageUrl = await ref.getDownloadURL();

      // Kembalikan URL download gambar
      return imageUrl;
    } catch (error) {
      // Tangkap error dan kembalikan URL gambar default jika terjadi kesalahan
      print("Error: $error");
      // Mengembalikan URL gambar default dari assets jika terjadi kesalahan
      return "https://firebasestorage.googleapis.com/v0/b/loginsignupta-prototype.appspot.com/o/images%2Fdefault.webp?alt=media&token=0f99eb8a-be98-4f26-99b7-d71776562de9";
    }
  }
}
