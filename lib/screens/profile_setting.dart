import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_project/routes/router.dart';
import 'package:flutter_project/screens/home_screen.dart';
import 'package:flutter_project/screens/main_screen.dart';
import 'package:flutter_project/screens/setting_page.dart';
import 'package:flutter_project/services/firebase_auth_service.dart';
import 'package:flutter_project/services/user_services.dart';
import 'package:flutter_project/themes/theme.dart';
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
  String firstname = '';
  String lastname = '';
  String email = '';
  String pp = '';
  String? number;
  String? birthdate;
  String? address;
  bool firstnameTrigger = false;
  bool isDataAvail = false;
  String uid = '';
  String id = '';
  Map<String, dynamic> userData = {};
  Future<Map<String, dynamic>>? userProfile;

  @override
  void initState() {
    super.initState();
    userProfile = UserServices().getProfile();
  }

  @override
  void dispose() {
    _name
        .dispose(); // pastikan untuk membuang controller saat halaman dihancurkan
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: buildScreen(context));
            // } else if (snapshot.hasError) {
            //   return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            userData = snapshot.data!;
          }
          _name.text = userData['name'] ?? '';
          _number.text = userData['phone'] ?? '';
          _birthdate.text = userData['birth'] ?? '';
          _address.text = userData['city'] ?? '';
          return buildScreen(context);
        });
  }

  Widget buildScreen(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            currentScreen = const SettingPage();
            Navigator.pushNamed(context, MainScreen.routeName);
          },
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
                    color: Color(0xFFFFF492)),
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
                                        child: const AspectRatio(
                                            aspectRatio: 1.0,
                                            child:
                                                // isDataAvail
                                                //     ?
                                                CircleAvatar(
                                                    radius: 40,
                                                    backgroundColor:
                                                        Colors.white30,
                                                    backgroundImage: AssetImage(
                                                        'assets/images/profile.png')

                                                    // NetworkImage(pp),
                                                    )
                                            // : const CircularProgressIndicator(),
                                            ),
                                      ),
                                      // Tombol unggah di atas foto profil
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            // uploadFile();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.black26),
                                            child: const Icon(
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
                                        '${userData['name'] ?? 'loading'}',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 24,
                                          color: AppTheme.darkBlue,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(
                                        '${userData['email'] ?? 'loading'}',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: AppTheme.darkBlue
                                              .withOpacity(0.6),
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
                          child:
                              // firstnameTrigger
                              //     ?
                              Column(
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
                                        if (value == null || value.isEmpty) {
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
                                        if (value == null || value.isEmpty) {
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
                                        if (value == null || value.isEmpty) {
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
                                        if (value == null || value.isEmpty) {
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
                                    // Container(
                                    //   padding: const EdgeInsets.symmetric(
                                    //     horizontal: 30,
                                    //   ),
                                    //   height: 50,
                                    //   child: ElevatedButton(
                                    //     onPressed: () async {
                                    //       if (_signUpFormKey.currentState!
                                    //           .validate()) {
                                    //         await AuthService()
                                    //             .registerUser(
                                    //           _nameController.text,
                                    //           _lastnameController.text,
                                    //           _emailController.text,
                                    //           _passwordController.text,
                                    //         );
                                    //         Navigator.pushNamed(context,
                                    //             MainScreen.routeName);
                                    //       }
                                    //     },
                                    //     style: ElevatedButton.styleFrom(
                                    //       shape: RoundedRectangleBorder(
                                    //         borderRadius:
                                    //             BorderRadius.circular(12),
                                    //       ),
                                    //       backgroundColor:
                                    //           AppTheme.darkBlue,
                                    //     ),
                                    //     child: Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.center,
                                    //       children: [
                                    //         Text(
                                    //           'SIGN UP',
                                    //           style: GoogleFonts.montserrat(
                                    //             textStyle: const TextStyle(
                                    //               color: Colors.white,
                                    //               fontSize: 18,
                                    //               fontWeight:
                                    //                   FontWeight.w800,
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 26),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      height: 50,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          backgroundColor: AppTheme.darkBlue,
                                        ),
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                                  .validate() ??
                                              false) {
                                            _formKey.currentState?.save();
                                            await UserServices().updateProfile(
                                              _name.text,
                                              _number.text,
                                              _birthdate.text,
                                              _address.text,
                                            );
                                            currentScreen = const HomeScreen();
                                            Navigator.pushNamed(
                                                context, MainScreen.routeName);
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
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                          // : const Center(child: CircularProgressIndicator()),
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

  // Future<void> fetchUserData() async {
  //   var user = FirebaseAuth.instance.currentUser;

  //   // Pastikan user sudah login
  //   if (user == null) {
  //     // Jika user belum login, tampilkan pesan
  //     return; // Keluar dari metode fetchUserData
  //   }

  //   var url = Uri.parse("${ipaddr}/ta_projek/crudtaprojek/view_data.php");
  //   uid = user.uid;

  //   var response = await http.post(url, body: {
  //     "uid": uid,
  //   });

  //   var data = json.decode(response.body);
  //   if (data != null) {
  //     // Data berhasil diterima, tampilkan firstname dan lastname
  //     firstname = data['firstname'];
  //     lastname = data['lastname'];
  //     number = data['number'];
  //     birthdate = data['birthdate'];
  //     address = data['address'];
  //     email = data['email'];
  //     id = data['id'];
  //     pp = await getImageUrl('images/image_$uid.jpg');

  //     _name.text = userData['email'];
  //     _number.text = number!;
  //     _birthdate.text = birthdate!;
  //     _address.text = address!;

  //     setState(() {
  //       isDataAvail = true;
  //     });
  //     // Lakukan apapun yang Anda ingin lakukan dengan data ini
  //   } else {
  //     throw ("Gagal mendapatkan data penggunasdasda");
  //   }

  //   if (firstname != null) {
  //     firstnameTrigger = true;
  //   }
  // }

  // void updateUserData(String id, String name, String number, String birthdate,
  //     String address) async {
  //   var url = Uri.parse('${ipaddr}/ta_projek/crudtaprojek/updateusers.php');
  //   var response = await http.post(url, body: {
  //     'id': id,
  //     'firstname': name,
  //     'number': number,
  //     'birthdate': birthdate,
  //     'address': address,
  //   });

  //   if (response.statusCode == 200) {
  //     print('Data berhasil diperbarui');
  //     showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text('Berhasil Melakukan Perubahan Data'),
  //             content: Text('Dicek lagi ya datanya :)'),
  //             actions: [
  //               TextButton(
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                   child: Text('ok'))
  //             ],
  //           );
  //         });
  //   } else {
  //     print('Error: ${response.reasonPhrase}');
  //   }
  // }

  // final FirebaseStorage _storage = FirebaseStorage.instance;
  // Future<void> uploadFile() async {
  //   // Mengambil gambar dari galeri
  //   ImagePicker picker = ImagePicker();
  //   XFile? file = await picker.pickImage(
  //     source: ImageSource.gallery,
  //   );
  //   // Atau dapatkan gambar dari kamera: ImageSource.camera

  //   if (file != null) {
  //     // Buat nama file yang unik dengan menambahkan timestamp
  //     String fileName = 'image_${uid}.jpg';

  //     // Buat referensi Firebase Storage dengan nama file baru
  //     Reference ref = _storage.ref().child("images/$fileName");

  //     // Mulai upload
  //     UploadTask uploadTask = ref.putFile(File(file.path));

  //     // Menangani status upload
  //     uploadTask.then((res) {
  //       // Upload selesai
  //       print("File uploaded successfully!");
  //     }).catchError((err) {
  //       // Terjadi kesalahan
  //       print("Error uploading file: $err");
  //     });
  //   }
  // }

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
