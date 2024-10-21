// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_project/screens/booking_page.dart';
// import 'package:flutter_project/variables.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';

// // ignore: must_be_immutable
// class SearchHouse extends StatefulWidget {
//   final String terusan;
//   final String terusan2;
//   String? tanggal_checkin;
//   String? tanggal_checkout;
//   double? hargaAwal;
//   double? hargaAkhir;
//   int? bintang;
//   bool? wifi;
//   bool? kolamRenang;
//   bool? parkir;
//   bool? restoran;
//   bool? gym;
//   bool? resepsionis24jam;

//   SearchHouse({
//     required this.terusan,
//     required this.terusan2,
//     this.tanggal_checkin,
//     this.tanggal_checkout,
//     this.hargaAkhir,
//     this.hargaAwal,
//     this.bintang,
//     this.wifi,
//     this.kolamRenang,
//     this.parkir,
//     this.restoran,
//     this.gym,
//     this.resepsionis24jam,
//   });

//   @override
//   State<SearchHouse> createState() => _SearchHouseState();
// }

// class _SearchHouseState extends State<SearchHouse> {
//   late List<Hotel> hotels = [];

//   // Future<void> _getData() async {
//   //   if (widget.hargaAwal == null) {
//   //     try {
//   //       final response = await http.get(
//   //         Uri.parse(
//   //             'http://172.20.10.6/ta_projek/crudtaprojek/read_kota.php?table=${widget.terusan}&kota=${widget.terusan2}'),
//   //       );
//   //       if (response.statusCode == 200) {
//   //         final data = jsonDecode(response.body);
//   //         if (data.isEmpty) {
//   //           setState(() {
//   //             _Listdata = [];
//   //             _errorMessage = "Data tidak ditemukan";
//   //           });
//   //         } else {
//   //           setState(() {
//   //             _Listdata = data;
//   //             _errorMessage = null;
//   //           });
//   //         }
//   //       } else {
//   //         throw Exception('Gagal mengambil data');
//   //       }
//   //     } catch (e) {
//   //       print(e);
//   //       setState(() {
//   //         _errorMessage = "Gagal mengambil data";
//   //       });
//   //     }
//   //     // filter_kota_byharga.php?table=house&kota=Jakarta&harga_awal=54000&harga_akhir=57000
//   //   }
//   // }

//   Future<void> fetchHotels({
//     String? table,
//     String? kota,
//     String? tanggal_checkin,
//     String? tanggal_checkout,
//     double? hargaMin,
//     double? hargaMax,
//     int? bintang,
//     bool? wifi,
//     bool? kolamRenang,
//     bool? parkir, // Properti baru untuk parkir
//     bool? restoran, // Properti baru untuk restoran
//     bool? pusatKebugaran, // Properti baru untuk pusat kebugaran
//     bool? resepsionis24Jam, // Properti baru untuk resepsionis 24 jam
//   }) async {
//     final url = Uri.parse(
//         '${ipaddr}/ta_projek/crudtaprojek/tes_filter_new.php?'); // Ganti dengan URL API Anda

//     Map<String, dynamic> queryParams = {};
//     if (table != null) queryParams['tipe'] = table.toString();
//     if (kota != null) queryParams['kota'] = kota.toString();
//     if (tanggal_checkin != null)
//       queryParams['tanggal_checkin'] = tanggal_checkin.toString();
//     if (tanggal_checkout != null)
//       queryParams['tanggal_checkout'] = tanggal_checkout.toString();
//     if (hargaMin != null) queryParams['harga_min'] = hargaMin.toString();
//     if (hargaMax != null) queryParams['harga_max'] = hargaMax.toString();
//     if (bintang != null) queryParams['rating'] = bintang.toString();
//     if (wifi == true) queryParams['wifi'] = '1';
//     if (kolamRenang == true) queryParams['kolam_renang'] = '1';
//     if (parkir == true)
//       queryParams['parkir'] = '1'; // Query parameter untuk parkir
//     if (restoran == true)
//       queryParams['restoran'] = '1'; // Query parameter untuk restoran
//     if (pusatKebugaran == true)
//       queryParams['pusat_kebugaran'] =
//           '1'; // Query parameter untuk pusat kebugaran
//     if (resepsionis24Jam == true)
//       queryParams['resepsionis_24_jam'] =
//           '1'; // Query parameter untuk resepsionis 24 jam

//     final urlWithParams = url.replace(queryParameters: queryParams);

//     final response = await http.get(urlWithParams);
//     print(urlWithParams);

//     if (response.statusCode == 200) {
//       print(response.body);
//       List<dynamic> data = json.decode(response.body);
//       setState(() {
//         hotels = data.map((json) => Hotel.fromJson(json)).toList();
//       });
//     } else {
//       setState(() {
//         hotels.clear();
//       });
//       throw Exception('Failed to load hotels');
//     }
//   }

//   @override
//   void initState() {
//     _loadHotels();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         width: double.infinity,
//         height: 570,
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: hotels
//                     .length, // Ganti dengan jumlah item yang Anda inginkan
//                 itemBuilder: (BuildContext context, int index) {
//                   String cleanedUrlFoto =
//                       hotels[index].url_foto.replaceAll('\\', '');
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => BookingPage(
//                                     locationName: hotels[index].nama_penginapan,
//                                     locationAddress: hotels[index].alamat,
//                                     jumlah_reviewer:
//                                         hotels[index].jumlah_reviewer,
//                                     url_foto: cleanedUrlFoto,
//                                     hotel_id: hotels[index].id.toString(),
//                                     latitude: hotels[index].latitude,
//                                     longitude: hotels[index].longitude,
//                                     tanggalAwal: widget.tanggal_checkin,
//                                     tanggalAkhir: widget.tanggal_checkout,
//                                     sellersEmail: 'tes',
//                                     sellersFoto:
//                                         'https://th.bing.com/th/id/OIP.QjynegEfQVPq5kIEuX9fWQHaFj?w=263&h=197&c=7&r=0&o=5&pid=1.7',
//                                     sellersName: 'tes',
//                                     sellersUid: 'tes',
//                                     sellersid: '4',
//                                   )));
//                     },
//                     child: Container(
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height * 0.173,
//                       margin: const EdgeInsets.only(
//                           top: 15,
//                           left: 20,
//                           right: 20), // Atur margin jika diperlukan
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(25.0),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               width: 150,
//                               height: 150,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 image: DecorationImage(
//                                     image: NetworkImage(cleanedUrlFoto),
//                                     fit: BoxFit.cover),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 13,
//                           ),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Flexible(
//                                       child: Text(
//                                         hotels[index].nama_penginapan,
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: GoogleFonts.montserrat(
//                                           textStyle: const TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 16.0,
//                                             fontWeight: FontWeight.w600,
//                                             letterSpacing: -0.5,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 0,
//                                     )
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       hotels[index].rating.toString(),
//                                       style: GoogleFonts.montserrat(
//                                         textStyle: const TextStyle(
//                                           color: Colors.blue,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     Text(
//                                       '/',
//                                       style: GoogleFonts.montserrat(
//                                         textStyle: const TextStyle(
//                                           color: Colors.grey,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 4,
//                                     ),
//                                     Text(
//                                       '(',
//                                       style: GoogleFonts.montserrat(
//                                         textStyle: const TextStyle(
//                                           color: Colors.grey,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ),
//                                     Text(
//                                       hotels[index].jumlah_reviewer.toString(),
//                                       style: GoogleFonts.montserrat(
//                                         textStyle: const TextStyle(
//                                           color: Colors.grey,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ),
//                                     Text(
//                                       ')',
//                                       style: GoogleFonts.montserrat(
//                                         textStyle: const TextStyle(
//                                           color: Colors.grey,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     Icon(
//                                       Icons.star,
//                                       size: 15,
//                                       color: Colors.grey,
//                                     ),
//                                   ],
//                                 ),
//                                 Text(
//                                   hotels[index].alamat,
//                                   style: GoogleFonts.montserrat(
//                                     textStyle: const TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 15,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       'Rp.',
//                                       style: GoogleFonts.montserrat(
//                                         textStyle: TextStyle(
//                                             color:
//                                                 Color.fromARGB(255, 8, 59, 134),
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                     Text(
//                                       formatInteger(hotels[index]
//                                           .harga
//                                           .toString()), // Mengonversi integer ke string sebelum memanggil formatInteger
//                                       style: GoogleFonts.montserrat(
//                                         textStyle: TextStyle(
//                                             color:
//                                                 Color.fromARGB(255, 8, 59, 134),
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _loadHotels() async {
//     try {
//       await fetchHotels(
//         table: widget.terusan,
//         kota: widget.terusan2,
//         tanggal_checkin: widget.tanggal_checkin,
//         tanggal_checkout: widget.tanggal_checkout,
//         hargaMin: widget.hargaAwal,
//         hargaMax: widget.hargaAkhir,
//         bintang: widget.bintang,
//         wifi: widget.wifi,
//         kolamRenang: widget.kolamRenang,
//         parkir: widget.parkir,
//         restoran: widget.restoran,
//         pusatKebugaran: widget.gym,
//         resepsionis24Jam: widget.resepsionis24jam,
//       );
//       print('try load berhasil');
//     } catch (e) {
//       print(e);
//       // Handle error
//     }
//   }
// }

// class Hotel {
//   final int id;
//   final String url_foto;
//   final String nama_penginapan;
//   final int rating;
//   final String jumlah_reviewer;
//   final String alamat;
//   final String latitude;
//   final String longitude;
//   final double harga;
//   final String kota;
//   final String tipe;
//   final bool wifi;
//   final bool kolamRenang;
//   final bool parkir; // Properti baru untuk parkir
//   final bool restoran; // Properti baru untuk restoran
//   final bool pusatKebugaran; // Properti baru untuk pusat kebugaran
//   final bool resepsionis24Jam; // Properti baru untuk resepsionis 24 jam

//   Hotel({
//     required this.id,
//     required this.url_foto,
//     required this.nama_penginapan,
//     required this.rating,
//     required this.jumlah_reviewer,
//     required this.alamat,
//     required this.latitude,
//     required this.longitude,
//     required this.harga,
//     required this.kota,
//     required this.tipe,
//     required this.wifi,
//     required this.kolamRenang,
//     required this.parkir, // Properti baru
//     required this.restoran, // Properti baru
//     required this.pusatKebugaran, // Properti baru
//     required this.resepsionis24Jam, // Properti baru
//   });

//   factory Hotel.fromJson(Map<String, dynamic> json) {
//     return Hotel(
//       id: int.parse(json['id']),
//       url_foto: json['url_foto'],
//       nama_penginapan: json['nama_penginapan'],
//       rating: int.parse(json['rating']),
//       jumlah_reviewer: json['jumlah_reviewer'],
//       alamat: json['alamat'],
//       latitude: json['latitude'],
//       longitude: json['longitude'],
//       harga: double.parse(json['harga_termurah']),
//       kota: json['kota'],
//       tipe: json['tipe'],
//       wifi: json['wifi'] == '1',
//       kolamRenang: json['kolam_renang'] == '1',
//       parkir: json['parkir'] == '1', // Konversi 1/0 ke bool untuk parkir
//       restoran: json['restoran'] == '1', // Konversi 1/0 ke bool untuk restoran
//       pusatKebugaran: json['pusat_kebugaran'] ==
//           '1', // Konversi 1/0 ke bool untuk pusat kebugaran
//       resepsionis24Jam: json['resepsionis_24_jam'] ==
//           '1', // Konversi 1/0 ke bool untuk resepsionis 24 jam
//     );
//   }
// }

// String formatInteger(String numberString) {
//   // Mengonversi string ke integer
//   double number = double.parse(numberString);

//   // Membuat objek NumberFormat untuk memformat angka
//   NumberFormat formatter = NumberFormat("#,##0", "en_US");
//   return formatter.format(number);
// }
