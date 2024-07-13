import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project/features/appbar_global.dart';
import 'package:flutter_project/features/auth/services/auth/firebase_auth_service.dart';
import 'package:flutter_project/features/home/widgets/side_menu.dart';
import 'package:flutter_project/features/message/screens/message_chat_screen.dart';
import 'package:flutter_project/features/message/services/chat_service.dart';
import 'package:flutter_project/features/message/services/user_tile.dart';
import 'package:flutter_project/features/message/widgets/shimmer_chat.dart';
import 'package:flutter_project/features/notification/screens/notification_page.dart';
import 'package:flutter_project/features/profile/screens/setting_page.dart';
import 'package:flutter_project/features/search/widgets/search_page_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shimmer/shimmer.dart';

class MessageScreen extends StatefulWidget {
  static const String routeName = '/message-screen';
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final ChatService _chatService = ChatService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<String?> _lastMessageFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideMenu(),
      drawerScrimColor: Colors.black38,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF50B498),
            ),
          ),
          title: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, SearchPageWidget.routeName);
            },
            child: Container(
              width: double.infinity,
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.search,
                      color: Colors.black26,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Search..',
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          color: Colors.black26,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 30.0,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, NotificationPage.routeName);
              },
              icon: Image.asset(
                'assets/images/notification.png',
                height: 34.0,
              ),
            ),
            FutureBuilder<String?>(
                future: ProfileDataManager.getProfilePic(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width:
                            40, // Lebar dan tinggi yang sama untuk membuatnya bulat
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SettingPage.routeName);
                      },
                      icon: CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.white30,
                        backgroundImage: NetworkImage(snapshot.data!),
                      ),
                    );
                  } else {
                    return Text('no data');
                  }
                }),
          ],
        ),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading users'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          List<Map<String, dynamic>> users = snapshot.data ?? [];

          return FutureBuilder<List<Map<String, dynamic>>>(
            future: _getUsersWithLastMessageTime(users),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFD2E9FF), // Warna gradient awal
                            Color(0xFFFFFFFF), // Warna gradient akhir
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/bookit.png',
                                  height: 24,
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(16, 10, 20, 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/inbox.png',
                                  height: 30,
                                ),
                                Text(
                                  'Message',
                                  style: GoogleFonts.raleway(
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.6,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 700,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: ShimmerWidget.circular(
                                        width: 64, height: 64),
                                    title: ShimmerWidget.rectangular(
                                      height: 16,
                                      width: 40,
                                    ),
                                    subtitle:
                                        ShimmerWidget.rectangular(height: 14),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Error loading messages'));
              }

              List<Map<String, dynamic>> sortedUsers = snapshot.data ?? [];

              return Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFD2E9FF), // Warna gradient awal
                          Color(0xFFFFFFFF), // Warna gradient akhir
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(16, 10, 20, 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/inbox.png',
                                height: 30,
                              ),
                              Text(
                                'Message',
                                style: GoogleFonts.raleway(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.6,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 700,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: sortedUsers.length,
                            itemBuilder: (context, index) {
                              var user = sortedUsers[index];
                              String senderUid =
                                  _authService.getCurrentUser()!.uid;
                              List<String> ids = [user['uid'], senderUid];
                              ids.sort();
                              String chatRoomId = ids.join("-");
                              _lastMessageFuture =
                                  _chatService.getLastMessage(chatRoomId);
                              return FutureBuilder<String?>(
                                future: _lastMessageFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // Tampilkan loading indicator jika data masih diambil
                                    return Container();
                                  } else if (snapshot.hasError) {
                                    // Tampilkan pesan error jika terjadi kesalahan
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    // Tampilkan last message jika data berhasil diambil
                                    String? lastMessage = snapshot.data;
                                    if (lastMessage != null &&
                                        user['email'] !=
                                            _authService
                                                .getCurrentUser()!
                                                .email) {
                                      return UserTile(
                                        email: user['email'],
                                        recieverUid: user['uid'],
                                        senderUid: senderUid,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MessageInboxScreen(
                                                receiverEmail: user['email'],
                                                receiverID: user['uid'],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _getUsersWithLastMessageTime(
      List<Map<String, dynamic>> users) async {
    String senderUid = _authService.getCurrentUser()!.uid;

    for (var user in users) {
      List<String> ids = [user['uid'], senderUid];
      ids.sort();
      String chatRoomId = ids.join("-");

      var lastMessageData =
          await _chatService.getLastMessageWithTime(chatRoomId);
      if (lastMessageData != null) {
        user['lastMessageTime'] = lastMessageData['timestamp'];
        user['lastMessage'] = lastMessageData['message'];
      } else {
        user['lastMessageTime'] =
            Timestamp(0, 0); // Atur ke waktu default jika tidak ada pesan
      }
    }

    // Urutkan pengguna berdasarkan waktu pesan terakhir
    users.sort((a, b) => b['lastMessageTime'].compareTo(a['lastMessageTime']));

    return users;
  }
}
