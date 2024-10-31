import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_project/themes/theme.dart';
import 'package:flutter_project/widgets/raft_type_btn.dart';
import 'package:flutter_project/screens/payment_page.dart';
import 'package:flutter_project/widgets/variables.dart';
import 'package:flutter_project/variables.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class BookingPage extends StatefulWidget {
  static const String routeName = '/booking-page';
  BookingPage({
    Key? key,
    required this.url_foto,
    required this.hotel_id,
    required this.latitude,
    required this.longitude,
    required this.sellersName,
    required this.sellersEmail,
    required this.sellersFoto,
    required this.sellersUid,
    required this.sellersid,
    this.tanggalAwal,
    this.tanggalAkhir,
  }) : super(key: key);

  final String url_foto;
  final String hotel_id;
  final String latitude;
  final String longitude;
  String? tanggalAwal;
  String? tanggalAkhir;
  final String sellersid;
  final String sellersName;
  final String sellersUid;
  final String sellersFoto;
  final String sellersEmail;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTimeRange selectedDates = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );
  double lat = -6.975003032183382;
  double long = 107.64594257899627;
  String formattedTanggal = '';
  String formattedTanggalbesok = '';
  String tanggalAwal = '';
  String tanggalAkhir = '';
  bool docuCheckBox = false;
  int smallRaftQuantity = 0;
  int mediumRaftQuantity = 0;
  int largeRaftQuantity = 0;
  int maxParticipant = 0;

  late Future<Map<String, bool>> futureFurnitureData;

  List _Listdata = [];

  Future _getdata() async {
    if (widget.tanggalAwal != null && widget.tanggalAkhir != null) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ipaddr}/ta_projek/crudtaprojek/get_rooms_byid.php?uid=${widget.hotel_id}&tanggal_checkin=${widget.tanggalAwal}&tanggal_checkout=${widget.tanggalAkhir}'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            _Listdata = data;
            print(_Listdata);
          });
        }
      } catch (e) {
        print(e);
      }
    } else {
      try {
        DateTime tanggal = DateTime.now();
        DateTime tanggalbesok = tanggal.add(Duration(days: 1));
        formattedTanggal = tanggal.toIso8601String().substring(0, 10);
        formattedTanggalbesok = tanggalbesok.toIso8601String().substring(0, 10);
        DateTime date = DateTime.parse(formattedTanggal);
        DateTime date2 = DateTime.parse(formattedTanggalbesok);
        tanggalAwal = DateFormat('dd MMMM yyyy').format(date);
        tanggalAkhir = DateFormat('dd MMMM yyyy').format(date2);
        startdateNew = tanggalAwal;
        enddateNew = tanggalAkhir;
        final response = await http.get(
          Uri.parse(
              '${ipaddr}/ta_projek/crudtaprojek/get_rooms_byid.php?uid=${widget.hotel_id}&tanggal_checkin=${formattedTanggal}&tanggal_checkout=${formattedTanggalbesok}'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            _Listdata = data;
            print(_Listdata);
          });
        }
      } catch (e) {
        print(e);
      }
    }
  }

  String formatRupiah(int price) {
    if (price == 0) {
      return 'Rp. -';
    } else {
      return 'Rp. ${price.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]}.')}';
    }
  }

  void fetchData() async {
    await _getdata();
  }

  List<bool> booleanList = List<bool>.filled(10, true);

  bool _triggerList = false;
  bool _isdatechoosed = false;
  bool _ispersonchoosed = false;
  String hargaa = '';
  int totalHarga = 0;
  String hargaFix = '0';
  DateTime? startDate;
  DateTime? endDate;
  String formattedStartDate = '';
  String formattedEndDate = '';
  String startdateNew = '';
  String enddateNew = '';
  int _selectedValueAdult = 0;
  int _selectedValueChild = 0;
  List<String> selectedRoomIds = [];
  String roomsIds = '';
  final TextEditingController _maxParController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    fetchData();
    print('hotel id ==== ${widget.hotel_id}');
    _maxParController.text = '0';
    super.initState();
  }

  void _formatSelectedDates() {
    formattedStartDate = selectedDates.start.toIso8601String().substring(0, 10);
    formattedEndDate = selectedDates.end.toIso8601String().substring(0, 10);
    DateTime date = DateTime.parse(formattedStartDate);
    DateTime date2 = DateTime.parse(formattedEndDate);
    startdateNew = DateFormat('dd MMMM yyyy').format(date);
    enddateNew = DateFormat('dd MMMM yyyy').format(date2);
  }

  void _updateMaxParticipant(int newMaxParticipant) {
    setState(() {
      maxParticipant = (smallRaftQuantity * 4) +
          (mediumRaftQuantity * 5) +
          (largeRaftQuantity * 6);
      totalHarga = (smallRaftQuantity * 700000) +
          (mediumRaftQuantity * 900000) +
          (largeRaftQuantity * 1050000);
      formatRupiah(totalHarga);
    });
    int getMaxParticipant() {
      try {
        // Mengonversi teks di dalam controller menjadi int
        return int.parse(_maxParController.text);
      } catch (e) {
        // Jika konversi gagal, misalnya teks kosong atau tidak valid, kembalikan nilai default
        return 0; // Atur nilai default yang diinginkan
      }
    }

    if (getMaxParticipant() >= maxParticipant) {
      _maxParController.text =
          maxParticipant.toString(); // Update the TextField to display 15
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppTheme.backgroundColor,
            ),
          ),
          SingleChildScrollView(
            controller: _scrollController,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(color: Colors.grey),
                    child: Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          child: ImageSlideshow(
                            indicatorColor: AppTheme.darkBlue,
                            indicatorBackgroundColor:
                                Colors.white.withOpacity(0.64),
                            autoPlayInterval: 5000,
                            indicatorRadius: 4,
                            isLoop: true,
                            children: [
                              Image.asset(
                                'assets/images/im2.jpg',
                                fit: BoxFit.cover,
                              ),
                              Image.asset(
                                'assets/images/im2.jpg',
                                fit: BoxFit.cover,
                              ),
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: NetworkImage(widget.url_foto),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Image.asset(
                                'assets/images/im2.jpg',
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 10,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black38.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_rounded,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              constraints: const BoxConstraints(maxWidth: 332),
                              child: Text(
                                'Boom Raft',
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),

                        const SizedBox(
                          height: 8,
                        ),

                        const SizedBox(
                          height: 6,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            'Nikmati pengalaman seru rafting di Sungai Cileunca dengan jarak sekitar 5 km, yang memakan waktu kurang lebih 1.5 hingga 2 jam. Anda akan melewati 20 jeram yang menantang. Kami menyediakan layanan antar jemput dari Pineus Tilu ke titik start rafting dan kembali ke Pineus Tilu setelah selesai rafting.',
                            // _Listdata[index]['lokasi'],
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            'Set Your Book',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Colors.black87,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                final DateTimeRange? dateTimeRange =
                                    await showDateRangePicker(
                                  context: context,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(3000),
                                );
                                if (dateTimeRange != null) {
                                  setState(() {
                                    selectedDates = dateTimeRange;
                                    startDate = dateTimeRange.start;
                                    endDate = dateTimeRange.end;
                                    _formatSelectedDates();
                                    print('Tanggal Awal: $formattedStartDate');
                                    print('Tanggal Akhir: $formattedEndDate');
                                    _isdatechoosed = true;
                                  });
                                }
                              },
                              child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  height: 54,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: const Offset(1, 2),
                                      ),
                                    ],
                                    border: Border.all(
                                      color: _isdatechoosed
                                          ? AppTheme.darkBlue
                                          : Colors.black26,
                                      width: 1,
                                    ),
                                  ),
                                  child: _isdatechoosed
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                                Icons.calendar_month_rounded,
                                                color: AppTheme.darkBlue),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${startdateNew} / ${enddateNew}',
                                              style: GoogleFonts.montserrat(
                                                textStyle: const TextStyle(
                                                  color: AppTheme.darkBlue,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.calendar_month_rounded,
                                              color: Color(0xFF0A8ED9),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${tanggalAwal} / ${tanggalAkhir}',
                                              style: GoogleFonts.montserrat(
                                                textStyle: const TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                            ),
                          ),
                        ),
                        //ADD GUEST'S

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 10.0, vertical: 6),
                        //   child: Material(
                        //     color: Colors.transparent,
                        //     child: InkWell(
                        //       onTap: () {
                        //         setState(() {
                        //           showCupertinoModalPopup(
                        //             context: context,
                        //             builder: (_) => SizedBox(
                        //               width: double.infinity,
                        //               height: 250,
                        //               child: Row(
                        //                 children: [
                        //                   Expanded(
                        //                     child: CupertinoPicker(
                        //                       backgroundColor: Colors.white,
                        //                       itemExtent: 30,
                        //                       scrollController:
                        //                           FixedExtentScrollController(
                        //                         initialItem: 0,
                        //                       ),
                        //                       children: const [
                        //                         Text('0 Adult'),
                        //                         Text('1 Adult'),
                        //                         Text('2 Adult'),
                        //                         Text('3 Adult'),
                        //                         Text('4 Adult'),
                        //                         Text('5 Adult'),
                        //                         Text('6 Adult'),
                        //                       ],
                        //                       onSelectedItemChanged:
                        //                           (int value) {
                        //                         setState(() {
                        //                           _selectedValueAdult = value;
                        //                         });
                        //                       },
                        //                     ),
                        //                   ),
                        //                   Expanded(
                        //                     child: CupertinoPicker(
                        //                       backgroundColor: Colors.white,
                        //                       itemExtent: 30,
                        //                       scrollController:
                        //                           FixedExtentScrollController(
                        //                         initialItem: 0,
                        //                       ),
                        //                       children: const [
                        //                         Text('0 Child'),
                        //                         Text('1 Child'),
                        //                         Text('2 Child'),
                        //                         Text('3 Child'),
                        //                         Text('4 Child'),
                        //                         Text('5 Child'),
                        //                         Text('6 Child'),
                        //                       ],
                        //                       onSelectedItemChanged:
                        //                           (int value) {
                        //                         setState(() {
                        //                           _selectedValueChild = value;
                        //                         });
                        //                       },
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //             ),
                        //           );
                        //           _ispersonchoosed = true;
                        //         });
                        //         //add person
                        //       },
                        //       child: AnimatedContainer(
                        //           duration: const Duration(milliseconds: 200),
                        //           height: 54,
                        //           decoration: BoxDecoration(
                        //             color: Colors.white,
                        //             borderRadius: BorderRadius.circular(10),
                        //             border: Border.all(
                        //               color: _ispersonchoosed
                        //                   ? Colors.blue
                        //                   : Colors.black45,
                        //               width: 2,
                        //             ),
                        //           ),
                        //           child: _ispersonchoosed
                        //               ? Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.center,
                        //                   children: [
                        //                     const Icon(
                        //                       Icons.group_sharp,
                        //                       color: Color(0xFF0A8ED9),
                        //                     ),
                        //                     const SizedBox(width: 4),
                        //                     Text(
                        //                       '${_selectedValueAdult} Adult, ${_selectedValueChild} Child',
                        //                       style: GoogleFonts.montserrat(
                        //                         textStyle: const TextStyle(
                        //                           color: Colors.blue,
                        //                           fontSize: 14,
                        //                           fontWeight: FontWeight.w700,
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 )
                        //               : Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.center,
                        //                   children: [
                        //                     const Icon(
                        //                       Icons.group_sharp,
                        //                       color: Colors.black45,
                        //                     ),
                        //                     const SizedBox(width: 4),
                        //                     Text(
                        //                       'Add Guest\'s',
                        //                       style: GoogleFonts.montserrat(
                        //                         textStyle: const TextStyle(
                        //                           color: Colors.black45,
                        //                           fontSize: 14,
                        //                           fontWeight: FontWeight.w600,
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 )),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            'Raft Type',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        RaftingCard(
                          boatType: 'Small Raft',
                          maxParticipant: '4 People',
                          price: 700000,
                          onQuantityChanged: (int newQuantity) {
                            setState(() {
                              smallRaftQuantity = newQuantity;
                            });
                          },
                          onMaxParticipantChanged: _updateMaxParticipant,
                        ),
                        RaftingCard(
                          boatType: 'Medium Raft',
                          maxParticipant: '5 People',
                          price: 900000,
                          onQuantityChanged: (int newQuantity) {
                            setState(() {
                              mediumRaftQuantity = newQuantity;
                            });
                          },
                          onMaxParticipantChanged: _updateMaxParticipant,
                        ),
                        RaftingCard(
                          boatType: 'Large Raft',
                          price: 1050000,
                          maxParticipant: '6 People',
                          onQuantityChanged: (int newQuantity) {
                            setState(() {
                              largeRaftQuantity = newQuantity;
                            });
                          },
                          onMaxParticipantChanged: _updateMaxParticipant,
                        ),

                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _Listdata.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin:
                                    const EdgeInsets.fromLTRB(24, 0, 24, 20),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: const Offset(1, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    ClipRect(
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        height: 190,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 142,
                                                      height: 102,
                                                      margin: const EdgeInsets
                                                          .fromLTRB(
                                                          12, 12, 2, 10),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadiusDirectional
                                                                .circular(10),
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                'assets/images/room.jpeg'),
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets
                                                          .fromLTRB(
                                                          10, 12, 0, 10),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    _Listdata[
                                                                            index]
                                                                        [
                                                                        'tipe_kamar'],
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      textStyle:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        letterSpacing:
                                                                            -0.6,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            2.0),
                                                                    child:
                                                                        Container(
                                                                      constraints:
                                                                          const BoxConstraints(
                                                                              maxWidth: 172),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          const SizedBox(
                                                                              height: 8),
                                                                          Row(
                                                                            children: [
                                                                              const Icon(Icons.king_bed_rounded, color: Colors.black54, size: 16),
                                                                              const SizedBox(width: 8),
                                                                              Text(
                                                                                "${_Listdata[index]['bedroom']} Bed",
                                                                                style: GoogleFonts.montserrat(
                                                                                  textStyle: const TextStyle(
                                                                                    color: Colors.black54,
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    letterSpacing: -0.6,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              const Icon(Icons.group_rounded, color: Colors.black54, size: 16),
                                                                              const SizedBox(width: 8),
                                                                              Text(
                                                                                "${_Listdata[index]['kapasitas']} Guest's/Room",
                                                                                style: GoogleFonts.montserrat(
                                                                                  textStyle: const TextStyle(
                                                                                    color: Colors.black54,
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    letterSpacing: -0.6,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          12, 0, 0, 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Total Payment',
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          textStyle:
                                                              const TextStyle(
                                                            color:
                                                                Colors.black45,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            letterSpacing: -0.6,
                                                          ),
                                                        ),
                                                      ),
                                                      Text.rich(
                                                        TextSpan(
                                                            text:
                                                                'Rp ${_Listdata[index]['harga']}/',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              textStyle:
                                                                  const TextStyle(
                                                                color: Color(
                                                                    0xFF225B7B),
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                letterSpacing:
                                                                    -0.6,
                                                              ),
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                text: 'Night',
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                  textStyle:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              )
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 8, 8),
                                                  child: booleanList[index]
                                                      ? ElevatedButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              booleanList[
                                                                      index] =
                                                                  false;
                                                              hargaa =
                                                                  _Listdata[
                                                                          index]
                                                                      ['harga'];
                                                              harga = int.parse(
                                                                  hargaa);
                                                              totalHarga +=
                                                                  harga;
                                                              hargaFix =
                                                                  '$totalHarga';
                                                              selectedRoomIds
                                                                  .add(_Listdata[
                                                                          index]
                                                                      ['id']);
                                                              roomsIds =
                                                                  _Listdata[
                                                                          index]
                                                                      ['id'];
                                                              print(
                                                                  '${totalHarga}, ${selectedRoomIds}');
                                                            });
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                const Color(
                                                                    0xFF225B7B),
                                                            elevation: 2,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            'Select',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              textStyle:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                letterSpacing:
                                                                    -0.6,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : ElevatedButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              booleanList[
                                                                  index] = true;
                                                              hargaa =
                                                                  _Listdata[
                                                                          index]
                                                                      ['harga'];
                                                              harga = int.parse(
                                                                  hargaa);
                                                              totalHarga -=
                                                                  harga;
                                                              hargaFix =
                                                                  '$totalHarga';
                                                              selectedRoomIds
                                                                  .remove(_Listdata[
                                                                          index]
                                                                      ['id']);
                                                              roomsIds = '';
                                                              print(
                                                                  '${totalHarga}, ${selectedRoomIds}');
                                                            });
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.white
                                                                    .withOpacity(
                                                                        0.84),
                                                            elevation: 2,
                                                            side: BorderSide(
                                                                color: const Color(
                                                                    0xFF225B7B),
                                                                width: 1.0),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            'Selected',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              textStyle:
                                                                  const TextStyle(
                                                                color: Color(
                                                                    0xFF225B7B),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                letterSpacing:
                                                                    -0.6,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            'Total Participant',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          width: double.maxFinite,
                          height: 220,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(1, 2),
                              ),
                            ],
                            border: Border.all(color: Colors.black38, width: 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14.0, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Boat',
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        'Small Raft',
                                        style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ': $smallRaftQuantity boat',
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        'Medium Raft',
                                        style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ': $mediumRaftQuantity boat',
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        'Large Raft',
                                        style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ': $largeRaftQuantity boat',
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Divider(
                                    thickness: 0.7,
                                    color: Colors.black54,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.people_rounded,
                                          color: Colors.black87,
                                          size: 28,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'Total',
                                          style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: 60,
                                          height: 50,
                                          child: TextField(
                                            controller: _maxParController,
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  2),
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            onTap: () {
                                              _scrollController.animateTo(
                                                _scrollController
                                                    .position.maxScrollExtent,
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                curve: Curves.easeInOut,
                                              );
                                            },
                                            onChanged: (value) {
                                              // Logika untuk memeriksa nilai input
                                              if (value.isNotEmpty) {
                                                int enteredValue =
                                                    int.parse(value);
                                                if (enteredValue >
                                                    maxParticipant) {
                                                  _maxParController.text =
                                                      maxParticipant
                                                          .toString(); // Update the TextField to display 15
                                                } else {
                                                  _maxParController.text =
                                                      enteredValue
                                                          .toString(); // Update with valid value
                                                }
                                              }
                                            },
                                            onEditingComplete: () {
                                              FocusScope.of(context).unfocus();
                                            },
                                            decoration: InputDecoration(
                                              hintText: '0',
                                              hintStyle: GoogleFonts.montserrat(
                                                textStyle: const TextStyle(
                                                  color: Colors.black26,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppTheme.darkBlue,
                                                    width: 1),
                                              ),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppTheme.darkBlue,
                                                    width: 2),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          'Enter participant here',
                                          style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Max Participant: ',
                                              style: GoogleFonts.montserrat(
                                                textStyle: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '$maxParticipant',
                                              style: GoogleFonts.montserrat(
                                                textStyle: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            'Total Participant',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          width: double.maxFinite,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(1, 2),
                              ),
                            ],
                            border: Border.all(color: Colors.black38, width: 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                  value: docuCheckBox,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      docuCheckBox = value ?? false;
                                    });
                                  },
                                  activeColor: AppTheme.darkBlue,
                                  side: const BorderSide(
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Documentation',
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '+ Rp. 100.000,00',
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.black45,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            left: 10,
            child: ElevatedButton(
              onPressed: () {
                if (_selectedValueAdult == 0 || totalHarga == 0) {
                  //CODE TEST
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(
                        id: roomsIds,
                        hotel_id: widget.hotel_id,
                        url_foto: widget.url_foto,
                        hargaTotal: hargaFix,
                        startDate: startdateNew,
                        endDate: enddateNew,
                        adultValue: _selectedValueAdult,
                        childValue: _selectedValueChild,
                        dbstartDate: formattedTanggal,
                        dbendDate: formattedTanggalbesok,
                        sellersid: widget.sellersid,
                      ),
                    ),
                  );

                  //CODE BENER
                  // showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return AlertDialog(
                  //         title: Text('Input Tidak Sesuai'),
                  //         content: Text(
                  //             'Mohon piih tanggal, jumlah orang, dan pilih kamar'),
                  //         actions: [
                  //           TextButton(
                  //               onPressed: () {
                  //                 Navigator.pop(context);
                  //               },
                  //               child: Text('ok'))
                  //         ],
                  //       );
                  //     });
                } else {
                  if (widget.tanggalAwal == null &&
                      widget.tanggalAkhir == null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(
                          id: '',
                          hotel_id: '',
                          hargaTotal: '',
                          startDate: '',
                          url_foto: '',
                          endDate: '',
                          adultValue: 0,
                          childValue: 0,
                          sellersid: '',
                          dbendDate: '',
                          dbstartDate: '',
                        ),
                      ),
                    );
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(
                          id: roomsIds,
                          hotel_id: widget.hotel_id,
                          url_foto: widget.url_foto,
                          hargaTotal: hargaFix,
                          startDate: startdateNew,
                          endDate: enddateNew,
                          adultValue: _selectedValueAdult,
                          childValue: _selectedValueChild,
                          dbstartDate: widget.tanggalAwal!,
                          dbendDate: widget.tanggalAkhir!,
                          sellersid: widget.sellersid,
                        ),
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(double.infinity, 52),
                elevation: 2,
                backgroundColor: const Color(0xFF225B7B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Adjust as needed
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatRupiah(totalHarga),
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.6,
                      ),
                    ),
                  ),
                  Text(
                    "Book Now",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Future<void> _openMap(double lat, double long) async {
  //   String googleURL =
  //       'https://www.google.com/maps/search/?api=1&query=$lat,$long';
  //   await canLaunchUrlString(googleURL)
  //       ? await launchUrlString(googleURL)
  //       : throw 'Could not launch $googleURL';
  // }
}
