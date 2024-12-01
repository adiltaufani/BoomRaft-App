import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/payment_success.dart';
import 'package:flutter_project/screens/payment_gateway_screen.dart';
import 'package:flutter_project/screens/waiting_payment_page.dart';
import 'package:flutter_project/services/user_services.dart';
import 'package:flutter_project/variables.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class PaymentPage extends StatefulWidget {
  static const String routeName = '/payment-page';
  String id;
  String hargaTotal;
  String bookTime;
  String bookDate;
  String dbstartDate;
  String dbendDate;
  String sellersid;
  int smallRaftQuantity;
  int mediumRaftQuantity;
  int largeRaftQuantity;
  int participantValue;
  String url_foto;

  PaymentPage({
    required this.id,
    required this.url_foto,
    required this.hargaTotal,
    required this.bookTime,
    required this.bookDate,
    required this.dbstartDate,
    required this.sellersid,
    required this.dbendDate,
    required this.smallRaftQuantity,
    required this.mediumRaftQuantity,
    required this.largeRaftQuantity,
    required this.participantValue,
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
  bool isTransferBankExpanded = false;
  bool smallraftvis = false;
  bool mediumRaftVis = false;
  bool largeRaftVis = false;

  Future<Map<String, dynamic>>? userProfile;
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    userProfile = UserServices().getProfile();
    super.initState();
    if (widget.smallRaftQuantity > 0) {
      smallraftvis = true;
    }
    if (widget.mediumRaftQuantity > 0) {
      mediumRaftVis = true;
    }
    if (widget.largeRaftQuantity > 0) {
      largeRaftVis = true;
    }
  }

  String formatRupiah(int price) {
    if (price == 0) {
      return 'Rp. -';
    } else {
      return 'Rp. ${price.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]}.')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildLoading(context);
            // } else if (snapshot.hasError) {
            //   return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            userData = snapshot.data!;
          }
          return buildPage(context);
        });
  }

  Widget buildLoading(BuildContext context) {
    return CircularProgressIndicator();
  }

  Widget buildPage(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              title: Text(
                'Review Booking',
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
        body: Stack(
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.6,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Time ",
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.6,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${widget.bookTime} - ${widget.bookDate}",
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      color: Colors.black38,
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
                                    textStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.6,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: smallraftvis,
                                  child: Text(
                                    "${widget.smallRaftQuantity} Small Raft",
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.black38,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -0.6,
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: mediumRaftVis,
                                  child: Text(
                                    "${widget.mediumRaftQuantity} Medium Raft",
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.black38,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -0.6,
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: largeRaftVis,
                                  child: Text(
                                    "${widget.largeRaftQuantity} Large Raft",
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.black38,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -0.6,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Total Participant", //Deluxe Room
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.6,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${widget.participantValue} people", //Deluxe Room
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      color: Colors.black38,
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
                                    Icons.access_time,
                                    color: Color(0xFF225B7B),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${widget.bookTime} - ${widget.bookDate}',
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
                                      initialValue:
                                          '${userData['email'] ?? "Loading"} ',
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
                                              initialValue:
                                                  '${userData['name'] ?? "Loading"} ',
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
                                            initialValue:
                                                '${userData['name'] ?? "Loading"} ',
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
                                      initialValue:
                                          '${userData['phone'] ?? "Loading"} ',
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
                                      initialValue:
                                          '${userData['city'] ?? "Loading"} ',
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
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 36,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Klik BCA',
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
                                            activeColor:
                                                const Color(0xFF225B7B),
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
                                    const Divider(
                                      thickness: 0.6,
                                    ),
                                    SizedBox(
                                      height: 44,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Dana',
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
                                            activeColor:
                                                const Color(0xFF225B7B),
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
                                    const Divider(
                                      thickness: 0.6,
                                    ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.only(
                                          left: 0, right: 10),
                                      title: Text('Transfer Bank',
                                          style: isTransferBankExpanded
                                              ? GoogleFonts.montserrat(
                                                  textStyle: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    letterSpacing: -0.4,
                                                  ),
                                                )
                                              : GoogleFonts.montserrat(
                                                  textStyle: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: -0.4,
                                                  ),
                                                )),
                                      trailing: Icon(
                                        isTransferBankExpanded
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        color: Colors.black54,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          isTransferBankExpanded =
                                              !isTransferBankExpanded;
                                        });
                                      },
                                    ),
                                    if (isTransferBankExpanded)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'BRI',
                                                  style: GoogleFonts.montserrat(
                                                    textStyle: const TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: -0.4,
                                                    ),
                                                  ),
                                                ),
                                                Radio<String>(
                                                  activeColor:
                                                      const Color(0xFF225B7B),
                                                  value: "BRI",
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
                                            const Divider(
                                              thickness: 0.6,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'BCA',
                                                  style: GoogleFonts.montserrat(
                                                    textStyle: const TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: -0.4,
                                                    ),
                                                  ),
                                                ),
                                                Radio<String>(
                                                  activeColor:
                                                      const Color(0xFF225B7B),
                                                  value: "BCA",
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
                                            const Divider(
                                              thickness: 0.6,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Mandiri',
                                                  style: GoogleFonts.montserrat(
                                                    textStyle: const TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: -0.4,
                                                    ),
                                                  ),
                                                ),
                                                Radio<String>(
                                                  activeColor:
                                                      const Color(0xFF225B7B),
                                                  value: "Mandiri",
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
                                            const Divider(
                                              thickness: 0.6,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'BNI',
                                                  style: GoogleFonts.montserrat(
                                                    textStyle: const TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: -0.4,
                                                    ),
                                                  ),
                                                ),
                                                Radio<String>(
                                                  activeColor:
                                                      const Color(0xFF225B7B),
                                                  value: "BNI",
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
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              )
                            ]),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, WaitingPaymentPage.routeName);
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
                              formatRupiah(int.parse(widget.hargaTotal)),
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
