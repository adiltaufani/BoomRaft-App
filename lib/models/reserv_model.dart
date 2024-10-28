class Reservation {
  final int rsvId;
  final int boatId;
  final int userId;
  final DateTime rsvDatetime;
  final DateTime rsvDatetimeEnd;
  final int numberOfPeople;
  final String paymentMethod;
  final bool paid;
  final String status;
  final Boat boat;
  final List<Review> review;

  Reservation({
    required this.rsvId,
    required this.boatId,
    required this.userId,
    required this.rsvDatetime,
    required this.rsvDatetimeEnd,
    required this.numberOfPeople,
    required this.paymentMethod,
    required this.paid,
    required this.status,
    required this.boat,
    required this.review,
  });

  // Method untuk mengonversi dari JSON ke objek Reservation
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
      status: json['status'],
      boat: Boat.fromJson(json['boat']),
      review: (json['review'] as List<dynamic>)
          .map((item) => Review.fromJson(item))
          .toList(),
    );
  }

  // Method untuk mengonversi dari objek Reservation ke JSON
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
      'status': status,
      'boat': boat.toJson(),
      'review': review.map((item) => item.toJson()).toList(),
    };
  }
}

// Model untuk Boat
class Boat {
  final int boatId;
  final String boatName;
  final int capacity;
  final double price;

  Boat({
    required this.boatId,
    required this.boatName,
    required this.capacity,
    required this.price,
  });

  factory Boat.fromJson(Map<String, dynamic> json) {
    return Boat(
      boatId: json['boat_id'],
      boatName: json['boat_name'],
      capacity: json['capacity'],
      price: json['price'].toDouble(), // Mengonversi ke double
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'boat_id': boatId,
      'boat_name': boatName,
      'capacity': capacity,
      'price': price,
    };
  }
}

// Model untuk Review
class Review {
  // Tambahkan properti sesuai kebutuhan
  // Contoh:
  final String comment;

  Review({
    required this.comment,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      comment: json['comment'] ??
          '', // Sesuaikan dengan struktur review yang sebenarnya
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
    };
  }
}
