import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project/appbar_global.dart';
import 'package:flutter_project/services/google_auth_service.dart';
import 'package:flutter_project/services/notif_db_helper.dart';
import 'package:flutter_project/models/notification_model.dart';
import 'package:flutter_project/screens/setting_page.dart';
import 'package:flutter_project/themes/theme.dart';
import 'package:flutter_project/widgets/side_menu.dart';
import 'package:flutter_project/zzunused/search/widgets/search_page_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class NotificationPage extends StatefulWidget {
  static const String routeName = '/notification-page';
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final GoogleAuthService authService = GoogleAuthService();
  List<NotifModel> _notifications = [];
  bool isTextFieldFocused = false;
  bool _isDataAvail = false;
  bool isLoading = true;
  List<bool> booleanList = List<bool>.filled(10, false);
  List<bool> isUp = List<bool>.filled(10, false);
  List<bool> isConstScrolled = List<bool>.filled(10, false);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _toggleImage(int index) {
    setState(() {
      isUp[index] = !isUp[index];

      if (!booleanList[index]) {
        isConstScrolled[index] = !isConstScrolled[index];
        Timer(const Duration(milliseconds: 200), () {
          _textvis(index);
        });
      } else {
        booleanList[index] = !booleanList[index];
        Timer(const Duration(milliseconds: 0), () {
          _constvis(index);
        });
      }
    });
  }

  void _textvis(int index) {
    setState(() {
      booleanList[index] = !booleanList[index];
    });
  }

  void _constvis(int index) {
    setState(() {
      isConstScrolled[index] = !isConstScrolled[index];
    });
  }

  @override
  void initState() {
    _fetchNotifications();
    super.initState();
  }

  Future<void> _fetchNotifications() async {
    var user = FirebaseAuth.instance.currentUser;

    // Pastikan user sudah login
    if (user == null) {
      // Jika user belum login, tampilkan pesan
      return; // Keluar dari metode fetchUserData
    }
    String user_uid = user.uid;
    List<NotifModel> notifications =
        await NotificationDatabaseHelper.getNotifications(user_uid);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _notifications = notifications;
      isLoading = false;
    });
    if (_notifications.isNotEmpty) {
      _isDataAvail = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppTheme.backgroundColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Untuk mengatur jarak antara teks dan ikon
              children: [
                Row(
                  children: [
                    const Icon(Icons.notifications_rounded),
                    const SizedBox(width: 12),
                    Text(
                      'Notification',
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
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 28,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Konfirmasi Delete"),
                          content: const Text(
                              "Apakah kamu yakin ingin menghapus semua notifikasi?"),
                          actions: <Widget>[
                            TextButton(
                              child: const Text("Yes"),
                              onPressed: () async {
                                await NotificationDatabaseHelper
                                    .deleteAllNotifications();
                                setState(() {
                                  _isDataAvail = false;
                                });
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text("No"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          isLoading
              ? Expanded(
                  child: ListView.builder(
                    itemCount: 3, // Jumlah item shimmer
                    itemBuilder: (BuildContext context, int index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 106,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(20, 20, 10, 10),
                                width: 60,
                                height: 60,
                                color: Colors.grey[300],
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(3, 20, 8, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 220,
                                      height: 14,
                                      color: Colors.grey[300],
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      width: 180,
                                      height: 12,
                                      color: Colors.grey[300],
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      width: 100,
                                      height: 12,
                                      color: Colors.grey[300],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : _isDataAvail
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: _notifications.length,
                        itemBuilder: (BuildContext context, int index) {
                          String formattedDate = _notifications[index]
                              .time
                              .toIso8601String()
                              .substring(0, 10);
                          DateTime date = DateTime.parse(formattedDate);
                          String realDate =
                              DateFormat('dd MMMM yyyy').format(date);
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      height:
                                          isConstScrolled[index] ? 228 : 106,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  20, 20, 10, 10),
                                              child: Image.asset(
                                                  'assets/images/mail.png')),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                3, 20, 8, 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        booleanList[index]
                                                            ? Container(
                                                                constraints:
                                                                    const BoxConstraints(
                                                                        maxWidth:
                                                                            220),
                                                                child: Text(
                                                                  _notifications[
                                                                          index]
                                                                      .title,
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                    textStyle:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      letterSpacing:
                                                                          -0.6,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : Container(
                                                                constraints:
                                                                    const BoxConstraints(
                                                                        maxWidth:
                                                                            220),
                                                                child: Text(
                                                                  _notifications[
                                                                          index]
                                                                      .title,
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                    textStyle:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      letterSpacing:
                                                                          -0.6,
                                                                    ),
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {});
                                                          },
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        8.0),
                                                            child:
                                                                AnimatedSwitcher(
                                                                    duration: const Duration(
                                                                        milliseconds:
                                                                            300),
                                                                    child: booleanList[
                                                                            index]
                                                                        ? Container(
                                                                            constraints:
                                                                                const BoxConstraints(maxWidth: 220),
                                                                            child:
                                                                                Text(
                                                                              _notifications[index].body,
                                                                              style: GoogleFonts.montserrat(
                                                                                textStyle: const TextStyle(
                                                                                  color: Colors.black54,
                                                                                  fontSize: 10,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  letterSpacing: -0.6,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : const SizedBox() // or use a Container with a very small height
                                                                    ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(top: 2),
                                                          constraints:
                                                              const BoxConstraints(
                                                                  maxWidth:
                                                                      240),
                                                          child: Text(
                                                            "Booking ID ${_notifications[index].id}",
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              textStyle:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                letterSpacing:
                                                                    -0.6,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(width: 20),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 12,
                                      bottom: 8,
                                      child: Text(
                                        '${realDate}',
                                        style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: -0.6,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 12,
                                      top: 20,
                                      child: InkWell(
                                        onTap: () {
                                          _toggleImage(index);
                                        },
                                        borderRadius: BorderRadius.circular(
                                            8), // Adjust the border radius as needed
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              8.0), // Adjust the padding as needed
                                          child: AnimatedSwitcher(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            child: isUp[index]
                                                ? Image.asset(
                                                    'assets/images/arrow_up.png',
                                                    height: 10,
                                                    key: UniqueKey(),
                                                  )
                                                : Image.asset(
                                                    'assets/images/arrow_down.png',
                                                    height: 10,
                                                    key: UniqueKey(),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text('kamu belum memiliki pesan'),
                    ),
        ],
      ),
    );
  }
}
