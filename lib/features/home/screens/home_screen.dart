import 'dart:convert';
import 'package:flutter_project/variables.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_project/features/appbar_global.dart';
import 'package:flutter_project/features/auth/services/auth/google_auth_service.dart';
import 'package:flutter_project/features/notification/screens/notification_page.dart';
import 'package:flutter_project/features/profile/screens/setting_page.dart';
import 'package:flutter_project/features/home/widgets/side_menu.dart';
import 'package:flutter_project/features/home/widgets/home_bar.dart';
import 'package:flutter_project/features/search/widgets/search_page_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String firstname = '';
  String lastname = '';
  String email = '';
  String pp = '';
  bool isDataAvail = true;
  double latitude = 0.0;
  double longitude = 0.0;
  String kota = '';
  bool isData = false;
  @override
  void initState() {
    fetchUserData();
    runPHPCodeOnHomeScreen();
    getLocation();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  final GoogleAuthService authService = GoogleAuthService();
  bool isTextFieldFocused = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
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
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width:
                            40, // Lebar dan tinggi yang sama untuk membuatnya bulat
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error ${snapshot.error}');
                  } else {
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
                  }
                }),
          ],
        ),
      ),
      body: Material(
        child: Container(
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
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Location',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.6,
                            ),
                          ),
                        ),
                        isData
                            ? Text(
                                '${kota}',
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 150,
                                  height: 20,
                                  color: Colors.white,
                                ),
                              ),
                      ],
                    ),
                    Image.asset(
                      'assets/images/logo_pineustilu.png',
                      height: 44,
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.black12,
                height: 0.5,
              ),
              Container(
                child: Align(
                  child: TabBar(
                    labelPadding: const EdgeInsets.only(left: 0, right: 40),
                    controller: _tabController,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black26,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.label,
                    padding: const EdgeInsets.only(bottom: 10),
                    indicator: UnderlineTabIndicator(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 27, 94, 32), width: 4.6),
                        borderRadius: BorderRadius.circular(10)),
                    dividerColor: Colors.black12,
                    tabs: [
                      Tab(
                        child: Text(
                          'Rafting',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Offroad',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Paintball',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    HomeBar(
                      tipe: 'readapartement.php',
                      user_latitude: latitude,
                      user_longitude: longitude,
                    ),
                    HomeBar(
                      tipe: 'readhotel.php',
                      user_latitude: latitude,
                      user_longitude: longitude,
                    ),
                    HomeBar(
                      tipe: 'readvilla.php',
                      user_latitude: latitude,
                      user_longitude: longitude,
                    ),
                  ],
                ),
              ),
            ],
          ),
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
      pp = cleanedUrlFoto;
      print('Firstname: $firstname, Lastname: $lastname');
      // Lakukan apapun yang Anda ingin lakukan dengan data ini
      setState(() {
        isDataAvail = false;
        print(pp);
      });
    } else {
      print("Gagal mendapatkan data pengguna");
    }
  }

  Future<void> runPHPCodeOnHomeScreen() async {
    final url =
        '${ipaddr}/ta_projek/crudtaprojek/update_harga_termurah.php'; // Ganti dengan URL endpoint PHP Anda
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Permintaan berhasil
        print('PHP code executed successfully.');
      } else {
        // Terjadi kesalahan
        print('Failed to execute PHP code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while executing PHP code: $e');
    }
  }

  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // Handle denied permission
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    latitude = position.latitude;
    longitude = position.longitude;
    print(latitude);
    print(longitude);
    if (latitude != 0) {
      getCityFromCoordinates(latitude, longitude);
    }

    // Gunakan latitude dan longitude sesuai kebutuhan Anda
  }

  void getCityFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      print(place.locality);
      kota = place.locality.toString(); // Ini adalah nama kota
      setState(() {
        isData = true;
      });
    } catch (e) {
      print("Error: $e");
    }
  }
}

// ignore: must_be_immutable
class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;
  CircleTabIndicator({
    required this.color,
    required this.radius,
  });
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;
  _CirclePainter({
    required this.color,
    required this.radius,
  });
  @override
  void paint(
    Canvas canvas,
    Offset offset,
    ImageConfiguration configuration,
  ) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2, configuration.size!.height - radius);

    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}
