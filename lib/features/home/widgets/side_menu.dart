import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/features/auth/services/auth/google_auth_service.dart';
import 'package:flutter_project/features/chatAI/screens/aichat_page.dart';
import 'package:flutter_project/features/home/screens/home_screen.dart';
import 'package:flutter_project/features/message/screens/message_screen.dart';
import 'package:flutter_project/features/notification/screens/notification_page.dart';
import 'package:flutter_project/features/payment/screens/transaction_screen.dart';
import 'package:flutter_project/features/profile/screens/setting_page.dart';
import 'package:flutter_project/features/wishlist/screens/wishlist_screen.dart';
import 'package:flutter_project/variables.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class SideMenu extends StatefulWidget {
  SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final GoogleAuthService authService = GoogleAuthService();

  String firstname = '';
  String lastname = '';
  String email = '';
  String pp = '';
  bool isDataAvail = false;

  @override
  void initState() {
    fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String currentRoute = ModalRoute.of(context)?.settings.name ?? '';

    return Drawer(
      backgroundColor: const Color(0xFF50B498),
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            isDataAvail
                ? ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, SettingPage.routeName);
                    },
                    leading: CircleAvatar(
                      radius: 26,
                      backgroundColor: Colors.white30,
                      backgroundImage: NetworkImage(pp),
                    ),
                    title: Text(
                      firstname,
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      email,
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          color: Colors.white60,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  )
                : ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, SettingPage.routeName);
                    },
                    leading: const CircleAvatar(
                      radius: 26,
                      backgroundColor: Colors.white30,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
                    title: Text(
                      'Username',
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      'Email',
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          color: Colors.white60,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  ),
            const Divider(
              color: Colors.white38,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildListTile(
                    context,
                    title: 'Home',
                    routeName: HomeScreen.routeName,
                    icon: Icons.home_filled,
                    currentRoute: currentRoute,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Divider(
                      color: Colors.white24,
                    ),
                  ),
                  _buildListTile(
                    context,
                    title: 'Wishlist',
                    routeName: WishlistScreen.routeName,
                    icon: Icons.bookmark_rounded,
                    currentRoute: currentRoute,
                  ),
                  _buildListTile(
                    context,
                    title: 'Notification',
                    routeName: NotificationPage.routeName,
                    icon: Icons.notifications_rounded,
                    currentRoute: currentRoute,
                  ),
                  _buildListTile(
                    context,
                    title: 'Transaction',
                    routeName: TransactionScreen.routeName,
                    icon: Icons.notes_rounded,
                    currentRoute: currentRoute,
                  ),
                  _buildListTile(
                    context,
                    title: 'Message',
                    routeName: MessageScreen.routeName,
                    icon: Icons.message_rounded,
                    currentRoute: currentRoute,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Divider(
                      color: Colors.white24,
                    ),
                  ),
                  _buildListTile(
                    context,
                    title: 'AI Support',
                    routeName: AIChatPage.routeName,
                    icon: null,
                    iconAsset: 'assets/images/chatai.png',
                    currentRoute: currentRoute,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Divider(
                      color: Colors.white24,
                    ),
                  ),
                  _buildListTile(
                    context,
                    title: 'Setting',
                    routeName: SettingPage.routeName,
                    icon: Icons.settings_rounded,
                    currentRoute: currentRoute,
                  ),
                  _buildListTile(
                    context,
                    title: 'Help',
                    routeName: '',
                    icon: Icons.help_outline_rounded,
                    currentRoute: currentRoute,
                  ),
                  _buildListTile(
                    context,
                    title: 'Logout',
                    routeName: '',
                    icon: Icons.login_rounded,
                    currentRoute: currentRoute,
                    onTap: () {
                      authService.signOut(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context,
      {required String title,
      required String routeName,
      IconData? icon,
      String? iconAsset,
      required String currentRoute,
      VoidCallback? onTap}) {
    bool isSelected = currentRoute == routeName;
    return ListTile(
      onTap: onTap ??
          () {
            Navigator.pushNamed(context, routeName);
          },
      leading: icon != null
          ? SizedBox(
              height: 36,
              width: 36,
              child: Icon(
                icon,
                color: Colors.white,
              ),
            )
          : SizedBox(
              height: 36,
              width: 36,
              child: Image.asset(
                iconAsset!,
                scale: 2.4,
              ),
            ),
      title: Text(
        title,
        style: GoogleFonts.raleway(
          textStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.white.withAlpha(960),
            fontSize: isSelected ? 20 : 18,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
            letterSpacing: 0.2,
          ),
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
      String cleanedUrlFoto = data['profile_picture'].replaceAll('\\', '');
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
      // Mengembalikan URL gambar default dari
      return "https://firebasestorage.googleapis.com/v0/b/loginsignupta-prototype.appspot.com/o/images%2Fdefault.webp?alt=media&token=0f99eb8a-be98-4f26-99b7-d71776562de9";
    }
  }
}
