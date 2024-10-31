import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/payment_success.dart';
import 'package:flutter_project/screens/payment_gateway_screen.dart';
import 'package:flutter_project/variables.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class PaymentPage extends StatefulWidget {
  static const String routeName = '/payment-page';
  String id;
  String hotel_id;
  String hargaTotal;
  String startDate;
  String endDate;
  String dbstartDate;
  String dbendDate;
  String sellersid;
  int adultValue;
  int childValue;
  String url_foto;

  PaymentPage({
    required this.id,
    required this.hotel_id,
    required this.url_foto,
    required this.hargaTotal,
    required this.startDate,
    required this.endDate,
    required this.dbstartDate,
    required this.sellersid,
    required this.dbendDate,
    required this.adultValue,
    required this.childValue,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

List<String> options = ['option 1', 'option2'];

class _PaymentPageState extends State<PaymentPage> {
  String selectedOption = options[0];
  String selectedPayment = options[0];
  final userbookform = GlobalKey<FormState>();
  String gendervalue = 'Mr.';
  bool isLoading = true;
  String? _firstname;
  String? lastname;
  String? number;
  String? birthdate;
  String? address;
  String? email;
  String? user_id;
  String uid = '';
  bool firstnameTrigger = true;
  List _Listdata = [];

  Future _getdata() async {
    try {
      final response = await http.get(
        Uri.parse(
            '${ipaddr}/ta_projek/crudtaprojek/payment_rooms.php?uid=${widget.hotel_id}&id=${widget.id}'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        fetchData();
        setState(() {
          _Listdata = data;
          isLoading = false;
          print(_Listdata);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void _addBookingIndicator() async {
    setState(() {
      isLoading = true;
    });
    await _addBooking();
    await Future.delayed(Duration(seconds: 5));
    setState(() {
      isLoading = false;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PaymentUi(
            uid: uid,
            productName: ' widget.nama_penginapan',
            hargaTotal: widget.hargaTotal,
            customerName: '${_firstname} ${lastname}',
            customerPhone: number!,
            customerAddress: address!,
            startDate: widget.startDate,
            endDate: widget.endDate,
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    _getdata();
    super.initState();
  }

  Future<void> fetchData() async {
    await fetchUserData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              title: Text(
                '1 of 2: Review Booking',
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              centerTitle: true,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.black38),
                  ),
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
              ),
            )),
        body:
            // isLoading
            //     ? Center(child: CircularProgressIndicator())
            //     : _Listdata.isNotEmpty
            //         ?
            Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFE6E6E6),
              ),
            ),
            SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(
                                  0.4), // Adjust opacity for shadow intensity
                              spreadRadius:
                                  2, // Adjust for desired shadow spread
                              blurRadius: 2, // Adjust for desired blur amount
                            ),
                          ],
                          borderRadius: BorderRadius.circular(6)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: 226),
                            margin: EdgeInsets.all(14),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Boom Raft',
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.6,
                                    ),
                                  ),
                                ),
                                Text(
                                  "BOOKTIME",
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.6,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Raft Type ",
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.6,
                                    ),
                                  ),
                                ),
                                Text(
                                  "2 Small Raft",
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.6,
                                    ),
                                  ),
                                ),
                                Text(
                                  "1 Medium Raft",
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.6,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Total Participant", //Deluxe Room
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.6,
                                    ),
                                  ),
                                ),
                                Text(
                                  "13 People", //Deluxe Room
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.6,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 94,
                            height: 94,
                            margin: const EdgeInsets.fromLTRB(8, 12, 12, 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              image: DecorationImage(
                                  image: AssetImage('assets/images/im2.jpg'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              // _isdatechoosed = !_isdatechoosed;
                            });
                            //choose date
                          },
                          child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: 54,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xFF225B7B),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(
                                        0.4), // Adjust opacity for shadow intensity
                                    spreadRadius:
                                        2, // Adjust for desired shadow spread
                                    blurRadius:
                                        2, // Adjust for desired blur amount
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.calendar_month_rounded,
                                    color: Color(0xFF225B7B),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${widget.startDate} - ${widget.endDate}',
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Color(0xFF225B7B),
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
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 2),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(
                                  0.4), // Adjust opacity for shadow intensity
                              spreadRadius:
                                  2, // Adjust for desired shadow spread
                              blurRadius: 2, // Adjust for desired blur amount
                            ),
                          ],
                          borderRadius: BorderRadius.circular(6)),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 226),
                        margin: const EdgeInsets.all(14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'I\'m booking for',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.4,
                                ),
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 36,
                                  child: RadioListTile(
                                    title: Text(
                                      'Myself',
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 13,
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
                                      'Someone Else',
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 13,
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
                            const Padding(
                              padding:
                                  EdgeInsets.only(left: 6.0, right: 6, top: 12),
                              child: Divider(
                                color: Colors.black12,
                              ),
                            ),
                            // firstnameTrigger
                            //     ? CircularProgressIndicator()
                            //     :
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Form(
                                key: userbookform,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      initialValue: email,
                                      decoration: InputDecoration(
                                        labelText: 'Email Address',
                                        hintText: 'email',
                                        hintStyle: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                            color: Colors.black26,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: -0.4,
                                          ),
                                        ),
                                        labelStyle: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                            color: Color(0xFF225B7B),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: -0.4,
                                          ),
                                        ),
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  0xFF225B7B)), // Warna garis saat aktif/fokus
                                        ),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  0xFF225B7B)), // Warna garis saat aktif/fokus
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            !RegExp(r'^[a-z A-Z]+$')
                                                .hasMatch(value)) {
                                          return "Enter Correct username";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                right: 6.0, top: 32),
                                            child: DropdownButton<String>(
                                              items: const [
                                                DropdownMenuItem<String>(
                                                  value: 'Mr.',
                                                  child: Text('Mr.'),
                                                ),
                                                DropdownMenuItem<String>(
                                                  value: 'Mrs.',
                                                  child: Text('Mrs.'),
                                                ),
                                              ],
                                              onChanged: (String? value) {
                                                setState(() {
                                                  gendervalue =
                                                      value.toString();
                                                });
                                              },
                                              hint: Text(
                                                gendervalue,
                                                style: GoogleFonts.montserrat(
                                                  textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: -0.4,
                                                  ),
                                                ),
                                              ),
                                              underline: Container(
                                                height: 1,
                                                color: Color(0xFF225B7B),
                                              ),
                                              icon: const Icon(
                                                Icons.arrow_drop_down_rounded,
                                                color: Color(0xFF225B7B),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            margin: EdgeInsets.only(right: 8),
                                            child: TextFormField(
                                              initialValue: _firstname,
                                              decoration: InputDecoration(
                                                labelText: 'First Name',
                                                labelStyle:
                                                    GoogleFonts.montserrat(
                                                  textStyle: const TextStyle(
                                                    color: Color(0xFF225B7B),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: -0.4,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(
                                                          0xFF225B7B)), // Warna garis saat aktif/fokus
                                                ),
                                                focusedBorder:
                                                    const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(
                                                          0xFF225B7B)), // Warna garis saat aktif/fokus
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty ||
                                                    !RegExp(r'^[a-z A-Z]+$')
                                                        .hasMatch(value)) {
                                                  return "Enter Correct username";
                                                } else {
                                                  return null;
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: TextFormField(
                                            initialValue: lastname,
                                            decoration: InputDecoration(
                                              labelText: 'Last Name',
                                              labelStyle:
                                                  GoogleFonts.montserrat(
                                                textStyle: const TextStyle(
                                                  color: Color(0xFF225B7B),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: -0.4,
                                                ),
                                              ),
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(
                                                        0xFF225B7B)), // Warna garis saat aktif/fokus
                                              ),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(
                                                        0xFF225B7B)), // Warna garis saat aktif/fokus
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty ||
                                                  !RegExp(r'^[a-z A-Z]+$')
                                                      .hasMatch(value)) {
                                                return "Enter Correct username";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    TextFormField(
                                      initialValue: number,
                                      decoration: InputDecoration(
                                        labelText: 'Phone Number',
                                        labelStyle: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                            color: Color(0xFF225B7B),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: -0.4,
                                          ),
                                        ),
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  0xFF225B7B)), // Warna garis saat aktif/fokus
                                        ),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  0xFF225B7B)), // Warna garis saat aktif/fokus
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            !RegExp(r'^[a-z A-Z]+$')
                                                .hasMatch(value)) {
                                          return "Enter Correct username";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    TextFormField(
                                      initialValue: address,
                                      decoration: InputDecoration(
                                        labelText: 'City of Origin',
                                        labelStyle: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                            color: Color(0xFF225B7B),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: -0.4,
                                          ),
                                        ),
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  0xFF225B7B)), // Warna garis saat aktif/fokus
                                        ),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  0xFF225B7B)), // Warna garis saat aktif/fokus
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            !RegExp(r'^[a-z A-Z]+$')
                                                .hasMatch(value)) {
                                          return "Enter Correct username";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(
                                  0.4), // Adjust opacity for shadow intensity
                              spreadRadius:
                                  2, // Adjust for desired shadow spread
                              blurRadius: 2, // Adjust for desired blur amount
                            ),
                          ],
                          borderRadius: BorderRadius.circular(6)),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 226),
                        margin: const EdgeInsets.all(14),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Payment Methode',
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.4,
                                  ),
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 36,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Pay Now',
                                          style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: -0.4,
                                            ),
                                          ),
                                        ),
                                        Radio<String>(
                                          activeColor: const Color(0xFF225B7B),
                                          value: options[0],
                                          groupValue: selectedPayment,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedPayment =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 44,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Pay on the Spot',
                                          style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: -0.4,
                                            ),
                                          ),
                                        ),
                                        Radio<String>(
                                          activeColor: const Color(0xFF225B7B),
                                          value: options[1],
                                          groupValue: selectedPayment,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedPayment =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ]),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          _addBookingIndicator();
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(double.infinity, 52),
                          elevation: 2,
                          backgroundColor: const Color(0xFF225B7B),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12.0), // Adjust as needed
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${widget.hargaTotal}",
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
              ),
            ),
          ],
        )
        // : Text('Data tidak ditemukan'),
        );
  }

  Future<void> _addBooking() async {
    final String apiUrl = '${ipaddr}/ta_projek/crudtaprojek/booking.php';
    try {
      Map<String, dynamic> data = {
        'room_id': widget.id,
        'user_id': user_id,
        'sellers_id': widget.sellersid,
        'tanggal_checkin': widget.dbstartDate,
        'tanggal_checkout': widget.dbendDate
      };
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        print('Data berhasil ditambahkan');
        // Tambahkan logika atau feedback sesuai kebutuhan
      } else {
        print('Gagal menambahkan data. Status code: ${response.statusCode}');
        // Tambahkan logika atau feedback sesuai kebutuhan
      }
    } catch (err) {
      print('Error: $err');
      // Tambahkan logika atau feedback sesuai kebutuhan
    }
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
    uid = user.uid;

    var response = await http.post(url, body: {
      "uid": uid,
    });

    var data = json.decode(response.body);
    if (data != null) {
      // Data berhasil diterima, tampilkan firstname dan lastname
      user_id = data['id'];
      _firstname = data['firstname'];
      lastname = data['lastname'];
      number = data['number'];
      birthdate = data['birthdate'];
      address = data['address'];
      email = data['email'];
      print('Firstname: $_firstname, Lastname: $lastname id : $user_id');
      // Lakukan apapun yang Anda ingin lakukan dengan data ini
    } else {
      print("Gagal mendapatkan data pengguna");
    }

    if (_firstname != null) {
      firstnameTrigger = false;
      print(firstnameTrigger);
      print(isLoading);
    }
  }
}
