import 'package:flutter_project/models/reserv_model.dart';

class Boat {
  final int boatId;
  final String boatName;
  final int capacity;
  final int price;
  final List<Reservation> reservations;

  Boat({
    required this.boatId,
    required this.boatName,
    required this.capacity,
    required this.price,
    required this.reservations,
  });

  // Fungsi untuk mengubah JSON menjadi objek Boat
  factory Boat.fromJson(Map<String, dynamic> json) {
    var reservationList = json['reservations'] as List;

    List<Reservation> reservations = reservationList.map((reservationJson) {
      return Reservation.fromJson(reservationJson);
    }).toList();

    return Boat(
      boatId: json['boat_id'],
      boatName: json['boat_name'],
      capacity: json['capacity'],
      price: json['price'],
      reservations: reservations,
    );
  }

  // Fungsi untuk mengubah objek Boat menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'boat_id': boatId,
      'boat_name': boatName,
      'capacity': capacity,
      'price': price,
      'reservations': reservations.map((r) => r.toJson()).toList(),
    };
  }
}
