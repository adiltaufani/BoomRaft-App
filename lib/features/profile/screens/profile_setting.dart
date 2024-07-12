import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_project/features/auth/services/auth/firebase_auth_service.dart';
import 'package:flutter_project/variables.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSetting extends StatefulWidget {
  static const String routeName = '/profile-setting';
  const ProfileSetting({super.key});

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  TextEditingController _name = TextEditingController();
  TextEditingController _number = TextEditingController();
  TextEditingController _birthdate = TextEditingController();
  TextEditingController _address = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _firstname;
  String? lastname;
  String? number;
  String? birthdate;
  String? address;
  String? email;
  bool firstnameTrigger = false;
  String pp = '';
  bool isDataAvail = false;
  String uid = '';
  String id = '';

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    await fetchUserData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Center(child: Text('Profile Settings')),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.home,
              color: Color(0x00ffffff),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200, // Sesuaikan dengan tinggi gambar profil Anda
                  color: Colors.lightBlue[600],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 124,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Stack(
                                    children: [
                                      // Foto profil
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: AspectRatio(
                                          aspectRatio: 1.0,
                                          child: isDataAvail
                                              ? CircleAvatar(
                                                  radius:
                                                      40, // Menyesuaikan radius untuk memperbesar foto profil
                                                  backgroundColor:
                                                      Colors.white30,
                                                  backgroundImage:
                                                      NetworkImage(pp),
                                                )
                                              : const CircularProgressIndicator(),
                                        ),
                                      ),
                                      // Tombol unggah di atas foto profil
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            uploadFile();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.blue,
                                            ),
                                            child: Icon(
                                              Icons.camera_alt,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 18),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _firstname ?? 'Loading...',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(
                                        email ?? 'Loading...',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Colors.white54,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 32),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        color: Color(0xFFF8F8F8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        child: firstnameTrigger
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 18),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: <Widget>[
                                        TextFormField(
                                          controller: _name,
                                          decoration: const InputDecoration(
                                              labelText: "Name"),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please enter your name";
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            if (value != null) {}
                                          },
                                        ),
                                        TextFormField(
                                          controller: _number,
                                          decoration: const InputDecoration(
                                            labelText: "Number",
                                          ),
                                          keyboardType: TextInputType.phone,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please enter your number";
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            if (value != null) {}
                                          },
                                        ),
                                        TextFormField(
                                          controller: _birthdate,
                                          decoration: const InputDecoration(
                                              labelText: "Birth Date"),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please enter your birth";
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            if (value != null) {}
                                          },
                                        ),
                                        TextFormField(
                                          controller: _address,
                                          decoration: const InputDecoration(
                                              labelText: "Address"),
                                          maxLines:
                                              null, // This allows for multi-line input
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              // Tambahkan pemeriksaan null
                                              return "Please enter your address";
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            if (value != null) {
                                              // Tambahkan pemeriksaan null
                                            }
                                          },
                                        ),
                                        const SizedBox(height: 26),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              Colors.blue,
                                            ),
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              Colors.white,
                                            ),
                                          ),
                                          onPressed: () {
                                            if (_formKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              _formKey.currentState?.save();
                                              updateUserData(
                                                  id,
                                                  _name.text.toString(),
                                                  _number.text.toString(),
                                                  _birthdate.text.toString(),
                                                  _address.text
                                                      .toString()); // Proses data formulir di sini
                                            }
                                          },
                                          child: Text(
                                            'Save Profile',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchUserData() async {
    var user = FirebaseAuth.instance.currentUser;

    // Pastikan user sudah login
    if (user == null) {
      // Jika user belum login, tampilkan pesan
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
      _firstname = data['firstname'];
      lastname = data['lastname'];
      number = data['number'];
      birthdate = data['birthdate'];
      address = data['address'];
      email = data['email'];
      id = data['id'];
      pp = await getImageUrl('images/image_$uid.jpg');

      _name.text = _firstname!;
      _number.text = number!;
      _birthdate.text = birthdate!;
      _address.text = address!;

      setState(() {
        isDataAvail = true;
      });
      // Lakukan apapun yang Anda ingin lakukan dengan data ini
    } else {
      throw ("Gagal mendapatkan data penggunasdasda");
    }

    if (_firstname != null) {
      firstnameTrigger = true;
    }
  }

  void updateUserData(String id, String name, String number, String birthdate,
      String address) async {
    var url = Uri.parse('${ipaddr}/ta_projek/crudtaprojek/updateusers.php');
    var response = await http.post(url, body: {
      'id': id,
      'firstname': name,
      'number': number,
      'birthdate': birthdate,
      'address': address,
    });

    if (response.statusCode == 200) {
      print('Data berhasil diperbarui');
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Berhasil Melakukan Perubahan Data'),
              content: Text('Dicek lagi ya datanya :)'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('ok'))
              ],
            );
          });
    } else {
      print('Error: ${response.reasonPhrase}');
    }
  }

  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<void> uploadFile() async {
    // Mengambil gambar dari galeri
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
    );
    // Atau dapatkan gambar dari kamera: ImageSource.camera

    if (file != null) {
      // Buat nama file yang unik dengan menambahkan timestamp
      String fileName = 'image_${uid}.jpg';

      // Buat referensi Firebase Storage dengan nama file baru
      Reference ref = _storage.ref().child("images/$fileName");

      // Mulai upload
      UploadTask uploadTask = ref.putFile(File(file.path));

      // Menangani status upload
      uploadTask.then((res) {
        // Upload selesai
        print("File uploaded successfully!");
      }).catchError((err) {
        // Terjadi kesalahan
        print("Error uploading file: $err");
      });
    }
  }

  Future<String> getImageUrl(String imagePath) async {
    try {
      // Buat referensi Firebase Storage untuk gambar yang diunggah
      Reference ref = FirebaseStorage.instance.ref().child(imagePath);

      // Dapatkan URL download gambar
      String imageUrl = await ref.getDownloadURL();

      // Kembalikan URL download gambar
      return imageUrl;
    } catch (error) {
      // Tangkap error dan kembalikan URL gambar default jika terjadi kesalahan
      print("Error: $error");
      // Mengembalikan URL gambar default dari assets jika terjadi kesalahan
      return "https://firebasestorage.googleapis.com/v0/b/loginsignupta-prototype.appspot.com/o/images%2Fdefault.webp?alt=media&token=0f99eb8a-be98-4f26-99b7-d71776562de9";
    }
  }
}
