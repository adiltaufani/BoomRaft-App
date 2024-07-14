import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/features/appbar_global.dart';
import 'package:flutter_project/features/auth/services/auth/google_auth_service.dart';
import 'package:flutter_project/features/search/widgets/search_page_widget.dart';
import 'package:flutter_project/features/wishlist/database/db_helper.dart';
import 'package:flutter_project/features/wishlist/model/wishlist_model.dart';
import 'package:flutter_project/features/notification/screens/notification_page.dart';
import 'package:flutter_project/features/profile/screens/setting_page.dart';
import 'package:flutter_project/features/home/widgets/side_menu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class WishlistScreen extends StatefulWidget {
  static const String routeName = '/wishlist-screen';
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<WishlistModel> _wishlist = [];
  bool isDataAvail = true;
  bool isLoading = true;

  Future<void> _fetchWishlist() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Jika user belum login, tampilkan pesan
      return; // Keluar dari metode fetchUserData
    }
    String user_id = user.uid;
    List<WishlistModel> wishlist =
        await WishlistDatabaseHelper.getWishlist(user_id);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _wishlist = wishlist;
      isLoading = false;
    });
  }

  @override
  void initState() {
    _fetchWishlist();
    super.initState();
  }

  final GoogleAuthService authService = GoogleAuthService();
  bool isTextFieldFocused = false;
  bool _isUp = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _toggleImage() {
    setState(() {
      _isUp = !_isUp;
      print(_isUp);
    });
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFDDFFF1), // Warna gradient awal
              Color(0xFFFFFFFF), // Warna gradient akhir
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(16, 10, 20, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/wishlist.png',
                    height: 30,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Wishlist',
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
            isLoading
                ? Expanded(
                    child: ListView.builder(
                      itemCount: 6, // Jumlah item shimmer
                      itemBuilder: (BuildContext context, int index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 128,
                            margin: const EdgeInsets.only(
                              top: 15,
                              left: 20,
                              right: 20,
                              bottom: 10,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                const SizedBox(width: 13),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 16.0,
                                        color: Colors.grey[300],
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        width: 150,
                                        height: 14.0,
                                        color: Colors.grey[300],
                                      ),
                                      const SizedBox(height: 5),
                                      Container(
                                        width: 100,
                                        height: 14.0,
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
                : isDataAvail
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: _wishlist.length,
                          itemBuilder: (BuildContext context, int index) {
                            String cleanedUrlFoto =
                                _wishlist[index].url_foto.replaceAll('\\', '');
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: 128,
                              margin: const EdgeInsets.only(
                                top: 15,
                                left: 20,
                                right: 20,
                                bottom: 10,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 20,
                                    right: 10,
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Konfirmasi Delete"),
                                              content: Text(
                                                  "Apakah kamu yakin ingin menghapus data wishlist?"),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text("Yes"),
                                                  onPressed: () async {
                                                    int id =
                                                        _wishlist[index].id!;
                                                    await WishlistDatabaseHelper
                                                        .deleteWishlist(id);
                                                    setState(() {
                                                      _fetchWishlist();
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text("No"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(8),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 28,
                                        key: UniqueKey(),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              image:
                                                  NetworkImage(cleanedUrlFoto),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 13,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              child: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                        maxWidth: 194),
                                                child: Text(
                                                  _wishlist[index]
                                                      .nama_penginapan,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.montserrat(
                                                    textStyle: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      letterSpacing: -0.5,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              _wishlist[index].address,
                                              style: GoogleFonts.montserrat(
                                                textStyle: const TextStyle(
                                                  color: Color(0xFF858585),
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: -0.6,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Text('Anda belum memiliki wishlist'),
                      ),
          ],
        ),
      ),
    );
  }

  String formatInteger(String numberString) {
    // Mengonversi string ke integer
    int number = int.parse(numberString);

    // Membuat objek NumberFormat untuk memformat angka
    NumberFormat formatter = NumberFormat("#,##0", "en_US");
    return formatter.format(number);
  }
}
