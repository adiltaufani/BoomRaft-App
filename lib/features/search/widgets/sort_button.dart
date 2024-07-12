import 'package:flutter/material.dart';
import 'package:flutter_project/features/search/screens/search_page.dart';
import 'package:google_fonts/google_fonts.dart';

List<String> options = ['option 1', 'option 2'];

// ignore: must_be_immutable
class SortButton extends StatefulWidget {
  String namaKota;
  String? tanggal_checkin;
  String? tanggal_checkout;
  double? hargaMin;
  double? hargaMax;
  int? Bintang;
  bool? Wifi;
  bool? KolamRenang;
  bool? Parkir;
  bool? Restoran;
  bool? Gym;
  bool? Resepsionis_24_jam;
  SortButton({
    required this.namaKota,
    this.tanggal_checkin,
    this.tanggal_checkout,
    this.hargaMin,
    this.hargaMax,
    this.Bintang,
    this.Wifi,
    this.KolamRenang,
    this.Parkir,
    this.Restoran,
    this.Gym,
    this.Resepsionis_24_jam,
  });

  @override
  State<SortButton> createState() => _SortButtonState();
}

class _SortButtonState extends State<SortButton> {
  int? bintang;
  bool? wifi;
  bool? kolamRenang;
  bool? parkir;
  bool? restoran;
  bool? gym;
  bool? resepsionis24jam;
  TextEditingController _hargaMinController = TextEditingController();
  TextEditingController _hargaMaxController = TextEditingController();
  TextEditingController _bintangController = TextEditingController();
  final focusNode = FocusNode();
  OverlayEntry? entry;
  String selectedOption = options[0];
  //ubah sesuai harga min dan max yang bisa ditampilkan disearch
  double _hargaMinValue = 0;
  double _hargaMaxValue = 1000000;
  //rating
  bool ratingselected = false;
  List<bool> booleanList = List<bool>.filled(10, false);
  List rating = [1, 2, 3, 4, 5];

  void showOverlay() {
    final overlay = Overlay.of(context);
    final size = MediaQuery.of(context).size; // Mendapatkan ukuran layar
    final overlayWidth = size.width * 0.9; // Lebar overlay
    final overlayHeight = size.height * 0.7; // Tinggi overlay

    entry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Lapisan hitam semi-transparan
          Positioned.fill(
            child: GestureDetector(
              onTap:
                  hideOverlay, // Sembunyikan overlay saat lapisan hitam disentuh
              child: Container(
                color: Colors.black
                    .withOpacity(0.5), // Warna hitam semi-transparan
              ),
            ),
          ),
          // Overlay konten
          Positioned(
            width: overlayWidth,
            height: overlayHeight,

            left: (size.width - overlayWidth) /
                2, // Menempatkan di tengah horizontal
            top: (size.height - overlayHeight) /
                2, // Menempatkan di tengah vertikal
            child: buildOverlay(),
          ),
        ],
      ),
    );

    overlay.insert(entry!);
  }

  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => hideOverlay());
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        showOverlay();
        print('overlay showed');
      }
    });

    if (widget.hargaMin != null) {
      _hargaMinController.text = widget.hargaMin.toString();
      _hargaMinValue = widget.hargaMin!;
    }
    if (widget.hargaMax != null) {
      _hargaMaxController.text = widget.hargaMax.toString();
      _hargaMaxValue = widget.hargaMax!;
    }
    if (widget.Bintang != null) {
      _bintangController.text = widget.Bintang.toString();
      bintang = widget.Bintang;
    }
    if (widget.Wifi != null) {
      wifi = widget.Wifi;
    }
    if (widget.KolamRenang != null) {
      kolamRenang = widget.KolamRenang;
    }
    if (widget.Parkir != null) {
      parkir = widget.Parkir;
    }
    if (widget.Restoran != null) {
      restoran = widget.Restoran;
    }
    if (widget.Gym != null) {
      gym = widget.Gym;
    }
    if (widget.Resepsionis_24_jam != null) {
      resepsionis24jam = widget.Resepsionis_24_jam;
    }
  }

  void dispose() {
    focusNode.dispose();
    _hargaMinController.dispose();
    _hargaMaxController.dispose();
    _bintangController.dispose();
    super.dispose();
  }

  Widget buildOverlay() => Material(
        elevation: 8,
        color: Colors.transparent,
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(12), // Atur corner radius di sini
                color: Colors.blue[50],
              ),
              padding: EdgeInsets.all(6),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Center(
                              child: Text(
                                'Filter',
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Divider(height: 2),
                          const SizedBox(height: 12),
                          Text(
                            'Sort By',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: 40,
                                child: RadioListTile(
                                  title: Text(
                                    'Price: Low to High',
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -0.4,
                                      ),
                                    ),
                                  ),
                                  activeColor: const Color(0xFF225B7B),
                                  value: options[0],
                                  selected: false,
                                  groupValue: selectedOption,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedOption = value.toString();
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 44,
                                child: RadioListTile(
                                  title: Text(
                                    'Rating: High to Low',
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -0.4,
                                      ),
                                    ),
                                  ),
                                  activeColor: const Color(0xFF225B7B),
                                  value: options[1],
                                  groupValue: selectedOption,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedOption = value.toString();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Price Range',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(2),
                                  child: TextFormField(
                                    controller: _hargaMinController,
                                    decoration: InputDecoration(
                                      labelText: 'Min',
                                      labelStyle: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.4,
                                        ),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black45),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),
                                      contentPadding: const EdgeInsets.all(16),
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      setState(() {
                                        _hargaMinValue = double.parse(value);
                                      });
                                    },
                                    onEditingComplete: () {
                                      setState(() {
                                        _hargaMinValue = double.tryParse(
                                                _hargaMinController.text) ??
                                            0.0;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(2),
                                  child: TextFormField(
                                    controller: _hargaMaxController,
                                    decoration: InputDecoration(
                                      labelText: 'Max',
                                      labelStyle: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.4,
                                        ),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black45),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),
                                      contentPadding: const EdgeInsets.all(16),
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      setState(() {
                                        _hargaMaxValue = double.parse(value);
                                      });
                                    },
                                    onEditingComplete: () {
                                      setState(() {
                                        _hargaMaxValue = double.tryParse(
                                                _hargaMaxController.text) ??
                                            0.0;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          RangeSlider(
                            values: RangeValues(_hargaMinValue, _hargaMaxValue),
                            min: 0,
                            max: 1000000,
                            divisions: 20,
                            onChanged: (values) {
                              setState(() {
                                _hargaMinValue = values.start;
                                _hargaMaxValue = values.end;
                                _hargaMinController.text =
                                    _hargaMinValue.toStringAsFixed(0);
                                _hargaMaxController.text =
                                    _hargaMaxValue.toStringAsFixed(0);
                              });
                            },
                            inactiveColor: Colors.black12,
                            activeColor: const Color(0xFF225B7B),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Rating',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 326,
                                height: 50,
                                child: ListView.builder(
                                    itemCount: rating.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        child: ChoiceChip(
                                          label: Text(
                                            '${rating[index]}',
                                            style: GoogleFonts.montserrat(
                                              textStyle: TextStyle(
                                                color: booleanList[index]
                                                    ? Colors.white
                                                    : Colors.black45,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: -0.2,
                                              ),
                                            ),
                                          ),
                                          avatar: Icon(
                                            Icons.star,
                                            color: booleanList[index]
                                                ? Colors.yellow[700]
                                                : Colors.black38,
                                          ),
                                          shadowColor: Colors.black12,
                                          selected: booleanList[index],
                                          showCheckmark: false,
                                          side: const BorderSide(
                                              color: Colors.black12),
                                          selectedColor:
                                              const Color(0xFF225B7B),
                                          onSelected: (value) {
                                            setState(() {
                                              if (booleanList[index] == true) {
                                                booleanList[index] = false;
                                              } else {
                                                booleanList[index] = true;
                                                bintang = rating[index];
                                                print(bintang);
                                              }
                                            });
                                          },
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Facilities',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                          CheckboxListTile(
                            title: Text(
                              'Wifi',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.4,
                                ),
                              ),
                            ),
                            value: wifi ?? false,
                            activeColor: const Color(0xFF225B7B),
                            onChanged: (value) {
                              setState(() {
                                wifi = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text(
                              'Kolam Renang',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.4,
                                ),
                              ),
                            ),
                            activeColor: const Color(0xFF225B7B),
                            value: kolamRenang ?? false,
                            onChanged: (value) {
                              setState(() {
                                kolamRenang = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text(
                              'Parkir',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.4,
                                ),
                              ),
                            ),
                            activeColor: const Color(0xFF225B7B),
                            value: parkir ?? false,
                            onChanged: (value) {
                              setState(() {
                                parkir = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text(
                              'Restoran',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.4,
                                ),
                              ),
                            ),
                            activeColor: const Color(0xFF225B7B),
                            value: restoran ?? false,
                            onChanged: (value) {
                              setState(() {
                                restoran = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text(
                              'Gym',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.4,
                                ),
                              ),
                            ),
                            activeColor: const Color(0xFF225B7B),
                            value: gym ?? false,
                            onChanged: (value) {
                              setState(() {
                                gym = value;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text(
                              'Resepsionis 24 jam',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.4,
                                ),
                              ),
                            ),
                            activeColor: const Color(0xFF225B7B),
                            value: resepsionis24jam ?? false,
                            onChanged: (value) {
                              setState(() {
                                resepsionis24jam = value;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              _loadHotels(); // Panggil fungsi _loadHotels() saat tombol ditekan
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF225B7B),
                              ),
                              elevation: MaterialStateProperty.all(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Apply Filter',
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
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
      );
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        focusNode: focusNode,
        onPressed: () {
          showOverlay();
        },
        icon: Image.asset(
          'assets/images/sort.png',
          height: 34,
        ),
      ),
    );
  }

  Future<void> _loadHotels() async {
    try {
      hideOverlay();
      focusNode.unfocus();
      await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SearchPage(
                namaKota: widget.namaKota,
                tanggal_checkin: widget.tanggal_checkin,
                tanggal_checkout: widget.tanggal_checkout,
                hargaAwal: _hargaMinValue,
                hargaAkhir: _hargaMaxValue,
                bintang: bintang,
                wifi: wifi,
                kolamRenang: kolamRenang,
                parkir: parkir,
                restoran: restoran,
                gym: gym,
                resepsionis24jam: resepsionis24jam,
              )));

      print('try load berhasil');
    } catch (e) {
      print(e);
      // Handle error
    }
  }
}
