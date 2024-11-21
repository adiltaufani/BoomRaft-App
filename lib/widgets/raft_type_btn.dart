import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_project/themes/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class RaftingCard extends StatefulWidget {
  final int price;
  final String boatType;
  final String maxParticipant;
  final Function(int) onQuantityChanged;
  final Function(int) onMaxParticipantChanged;

  RaftingCard(
      {required this.price,
      required this.boatType,
      required this.onQuantityChanged,
      required this.onMaxParticipantChanged,
      required this.maxParticipant});

  @override
  _RaftingCardState createState() => _RaftingCardState();
}

class _RaftingCardState extends State<RaftingCard> {
  int quantity = 0;
  int maxParticipant = 0; // Nilai maksimum partisipan

  void _incrementQuantity() {
    setState(() {
      if (quantity >= 0) {
        quantity++;
        widget.onQuantityChanged(quantity);
        widget.onMaxParticipantChanged(maxParticipant);
      }
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (quantity >= 1) {
        quantity--;
        widget.onQuantityChanged(quantity);
        widget.onMaxParticipantChanged(maxParticipant);
      }
    });
  }

  String formatRupiah(int price) {
    return 'Rp. ${price.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 5),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(color: Colors.black38, width: 1)),
        borderOnForeground: true,
        elevation: 4,
        child: Column(
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
                child: Container(
                    height: 100,
                    width: double.maxFinite,
                    child: Image.asset(
                      'assets/images/rafting.jpg',
                      fit: BoxFit.cover,
                    ))
                // Image.network(
                //   'https://example.com/raft_image.jpg', // Ganti dengan URL gambar yang sesuai
                //   height: 200,
                //   width: double.infinity,
                //   fit: BoxFit.cover,
                // ),
                ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.boatType,
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            widget.maxParticipant,
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.6,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.people,
                            size: 14,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        formatRupiah(widget.price),
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            color: AppTheme.darkBlue,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 110,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black38, width: 0.6),
                            borderRadius: BorderRadius.circular(40)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: _decrementQuantity,
                              color: Colors.grey,
                              iconSize: 20,
                            ),
                            Text(
                              quantity.toString(),
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: _incrementQuantity,
                              color: AppTheme.darkBlue,
                              iconSize: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
