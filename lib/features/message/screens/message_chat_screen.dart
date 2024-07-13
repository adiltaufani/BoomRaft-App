import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/features/auth/services/auth/firebase_auth_service.dart';
import 'package:flutter_project/features/message/screens/message_screen.dart';
import 'package:flutter_project/features/message/services/chat_service.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageInboxScreen extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;
  static const String routeName = '/message-inbox-screen';
  MessageInboxScreen(
      {super.key, required this.receiverEmail, required this.receiverID});

  @override
  State<MessageInboxScreen> createState() => _MessageInboxScreenState();
}

class _MessageInboxScreenState extends State<MessageInboxScreen> {
  // text controller
  final TextEditingController _messageController = TextEditingController();

  //chat & auth services
  final ChatService _chatService = ChatService();
  final FirebaseAuthService _authService = FirebaseAuthService();

  //for textfield focus
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(
          Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });

    Future.delayed(
      const Duration(milliseconds: 400),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 600),
      curve: Curves.fastOutSlowIn,
    );
  }

  //send message
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      //send the message
      await _chatService.sendMessage(
          widget.receiverID, _messageController.text);

      //clear text controller
      _messageController.clear();
    }

    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: const Color(0xFF50B498),
            ),
          ),
          title: Text(
            widget.receiverEmail,
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.6,
              ),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, MessageScreen.routeName);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 6),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFD4EAFE), // Warna gradient awal
              Color(0xFFB3DAFF), // Warna gradient akhir
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              //display all messages
              child: _buildMessageList(),
            ),

            // user input
            _buildUserInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverID, senderId),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Text('error');
        }

        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading');
        }

        //return list view
        return ListView(
          controller: _scrollController,
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    //align message to the right if  sener is the current user
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isCurrentUser ? const Color(0xFF92D5FB) : Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              data['message'],
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: isCurrentUser
                      ? const Color(0xFF19465F)
                      : const Color(0xFFFFFFFF),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInput() {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Row(
          children: [
            //textfield
            Expanded(
              child: TextFormField(
                controller: _messageController,
                minLines: 1,
                maxLines: 3,
                focusNode: focusNode,
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: Colors.black38,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.4,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade800),
                      borderRadius: BorderRadius.circular(25)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(25)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
                  hintText: 'Type Message...',
                  filled: true,
                  fillColor: Colors.grey[200],
                  alignLabelWithHint: true,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF0A8ED9),
                shape: BoxShape.circle,
              ),
              margin: EdgeInsets.only(left: 10),
              child: IconButton(
                onPressed: sendMessage,
                icon: Icon(
                  CupertinoIcons.paperplane_fill,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
