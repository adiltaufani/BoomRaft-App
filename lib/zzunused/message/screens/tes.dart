import 'package:flutter/material.dart';
import 'package:flutter_project/appbar_global.dart';
import 'package:flutter_project/zzunused/message/screens/message_chat_screen.dart';
import 'package:flutter_project/services/firebase_auth_service.dart';
import 'package:flutter_project/zzunused/message/services/chat_service.dart';
import 'package:flutter_project/widgets/side_menu.dart';
import 'package:flutter_project/zzunused/message/services/user_tile.dart';
import 'package:flutter_project/screens/notification_page.dart';
import 'package:flutter_project/screens/setting_page.dart';
import 'package:flutter_project/zzunused/search/widgets/search_page_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageScreen extends StatefulWidget {
  static const String routeName = '/message-screen';
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final ChatService _chatService = ChatService();
  late Future<String?> _lastMessageFuture;

  bool isTextFieldFocused = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

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
                color: const Color(0xFF50B498),
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
                      return Container();
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
        body: _buildUserList());
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {
          //eror
          if (snapshot.hasError) {
            return const Text('error');
          }

          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('loading');
          }

          //return listview
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
                    ListView(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: snapshot.data!
                          .map<Widget>((userData) =>
                              _buildUserListItem(userData, context))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    String senderUid = _authService.getCurrentUser()!.uid;
    List<String> ids = [userData['uid'], senderUid];
    ids.sort();
    String chatRoomId = ids.join("-");

    _lastMessageFuture = _chatService.getLastMessage(chatRoomId);
    return FutureBuilder<String?>(
      future: _lastMessageFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Tampilkan loading indicator jika data masih diambil
          return Container();
        } else if (snapshot.hasError) {
          // Tampilkan pesan error jika terjadi kesalahan
          return Text('Error: ${snapshot.error}');
        } else {
          // Tampilkan last message jika data berhasil diambil
          String? lastMessage = snapshot.data;
          if (lastMessage != null &&
              userData['email'] != _authService.getCurrentUser()!.email) {
            return UserTile(
              email: userData['email'],
              recieverUid: userData['uid'],
              senderUid: senderUid,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MessageInboxScreen(
                      receiverEmail: userData['email'],
                      receiverID: userData['uid'],
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
  }
}
