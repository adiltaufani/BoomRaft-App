import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_project/features/appbar_global.dart';
import 'package:flutter_project/features/auth/services/auth/google_auth_service.dart';
import 'package:flutter_project/features/notification/screens/notification_page.dart';
import 'package:flutter_project/features/payment/widgets/transaction_recent.dart';
import 'package:flutter_project/features/profile/screens/setting_page.dart';
import 'package:flutter_project/features/home/widgets/side_menu.dart';
import 'package:flutter_project/features/payment/widgets/transaction_ongoing.dart';
import 'package:flutter_project/features/search/widgets/search_page_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionScreen extends StatefulWidget {
  static const String routeName = '/transaction-screen';
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  late double _rating;

  final GoogleAuthService authService = GoogleAuthService();
  bool isTextFieldFocused = false;
  bool _isTextVisible = false;
  bool _isconstscrolled = false;
  double _initialRating = 0;
  bool _isUp = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _toggleDetail() {
    setState(() {
      _isUp = !_isUp;

      if (!_isTextVisible) {
        _isconstscrolled = !_isconstscrolled;
        Timer(const Duration(milliseconds: 200), () {
          _textvis();
        });
      } else {
        _isTextVisible = !_isTextVisible;
        Timer(const Duration(milliseconds: 0), () {
          _constvis();
        });
      }
    });
  }

  void _textvis() {
    setState(() {
      _isTextVisible = !_isTextVisible;
    });
  }

  void _constvis() {
    setState(() {
      _isconstscrolled = !_isconstscrolled;
    });
  }

  @override
  void initState() {
    super.initState();
    _rating = _initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideMenu(),
      drawerScrimColor: Colors.black38,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF50B498),
            ),
          ),
          title: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, SearchPageWidget.routeName);
            },
            child: Container(
              width: double.infinity,
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.search,
                      color: Colors.black26,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Search..',
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          color: Colors.black26,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 30.0,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, NotificationPage.routeName);
              },
              icon: Image.asset(
                'assets/images/notification.png',
                height: 34.0,
              ),
            ),
            FutureBuilder<String?>(
                future: ProfileDataManager.getProfilePic(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SettingPage.routeName);
                      },
                      icon: CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.white30,
                        backgroundImage: NetworkImage(snapshot.data!),
                      ),
                    );
                  } else {
                    return Text('no data');
                  }
                }),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFD2E9FF), // Warna gradient awal
              Color(0xFFFFFFFF), // Warna gradient akhir
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/bookit.png',
                        height: 24,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 10, 20, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/transaction.png',
                        height: 30,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Transaction',
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'On Going',
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.4,
                          ),
                        ),
                      ),
                      TransactionOngoing(),
                      Text(
                        'Recent',
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.4,
                          ),
                        ),
                      ),
                      TransactionRecent(),
                      SizedBox(
                        height: 20,
                      ),
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
