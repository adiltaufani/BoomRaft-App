import 'package:flutter_project/screens/home_screen.dart';
import 'package:flutter_project/services/fetch_data_service.dart';
import 'package:flutter_project/themes/theme.dart';
import 'package:flutter_project/variables.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_project/services/google_auth_service.dart';
import 'package:flutter_project/screens/notification_page.dart';
import 'package:flutter_project/widgets/side_menu.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = '/main-screen';
  const MainScreen({Key? key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  String firstname = '';
  String lastname = '';
  String email = '';
  String pp = '';
  bool isDataAvail = true;
  double latitude = 0.0;
  double longitude = 0.0;
  String kota = '';
  bool isData = false;

  String currentScreenName = 'HomeScreen';
  Widget _currentScreen = const HomeScreen();

  void _onMenuItemClicked(Widget screen) {
    setState(() {
      currentScreenName = screen.runtimeType.toString();
      _currentScreen =
          screen; // Mengubah screen berdasarkan item menu yang diklik
    });
  }

  @override
  void initState() {
    FetchDataService().fetchUserData(firstname, lastname, email, pp);
    runPHPCodeOnMainScreen();

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
      drawer: SideMenu(
        onMenuItemClicked: _onMenuItemClicked,
        currentScreenName: currentScreenName, // Kirim callback ke SideMenu
      ),
      drawerScrimColor: Colors.black38,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: AppTheme.darkBlue),
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
                setState(() {
                  // Mengubah _currentScreen menjadi NotificationPage saat tombol ditekan
                  _currentScreen = const NotificationPage();
                });
              },
              icon: Image.asset(
                'assets/images/notification.png',
                height: 34.0,
              ),
            ),
            //FOTO PROFIL

            // FutureBuilder<String?>(
            //     future: ProfileDataManager.getProfilePic(),
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return Shimmer.fromColors(
            //           baseColor: Colors.grey[300]!,
            //           highlightColor: Colors.grey[100]!,
            //           child: Container(
            //             width:
            //                 40, // Lebar dan tinggi yang sama untuk membuatnya bulat
            //             height: 40,
            //             decoration: BoxDecoration(
            //               color: Colors.white,
            //               shape: BoxShape.circle,
            //             ),
            //           ),
            //         );
            //       } else if (snapshot.hasError) {
            //         return Text('Error ${snapshot.error}');
            //       } else {
            //         return IconButton(
            //           onPressed: () {
            //             Navigator.pushNamed(context, SettingPage.routeName);
            //           },
            //           icon: CircleAvatar(
            //             radius: 26,
            //             backgroundColor: Colors.white30,
            //             backgroundImage: NetworkImage(snapshot.data!),
            //           ),
            //         );
            //       }
            //     }),
          ],
        ),
      ),
      body: _currentScreen,
    );
  }

  String formatInteger(String numberString) {
    // Mengonversi string ke integer
    int number = int.parse(numberString);

    // Membuat objek NumberFormat untuk memformat angka
    NumberFormat formatter = NumberFormat("#,##0", "en_US");
    return formatter.format(number);
  }

  // Future<void> fetchUserData() async {
  //   var user = FirebaseAuth.instance.currentUser;

  //   // Pastikan user sudah login
  //   if (user == null) {
  //     // Jika user belum login, tampilkan pesan
  //     print("Silakan login terlebih dahulu");
  //     return; // Keluar dari metode fetchUserData
  //   }

  //   var url = Uri.parse("${ipaddr}/ta_projek/crudtaprojek/view_data.php");
  //   String uid = user.uid;
  //   var response = await http.post(url, body: {
  //     "uid": uid,
  //   });

  //   var data = json.decode(response.body);
  //   if (data != null) {
  //     // Data berhasil diterima, tampilkan firstname dan lastname
  //     firstname = data['firstname'];
  //     lastname = data['lastname'];
  //     email = data['email'];
  //     String cleanedUrlFoto = data['profile_picture'].replaceAll('\\', '');
  //     pp = cleanedUrlFoto;
  //     print('Firstname: $firstname, Lastname: $lastname');
  //     // Lakukan apapun yang Anda ingin lakukan dengan data ini
  //     setState(() {
  //       isDataAvail = false;
  //       print(pp);
  //     });
  //   } else {
  //     print("Gagal mendapatkan data pengguna");
  //   }
  // }

  Future<void> runPHPCodeOnMainScreen() async {
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
