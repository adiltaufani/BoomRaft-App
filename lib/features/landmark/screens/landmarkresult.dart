// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_project/features/home/screens/home_screen.dart';
// import 'package:flutter_project/variables.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;

// class LandmarkResult extends StatefulWidget {
//   static const String routeName = '/landmark-result';
//   const LandmarkResult({super.key});

//   @override
//   State<LandmarkResult> createState() => _LandmarkResultState();
// }

// class _LandmarkResultState extends State<LandmarkResult> {
//   List _Listdata = [];
//   final TextEditingController _searchController = TextEditingController();
//   bool isTextFieldFocused = false;
//   DateTimeRange selectedDates = DateTimeRange(
//     start: DateTime.now(),
//     end: DateTime.now(),
//   );
//   bool _isUp = false;

//   @override
//   void initState() {
//     _getdata();
//     super.initState();
//   }

//   void _toggleImage() {
//     setState(() {
//       _isUp = !_isUp;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: AppBar(
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               color: Colors.blue,
//             ),
//           ),
//           automaticallyImplyLeading: false,
//           title: Container(
//             width: double.infinity,
//             height: 40.0,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: Center(
//               child: TextField(
//                 textAlignVertical: TextAlignVertical.top,
//                 controller: _searchController,
//                 decoration: const InputDecoration(
//                   prefixIcon: Icon(
//                     Icons.search,
//                     color: Colors.grey,
//                   ),
//                   hintStyle: TextStyle(color: Colors.grey),
//                   contentPadding: EdgeInsets.all(4.0),
//                   hintText: 'Search..',
//                   border: InputBorder.none,
//                   alignLabelWithHint: true,
//                   hintMaxLines: 1,
//                 ),
//                 onTap: () {
//                   setState(() {
//                     isTextFieldFocused = true;
//                   });
//                 },
//                 onChanged: (value) {
//                   setState(() {
//                     isTextFieldFocused = value.isNotEmpty;
//                   });
//                 },
//                 onSubmitted: (value) {
//                   setState(() {
//                     isTextFieldFocused = false;
//                   });
//                 },
//               ),
//             ),
//           ),
//           actions: [
//             IconButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, HomeScreen.routeName);
//               },
//               padding: const EdgeInsets.only(right: 12),
//               icon: const Icon(
//                 Icons.close,
//                 color: Colors.white70,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           height: 900,
//           decoration: const BoxDecoration(
//             color: Colors.white,
//           ),
//           child: Column(
//             children: [
//               Container(
//                 margin: const EdgeInsets.all(10.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Search for',
//                           style: TextStyle(
//                             fontSize: 14.0,
//                             fontWeight: FontWeight.w300,
//                             color: Color(0xFF757575),
//                           ),
//                         ),
//                         Text(
//                           widget.namaKota,
//                           style: const TextStyle(
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Image.asset(
//                       'assets/images/bookit.png',
//                       height: 20.0,
//                     ),
//                   ],
//                 ),
//               ),
//               const Divider(
//                 color: Colors.black12, // Warna garis sesuai kebutuhan
//                 thickness: 1, // Ketebalan garis sesuai kebutuhan
//               ),
//               Container(
//                 margin: const EdgeInsets.fromLTRB(3, 2, 4, 2),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     // SortButton(
//                     //   namaKota: widget.namaKota,
//                     //   tanggal_checkin: widget.tanggal_checkin,
//                     //   tanggal_checkout: widget.tanggal_checkout,
//                     //   hargaMin: widget.hargaAwal,
//                     //   hargaMax: widget.hargaAkhir,
//                     //   Bintang: widget.bintang,
//                     //   Wifi: widget.wifi,
//                     //   KolamRenang: widget.kolamRenang,
//                     //   Parkir: widget.parkir,
//                     //   Restoran: widget.restoran,
//                     //   Gym: widget.gym,
//                     //   Resepsionis_24_jam: widget.resepsionis24jam,
//                     // ),
//                     Image.asset(
//                       'assets/images/sort.png',
//                       height: 34,
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Sort by',
//                           style: GoogleFonts.montserrat(
//                             textStyle: const TextStyle(fontSize: 10),
//                           ),
//                         ),
//                         Text(
//                           'Popularity',
//                           style: GoogleFonts.montserrat(
//                             textStyle: const TextStyle(
//                                 fontSize: 12, fontWeight: FontWeight.w600),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(width: 6),
//                     OutlinedButton(
//                       style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.all<Color>(Colors.white),
//                         side: MaterialStateProperty.all(
//                           const BorderSide(
//                             color: Color(0xFF0A8ED9),
//                             width: 1.2,
//                           ),
//                         ),
//                         minimumSize: MaterialStateProperty.all(
//                             const Size(double.minPositive, 34)),
//                         maximumSize: MaterialStateProperty.all(
//                           const Size(double.infinity, 34),
//                         ),
//                         shape: MaterialStateProperty.all(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(
//                                 5), // Mengatur kelengkungan sudut di sini
//                           ),
//                         ),
//                       ),
//                       onPressed: () async {
//                         final DateTimeRange? dateTimeRange =
//                             await showDateRangePicker(
//                           context: context,
//                           firstDate: DateTime(2000),
//                           lastDate: DateTime(3000),
//                         );
//                         if (dateTimeRange != null) {
//                           setState(() {
//                             selectedDates = DateTimeRange(
//                               start: DateTime(
//                                   dateTimeRange.start.year,
//                                   dateTimeRange.start.month,
//                                   dateTimeRange.start.day),
//                               end: DateTime(
//                                   dateTimeRange.end.year,
//                                   dateTimeRange.end.month,
//                                   dateTimeRange.end.day),
//                             );
//                           });
//                         }
//                       },
//                       child: Row(
//                         children: [
//                           const Icon(
//                             Icons.calendar_today,
//                             color: Color(0xFF0A8ED9),
//                             size: 18,
//                           ), // Ikon di sebelah kiri
//                           const SizedBox(
//                               width: 8), // Spacer antara ikon dan teks
//                           Text(
//                             '01 Jan..',
//                             style: GoogleFonts.raleway(
//                               textStyle: const TextStyle(
//                                 color: Color(0xFF0A8ED9),
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 6,
//                     ),
//                     Expanded(
//                       child: OutlinedButton(
//                         style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all<Color>(Colors.white),
//                           side: MaterialStateProperty.all(
//                             const BorderSide(
//                               color: Color(0xFF0A8ED9),
//                               width: 1.2,
//                             ),
//                           ),
//                           minimumSize:
//                               MaterialStateProperty.all(const Size(80, 34)),
//                           shape: MaterialStateProperty.all(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(
//                                   5), // Mengatur kelengkungan sudut di sini
//                             ),
//                           ),
//                         ),
//                         onPressed: () {},
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Icon(
//                               Icons.group,
//                               color: Color(0xFF0A8ED9),
//                               size: 18,
//                             ), // Ikon di sebelah kiri
//                             const SizedBox(
//                                 width: 8), // Spacer antara ikon dan teks
//                             Text(
//                               '2 Adult..',
//                               style: GoogleFonts.raleway(
//                                 textStyle: const TextStyle(
//                                   color: Color(0xFF0A8ED9),
//                                   fontSize: 14.0,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               const Divider(
//                 color: Colors.black12, // Warna garis sesuai kebutuhan
//                 thickness: 1, // Ketebalan garis sesuai kebutuhan
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: _Listdata
//                       .length, // Ganti dengan jumlah item yang Anda inginkan
//                   itemBuilder: (BuildContext context, int index) {
//                     String cleanedUrlFoto =
//                         _Listdata[index]['url_foto'].replaceAll('\\', '');
//                     return Container(
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
//                             spreadRadius: 1,
//                             blurRadius: 2,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 150,
//                             height: 150,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(25),
//                               image: DecorationImage(
//                                   image: NetworkImage(cleanedUrlFoto),
//                                   fit: BoxFit.cover),
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 13,
//                           ),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const SizedBox(
//                                   height: 12,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       constraints:
//                                           const BoxConstraints(maxWidth: 140),
//                                       child: Text(
//                                         _Listdata[index]['nama_penginapan'],
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
//                                     InkWell(
//                                       onTap: _toggleImage,
//                                       borderRadius: BorderRadius.circular(8),
//                                       child: AnimatedSwitcher(
//                                         duration:
//                                             const Duration(milliseconds: 300),
//                                         child: _isUp
//                                             ? Icon(
//                                                 Icons.bookmark_rounded,
//                                                 color: Colors.black54,
//                                                 size: 28,
//                                                 key: UniqueKey(),
//                                               )
//                                             : Icon(
//                                                 Icons.bookmark_outline_rounded,
//                                                 color: Colors.black54,
//                                                 size: 28,
//                                                 key: UniqueKey(),
//                                               ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 0,
//                                     )
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       _Listdata[index]['rating'],
//                                       style: GoogleFonts.montserrat(
//                                         textStyle: const TextStyle(
//                                           color: Colors.blue,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
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
//                                     const SizedBox(
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
//                                       _Listdata[index]['jumlah_reviewer'],
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
//                                     const SizedBox(
//                                       width: 5,
//                                     ),
//                                     const Icon(
//                                       Icons.star,
//                                       size: 15,
//                                       color: Colors.grey,
//                                     ),
//                                   ],
//                                 ),
//                                 Text(
//                                   _Listdata[index]['alamat'],
//                                   style: GoogleFonts.montserrat(
//                                     textStyle: const TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       'Rp.',
//                                       style: GoogleFonts.montserrat(
//                                         textStyle: const TextStyle(
//                                             color:
//                                                 Color.fromARGB(255, 8, 59, 134),
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                     Text(
//                                       '${_Listdata[index]['harga_termurah']}', // Mengonversi integer ke string sebelum memanggil formatInteger
//                                       style: GoogleFonts.montserrat(
//                                         textStyle: const TextStyle(
//                                             color:
//                                                 Color.fromARGB(255, 8, 59, 134),
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 120,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   String formatInteger(String numberString) {
//     // Mengonversi string ke integer
//     int number = int.parse(numberString);

//     // Membuat objek NumberFormat untuk memformat angka
//     NumberFormat formatter = NumberFormat("#,##0", "en_US");
//     return formatter.format(number);
//   }

//   Future _getdata() async {
//     try {
//       final response = await http.get(
//         Uri.parse(
//             '${ipaddr}/ta_projek/crudtaprojek/ai_fetch.php?${widget.namaKota}'),
//       );
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           _Listdata = data;
//         });
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
