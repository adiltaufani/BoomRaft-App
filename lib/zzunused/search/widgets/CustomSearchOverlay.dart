import 'package:flutter/material.dart';

class CustomSearchOverlay extends StatelessWidget {
  final List<String> foundKota;

  const CustomSearchOverlay({required this.foundKota});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: ListView.builder(
              itemCount: foundKota.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                final kota = foundKota[index];
                return ListTile(
                  title: Text(kota),
                  onTap: () {
                    print('Anda memilih kota: $kota');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
