import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/contactus_screen.dart';
import 'package:flutter_project/screens/login_screen.dart';
import 'package:flutter_project/services/google_auth_service.dart';
import 'package:flutter_project/services/user_services.dart';
import 'package:flutter_project/themes/theme.dart';
import 'package:flutter_project/screens/home_screen.dart';
import 'package:flutter_project/screens/notification_page.dart';
import 'package:flutter_project/screens/transaction_screen.dart';
import 'package:flutter_project/screens/setting_page.dart';
import 'package:flutter_project/variables.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class SideMenu extends StatefulWidget {
  final Function(Widget) onMenuItemClicked;
  final String currentScreenName; // Terima currentScreenName dari parent

  SideMenu(
      {super.key,
      required this.onMenuItemClicked,
      required this.currentScreenName});

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
  Future<Map<String, dynamic>>? userProfile;
  Map<String, dynamic> userData = {};
  @override
  void initState() {
    userProfile = UserServices().getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildDrawer(context);
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            userData = snapshot.data!;
          }
          return buildDrawer(context);
        });
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
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
                          color: AppTheme.darkYellow,
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
                          color: AppTheme.darkYellow,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  )
                : Stack(
                    children: [
                      Container(
                        color: AppTheme.darkBlue,
                        height: 88,
                        width: 1000,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, SettingPage.routeName);
                          },
                          leading: const CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.white30,
                            backgroundImage:
                                AssetImage('assets/images/profile.png'),
                          ),
                          title: Text(
                            '${userData['name'] ?? "Loading"} ',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: AppTheme.darkYellow,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                          subtitle: Text(
                            '${userData['email'] ?? "Loading"}',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: AppTheme.darkYellow,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildListTile(
                    context,
                    title: 'Home',
                    screenWidget: HomeScreen(),
                    icon: Icons.home_filled,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 40.0),
                    child: Divider(color: AppTheme.darkBlue),
                  ),
                  _buildListTile(
                    context,
                    title: 'Notification',
                    screenWidget: NotificationPage(),
                    icon: Icons.notifications_rounded,
                  ),
                  _buildListTile(
                    context,
                    title: 'Transaction',
                    screenWidget: TransactionScreen(),
                    icon: Icons.notes_rounded,
                  ),
                  _buildListTile(
                    context,
                    title: 'Contact Us',
                    screenWidget: ContactusScreen(),
                    icon: Icons.message_rounded,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 40.0),
                    child: Divider(color: AppTheme.darkBlue),
                  ),
                  _buildListTile(
                    context,
                    title: 'Setting',
                    screenWidget: SettingPage(),
                    icon: Icons.settings_rounded,
                  ),
                  _buildListTile(
                    context,
                    title: 'Help',
                    screenWidget: SettingPage(),
                    icon: Icons.help_outline_rounded,
                  ),
                  _buildListTile(
                    context,
                    title: 'Logout',
                    screenWidget: LoginScreen(),
                    icon: Icons.login_rounded,
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

  Widget _buildListTile(
    BuildContext context, {
    required String title,
    required Widget screenWidget,
    IconData? icon,
    String? iconAsset,
    VoidCallback? onTap,
  }) {
    // Ambil currentScreenName dari widget
    bool isSelected =
        widget.currentScreenName == screenWidget.runtimeType.toString();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 8),
            height: 54,
            width: 218,
            decoration: BoxDecoration(
                color: isSelected ? AppTheme.darkYellow : Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    bottomRight: Radius.circular(24))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: ListTile(
              onTap: onTap ??
                  () {
                    widget.onMenuItemClicked(screenWidget);
                    Future.delayed(const Duration(milliseconds: 100), () {
                      Navigator.pop(context);
                    });
                  },
              leading: icon != null
                  ? SizedBox(
                      height: 36,
                      width: 36,
                      child: Icon(
                        icon,
                        color: AppTheme.darkBlue,
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
                    color: isSelected ? AppTheme.darkBlue : AppTheme.darkBlue,
                    fontSize: isSelected ? 20 : 18,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> getImageUrl(String imagePath) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child(imagePath);
      String imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (error) {
      print("Error: $error");
      return "https://firebasestorage.googleapis.com/v0/b/loginsignupta-prototype.appspot.com/o/images%2Fdefault.webp?alt=media&token=0f99eb8a-be98-4f26-99b7-d71776562de9";
    }
  }
}
