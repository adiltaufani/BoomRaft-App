import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_project/variables.dart';
import 'package:http/http.dart' as http;

class FurniturePage extends StatefulWidget {
  final String id;

  FurniturePage({required this.id});

  @override
  _FurniturePageState createState() => _FurniturePageState();
}

class _FurniturePageState extends State<FurniturePage> {
  late Future<Map<String, bool>> futureFurnitureData;

  @override
  void initState() {
    super.initState();
    futureFurnitureData = fetchFurnitureData();
  }

  Future<Map<String, bool>> fetchFurnitureData() async {
    final url =
        '${ipaddr}/ta_projek/crudtaprojek/get_furniture.php?id=${widget.id}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      Map<String, bool> furnitureData = {
        "wifi": int.parse(data[0]['wifi']) == 1,
        "Gym": int.parse(data[0]['pusat_kebugaran']) == 1,
        "pool": int.parse(data[0]['kolam_renang']) == 1,
        "toilet": int.parse(data[0]['parkir']) == 1,
        "breakfast": int.parse(data[0]['restoran']) == 1,
      };

      return furnitureData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, bool>>(
      future: futureFurnitureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Tampilkan indikator loading
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Tampilkan pesan error jika ada error
          return Center(child: Text('Failed to load data'));
        } else {
          // Data tersedia
          Map<String, bool> furnitureData = snapshot.data!;

          // Daftar untuk menampung ikon yang akan ditampilkan
          List<Widget> iconsToDisplay = [];

          // Tambahkan ikon berdasarkan nilai true
          if (furnitureData['wifi'] == true) {
            iconsToDisplay.add(
              buildIconWidget(Icons.wifi, 'WiFi'),
            );
          }
          if (furnitureData['Gym'] == true) {
            iconsToDisplay.add(
              buildIconWidget(Icons.sports_gymnastics, 'Gym'),
            );
          }
          if (furnitureData['pool'] == true) {
            iconsToDisplay.add(
              buildIconWidget(Icons.pool, 'pool'),
            );
          }
          if (furnitureData['toilet'] == true) {
            iconsToDisplay.add(
              buildIconWidget(Icons.wc_outlined, 'toilet'),
            );
          }
          if (furnitureData['breakfast'] == true) {
            iconsToDisplay.add(
              buildIconWidget(Icons.breakfast_dining, 'breakfast'),
            );
          }

          // Tampilkan ikon yang dipilih dalam Row
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: iconsToDisplay,
          );
        }
      },
    );
  }

// Fungsi untuk membuat widget ikon
  Widget buildIconWidget(IconData iconData, String label) {
    return Container(
      width: 80,
      height: 80,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade100,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            spreadRadius: 1,
            color: Colors.black26,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 32,
            color: Colors.black,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
