import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/booking_page.dart';
import 'package:flutter_project/zzunused/nearfromyou/screens/near_from_you.dart';
import 'package:flutter_project/widgets/typeof_btn.dart';
import 'package:flutter_project/zzunused/wishlist/database/db_helper.dart';
import 'package:flutter_project/zzunused/wishlist/model/wishlist_model.dart';
import 'package:flutter_project/variables.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class HomeBar extends StatefulWidget {
  String tipe;
  double user_latitude;
  double user_longitude;
  HomeBar({
    super.key,
    required this.tipe,
    required this.user_latitude,
    required this.user_longitude,
  });

  @override
  State<HomeBar> createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> {
  // ignore: non_constant_identifier_names
  List _Listdata = [];
  List _ListdataNear = [];
  bool _isLoading = true;

  Future _getdata() async {
    try {
      final response = await http.get(
        Uri.parse('${ipaddr}/ta_projek/crudtaprojek/${widget.tipe}'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _Listdata = data;
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  Future _getdataNear() async {
    try {
      final response = await http.get(
        Uri.parse(
            '${ipaddr}/ta_projek/crudtaprojek/fetch_property_near.php?user_latitude=${widget.user_latitude}&user_longitude=${widget.user_longitude}&tipe=house'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _ListdataNear = data;
        });
        print(_ListdataNear);
      }
    } catch (e) {
      rethrow;
    }
  }

  void fetchData() async {
    await Future.delayed(Duration(seconds: 2)); // Menambahkan delay 2 detik
    await _getdata();
    await _getdataNear();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  List<bool> booleanList = List<bool>.filled(20, false);
  List<bool> triggerList = List<bool>.filled(20, false);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
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
            Container(
              margin: const EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Near from you',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.6,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, NearFromYou.routeName);
                    },
                    child: Text(
                      'See more',
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          color: Color(0xFF858585),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 300,
              width: double.infinity,
              child: _isLoading
                  ? ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 275,
                            width: 240,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: _ListdataNear.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        String cleanedUrlFoto = _ListdataNear[index]['url_foto']
                            .replaceAll('\\', '');
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingPage(
                                  locationName: _ListdataNear[index]
                                      ['nama_penginapan'],
                                  locationAddress: _ListdataNear[index]
                                      ['alamat'],
                                  jumlah_reviewer: _ListdataNear[index]
                                      ['jumlah_reviewer'],
                                  url_foto: cleanedUrlFoto,
                                  hotel_id: _ListdataNear[index]['id'],
                                  latitude: _ListdataNear[index]['latitude'],
                                  longitude: _ListdataNear[index]['longitude'],
                                  sellersEmail: 'tes',
                                  sellersFoto:
                                      'https://th.bing.com/th/id/OIP.QjynegEfQVPq5kIEuX9fWQHaFj?w=263&h=197&c=7&r=0&o=5&pid=1.7',
                                  sellersName: 'tes',
                                  sellersUid: 'tes',
                                  sellersid: '4',
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 275,
                                width: 240,
                                padding: const EdgeInsets.all(0),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: NetworkImage(cleanedUrlFoto),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Container(
                                width: 240,
                                height: 275,
                                padding: const EdgeInsets.all(0),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      20), // Adjust the radius as needed
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.center,
                                    colors: [
                                      Colors.black.withOpacity(
                                          0.74), // Opacity untuk membuatnya lebih gelap
                                      Colors
                                          .transparent, // Untuk memberikan transisi ke gambar
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 30,
                                left: 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _ListdataNear[index]['nama_penginapan'],
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      _ListdataNear[index]['alamat'],
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 30,
                                right: 20,
                                child: GestureDetector(
                                  onTap: () {
                                    fetchData(); // Memulai pengambilan data
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        // Membuat dialog
                                        return FutureBuilder(
                                          future: Future.delayed(Duration(
                                              seconds:
                                                  2)), // Menunda dialog selama 2 detik
                                          builder: (BuildContext context,
                                              AsyncSnapshot<dynamic> snapshot) {
                                            // Menampilkan pesan dialog
                                            return AlertDialog(
                                              title: Text(
                                                  "Data Berhasil Disimpan"),
                                              content: Text(
                                                  "Property Dimasukan ke Wishlist"),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Menutup dialog
                                                  },
                                                  child: Text("OK"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    );
                                    setState(() {
                                      triggerList[index] = !triggerList[index];
                                      if (triggerList[index] == true) {
                                        wishlistTap(index);
                                      }
                                    });
                                  },
                                  child: triggerList[index]
                                      ? Transform.scale(
                                          scale:
                                              1.5, // Besar ikon 1.5 kali lipat
                                          child: Icon(
                                            Icons.bookmark_rounded,
                                            color: Colors.blueGrey,
                                          ),
                                        )
                                      : Transform.scale(
                                          scale:
                                              1.5, // Besar ikon 1.5 kali lipat
                                          child: Icon(
                                            Icons.bookmark_rounded,
                                            color: Colors.black12,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Best for you',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.6,
                      ),
                    ),
                  ),
                  Text(
                    'See more',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Color(0xFF858585),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _isLoading ? 5 : _Listdata.length,
              itemBuilder: (BuildContext context, int index) {
                if (_isLoading) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      margin: const EdgeInsets.only(
                        top: 15,
                        left: 20,
                        right: 20,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                    ),
                  );
                } else {
                  String cleanedUrlFoto =
                      _Listdata[index]['url_foto'].replaceAll('\\', '');
                  String cleanedUrlFotoSellers =
                      _Listdata[index]['sellers_foto'].replaceAll('\\', '');
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookingPage(
                                    locationName: _Listdata[index]
                                        ['nama_penginapan'],
                                    locationAddress: _Listdata[index]['alamat'],
                                    jumlah_reviewer: _Listdata[index]
                                        ['jumlah_reviewer'],
                                    url_foto: cleanedUrlFoto,
                                    hotel_id: _Listdata[index]['id'],
                                    latitude: _Listdata[index]['latitude'],
                                    longitude: _Listdata[index]['longitude'],
                                    sellersid: _Listdata[index]['sellers_id'],
                                    sellersName: _Listdata[index]['nama'],
                                    sellersEmail: _Listdata[index]['email'],
                                    sellersFoto: cleanedUrlFotoSellers,
                                    sellersUid: _Listdata[index]['uid'],
                                  )));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      margin: const EdgeInsets.only(
                        top: 15,
                        left: 20,
                        right: 20,
                        bottom: 10,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: NetworkImage(cleanedUrlFoto),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(
                            width: 13,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    _Listdata[index]['nama_penginapan'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: -0.5,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Rp.',
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 8, 59, 134),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Text(
                                      formatInteger(_Listdata[index]
                                              ['harga_termurah']
                                          .toString()), // Mengonversi integer ke string sebelum memanggil formatInteger
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 8, 59, 134),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Text(
                                      ' / night',
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 8, 59, 134),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/bedroom.png',
                                      height: 24.0,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const SizedBox(
                                      width: 3.5,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Image.asset(
                                      'assets/images/bathroom.png',
                                      height: 24.0,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const SizedBox(
                                      width: 3.5,
                                    ),
                                    Text(
                                      'Bathroom',
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          color: Color(0xFF858585),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.6,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              fetchData(); // Memulai pengambilan data
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // Membuat dialog
                                  return FutureBuilder(
                                    future: Future.delayed(Duration(
                                        seconds:
                                            2)), // Menunda dialog selama 2 detik
                                    builder: (BuildContext context,
                                        AsyncSnapshot<dynamic> snapshot) {
                                      // Menampilkan pesan dialog
                                      return AlertDialog(
                                        title: Text("Data Berhasil Disimpan"),
                                        content: Text(
                                            "Property Dimasukan ke Wishlist"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Menutup dialog
                                            },
                                            child: Text("OK"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                              setState(() {
                                booleanList[index] = !booleanList[index];
                                if (booleanList[index] == true) {
                                  wishlistTap(index);
                                }
                              });
                            },
                            child: booleanList[index]
                                ? Transform.scale(
                                    scale: 1.5, // Besar ikon 1.5 kali lipat
                                    child: Icon(
                                      Icons.bookmark_rounded,
                                      color: Colors.blueGrey,
                                    ),
                                  )
                                : Transform.scale(
                                    scale: 1.5, // Besar ikon 1.5 kali lipat
                                    child: Icon(
                                      Icons.bookmark_rounded,
                                      color: Colors.black12,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void wishlistTap(int index) {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Jika user belum login, tampilkan pesan
      return; // Keluar dari metode fetchUserData
    }
    String user_id = user.uid;
    String nama_penginapan = _Listdata[index]['nama_penginapan'];
    String hotel_id = _Listdata[index]['id'];
    String alamat = _Listdata[index]['alamat'];
    String url_foto = _Listdata[index]['url_foto'];
    WishlistModel wishlistModel = WishlistModel(
        nama_penginapan: nama_penginapan,
        hotel_id: hotel_id,
        address: alamat,
        uid: user_id,
        url_foto: url_foto);
    WishlistDatabaseHelper.insertWishlist(wishlistModel);
  }

  String formatInteger(String numberString) {
    // Mengonversi string ke integer
    int number = int.parse(numberString);

    // Membuat objek NumberFormat untuk memformat angka
    NumberFormat formatter = NumberFormat("#,##0", "en_US");
    return formatter.format(number);
  }
}
