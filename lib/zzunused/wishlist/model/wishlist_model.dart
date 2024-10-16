class WishlistModel {
  final int? id;
  final String nama_penginapan;
  final String hotel_id;
  final String address;
  final String uid;
  final String url_foto;

  WishlistModel(
      {this.id,
      required this.nama_penginapan,
      required this.hotel_id,
      required this.address,
      required this.uid,
      required this.url_foto});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama_penginapan': nama_penginapan,
      'hotel_id': hotel_id,
      'address': address,
      'uid': uid,
      'url_foto': url_foto
    };
  }

  factory WishlistModel.fromMap(Map<String, dynamic> map) {
    return WishlistModel(
      id: map['id'],
      nama_penginapan: map['nama_penginapan'],
      hotel_id: map['hotel_id'],
      address: map['address'],
      uid: map['uid'],
      url_foto: map['url_foto'],
    );
  }
}
