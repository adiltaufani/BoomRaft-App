class Reservation {
  final int rsvId;
  final int boatId;
  final int userId;
  final DateTime rsvDatetime;
  final DateTime rsvDatetimeEnd;
  final int numberOfPeople;
  final String paymentMethod;
  final bool paid;

  Reservation({
    required this.rsvId,
    required this.boatId,
    required this.userId,
    required this.rsvDatetime,
    required this.rsvDatetimeEnd,
    required this.numberOfPeople,
    required this.paymentMethod,
    required this.paid,
  });

  // Fungsi untuk mengubah JSON menjadi objek Reservation
  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      rsvId: json['rsv_id'],
      boatId: json['boat_id'],
      userId: json['user_id'],
      rsvDatetime: DateTime.parse(json['rsv_datetime']),
      rsvDatetimeEnd: DateTime.parse(json['rsv_datetime_end']),
      numberOfPeople: json['number_of_people'],
      paymentMethod: json['payment_method'],
      paid: json['paid'],
    );
  }

  // Fungsi untuk mengubah objek Reservation menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'rsv_id': rsvId,
      'boat_id': boatId,
      'user_id': userId,
      'rsv_datetime': rsvDatetime.toIso8601String(),
      'rsv_datetime_end': rsvDatetimeEnd.toIso8601String(),
      'number_of_people': numberOfPeople,
      'payment_method': paymentMethod,
      'paid': paid,
    };
  }
}
