import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_project/appbar_global.dart';
import 'package:flutter_project/screens/main_screen.dart';
import 'package:flutter_project/services/google_auth_service.dart';
import 'package:flutter_project/screens/notification_page.dart';
import 'package:flutter_project/themes/theme.dart';
import 'package:flutter_project/widgets/transaction_recent.dart';
import 'package:flutter_project/screens/setting_page.dart';
import 'package:flutter_project/widgets/side_menu.dart';
import 'package:flutter_project/widgets/transaction_ongoing.dart';
import 'package:flutter_project/zzunused/search/widgets/search_page_widget.dart';
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: AppTheme.backgroundColor),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 10, 20, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.notes_rounded,
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
