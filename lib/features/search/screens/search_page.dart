import 'package:flutter/material.dart';
import 'package:flutter_project/features/home/screens/home_screen.dart';
import 'package:flutter_project/features/search/widgets/sort_button.dart';
import 'package:flutter_project/features/search/widgets/search_house.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SearchPage extends StatefulWidget {
  String namaKota;
  String? tanggal_checkin;
  String? tanggal_checkout;
  double? hargaAwal;
  double? hargaAkhir;
  int? bintang;
  bool? wifi;
  bool? kolamRenang;
  bool? parkir;
  bool? restoran;
  bool? gym;
  bool? resepsionis24jam;
  static const String routeName = '/search-page';
  SearchPage({
    required this.namaKota,
    this.tanggal_checkin,
    this.tanggal_checkout,
    this.hargaAwal,
    this.hargaAkhir,
    this.bintang,
    this.wifi,
    this.kolamRenang,
    this.parkir,
    this.restoran,
    this.gym,
    this.resepsionis24jam,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  @override
  void initState() {
    print('ini harga awal ${widget.tanggal_checkout}');
    print('ini harga akhir ${widget.tanggal_checkin}');

    super.initState();
  }

  bool isTextFieldFocused = false;
  TextEditingController _searchController = TextEditingController();
  DateTimeRange selectedDates = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 5, vsync: this);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
          ),
          automaticallyImplyLeading: false,
          title: Container(
            width: double.infinity,
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: TextField(
                textAlignVertical: TextAlignVertical.top,
                controller: _searchController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.all(4.0),
                  hintText: 'Search..',
                  border: InputBorder.none,
                  alignLabelWithHint: true,
                  hintMaxLines: 1,
                ),
                onTap: () {
                  setState(() {
                    isTextFieldFocused = true;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    isTextFieldFocused = value.isNotEmpty;
                  });
                },
                onSubmitted: (value) {
                  setState(() {
                    isTextFieldFocused = false;
                  });
                },
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
              padding: const EdgeInsets.only(right: 12),
              icon: const Icon(
                Icons.close,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Search for',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                            color: Color(0xFF757575),
                          ),
                        ),
                        Text(
                          widget.namaKota,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/images/bookit.png',
                      height: 20.0,
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.black12, // Warna garis sesuai kebutuhan
                thickness: 1, // Ketebalan garis sesuai kebutuhan
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(3, 2, 4, 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SortButton(
                      namaKota: widget.namaKota,
                      tanggal_checkin: widget.tanggal_checkin,
                      tanggal_checkout: widget.tanggal_checkout,
                      hargaMin: widget.hargaAwal,
                      hargaMax: widget.hargaAkhir,
                      Bintang: widget.bintang,
                      Wifi: widget.wifi,
                      KolamRenang: widget.kolamRenang,
                      Parkir: widget.parkir,
                      Restoran: widget.restoran,
                      Gym: widget.gym,
                      Resepsionis_24_jam: widget.resepsionis24jam,
                    ),
                    // Image.asset(
                    //   'assets/images/sort.png',
                    //   height: 34,
                    // ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sort by',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(fontSize: 10),
                          ),
                        ),
                        Text(
                          'Popularity',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 6),
                    OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        side: MaterialStateProperty.all(
                          const BorderSide(
                            color: Color(0xFF0A8ED9),
                            width: 1.2,
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all(
                            const Size(double.minPositive, 34)),
                        maximumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 34),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                5), // Mengatur kelengkungan sudut di sini
                          ),
                        ),
                      ),
                      onPressed: () async {
                        final DateTimeRange? dateTimeRange =
                            await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(3000),
                        );
                        if (dateTimeRange != null) {
                          setState(() {
                            selectedDates = DateTimeRange(
                              start: DateTime(
                                  dateTimeRange.start.year,
                                  dateTimeRange.start.month,
                                  dateTimeRange.start.day),
                              end: DateTime(
                                  dateTimeRange.end.year,
                                  dateTimeRange.end.month,
                                  dateTimeRange.end.day),
                            );
                            print(selectedDates);
                          });
                        }
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Color(0xFF0A8ED9),
                            size: 18,
                          ), // Ikon di sebelah kiri
                          const SizedBox(
                              width: 8), // Spacer antara ikon dan teks
                          Text(
                            '01 Jan..',
                            style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                color: Color(0xFF0A8ED9),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: OutlinedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          side: MaterialStateProperty.all(
                            const BorderSide(
                              color: Color(0xFF0A8ED9),
                              width: 1.2,
                            ),
                          ),
                          minimumSize:
                              MaterialStateProperty.all(const Size(80, 34)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5), // Mengatur kelengkungan sudut di sini
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.group,
                              color: Color(0xFF0A8ED9),
                              size: 18,
                            ), // Ikon di sebelah kiri
                            const SizedBox(
                                width: 8), // Spacer antara ikon dan teks
                            Text(
                              '2 Adult..',
                              style: GoogleFonts.raleway(
                                textStyle: const TextStyle(
                                  color: Color(0xFF0A8ED9),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                color: Colors.black12, // Warna garis sesuai kebutuhan
                thickness: 1, // Ketebalan garis sesuai kebutuhan
              ),
              Align(
                child: TabBar(
                  labelPadding: const EdgeInsets.only(left: 0, right: 40),
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: CircleTabIndicator(color: Colors.blue, radius: 4),
                  tabs: [
                    Tab(
                      child: Text(
                        'Apartement',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Hotel',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Villa',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1000,
                width: double.maxFinite,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SearchHouse(
                      terusan: 'house',
                      terusan2: widget.namaKota,
                      tanggal_checkin: widget.tanggal_checkin,
                      tanggal_checkout: widget.tanggal_checkout,
                      hargaAwal: widget.hargaAwal,
                      hargaAkhir: widget.hargaAkhir,
                      bintang: widget.bintang,
                      wifi: widget.wifi,
                      kolamRenang: widget.kolamRenang,
                      parkir: widget.parkir,
                      restoran: widget.restoran,
                      gym: widget.gym,
                      resepsionis24jam: widget.resepsionis24jam,
                    ),
                    SearchHouse(
                      terusan: 'apartement',
                      terusan2: widget.namaKota,
                      tanggal_checkin: widget.tanggal_checkin,
                      tanggal_checkout: widget.tanggal_checkout,
                      hargaAwal: widget.hargaAwal,
                      hargaAkhir: widget.hargaAkhir,
                      bintang: widget.bintang,
                      wifi: widget.wifi,
                      kolamRenang: widget.kolamRenang,
                      parkir: widget.parkir,
                      restoran: widget.restoran,
                      gym: widget.gym,
                      resepsionis24jam: widget.resepsionis24jam,
                    ),
                    SearchHouse(
                      terusan: 'hotel',
                      terusan2: widget.namaKota,
                      tanggal_checkin: widget.tanggal_checkin,
                      tanggal_checkout: widget.tanggal_checkout,
                      hargaAwal: widget.hargaAwal,
                      hargaAkhir: widget.hargaAkhir,
                      bintang: widget.bintang,
                      wifi: widget.wifi,
                      kolamRenang: widget.kolamRenang,
                      parkir: widget.parkir,
                      restoran: widget.restoran,
                      gym: widget.gym,
                      resepsionis24jam: widget.resepsionis24jam,
                    ),
                    SearchHouse(
                      terusan: 'villa',
                      terusan2: widget.namaKota,
                      tanggal_checkin: widget.tanggal_checkin,
                      tanggal_checkout: widget.tanggal_checkout,
                      hargaAwal: widget.hargaAwal,
                      hargaAkhir: widget.hargaAkhir,
                      bintang: widget.bintang,
                      wifi: widget.wifi,
                      kolamRenang: widget.kolamRenang,
                      parkir: widget.parkir,
                      restoran: widget.restoran,
                      gym: widget.gym,
                      resepsionis24jam: widget.resepsionis24jam,
                    ),
                    SearchHouse(
                      terusan: 'resort',
                      terusan2: widget.namaKota,
                      tanggal_checkin: widget.tanggal_checkin,
                      tanggal_checkout: widget.tanggal_checkout,
                      hargaAwal: widget.hargaAwal,
                      hargaAkhir: widget.hargaAkhir,
                      bintang: widget.bintang,
                      wifi: widget.wifi,
                      kolamRenang: widget.kolamRenang,
                      parkir: widget.parkir,
                      restoran: widget.restoran,
                      gym: widget.gym,
                      resepsionis24jam: widget.resepsionis24jam,
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
}
