import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_project/zzunused/chatAI/screens/ainavigate_screen.dart';
import 'package:flutter_project/variables.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AIChatPage extends StatefulWidget {
  static const String routeName = '/aichat-page';
  const AIChatPage({super.key});

  @override
  State<AIChatPage> createState() => _AIChatPageState();
}

class _AIChatPageState extends State<AIChatPage> {
  final Gemini gemini = Gemini.instance;

  ChatUser currentUser = ChatUser(id: "0", firstName: "bian");
  ChatUser geminiUser = ChatUser(id: "1", firstName: "Gemini");
  String kota = '';
  List<ChatMessage> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          'AI Asisstant',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return DashChat(
      inputOptions: InputOptions(
        trailing: [
          IconButton(
            onPressed: _sendMediaMessage,
            icon: const Icon(Icons.image),
          ),
        ],
      ),
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
      messageOptions: const MessageOptions(
          currentUserTextColor: Color(0xFF19465F),
          textColor: Colors.white,
          currentUserContainerColor: Color(0xFF92D5FB),
          containerColor: Colors.blue),
    );
  }

  void _sendMessage(ChatMessage chatMessage) async {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      // Kirim pesan pengguna Bian ke endpoint /chat di localhost:3000
      final response = await http.post(
        Uri.parse('${ipaddr}/node/chat'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'userInput': chatMessage.text}),
      );

      // Periksa apakah respons berhasil atau tidak
      if (response.statusCode == 200) {
        // Jika berhasil, proses responsnya
        final responseData = jsonDecode(response.body);
        if (responseData['response'].contains("=") ||
            responseData['response'].contains("&")) {
          String responseText2 = responseData['response'];
          kota = responseText2;
          ChatMessage geminiMessage = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: 'Baiklah apakah anda ingin melihat lihat kamarnya?',
          );
          setState(() {
            messages = [geminiMessage, ...messages];
          });
          print(chatMessage.text);
        } else {
          String responseText = responseData['response'];

          // Tambahkan pesan dari server ke daftar pesan Gemini
          ChatMessage geminiMessage = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: responseText,
          );
          setState(() {
            messages = [geminiMessage, ...messages];
          });
        }
        if (chatMessage.text == 'ya' || chatMessage.text == 'Ya') {
          print('ini ya $chatMessage');
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AINavigateScreen(
                    namaKota: kota,
                  )));
        }
      } else {
        // Jika gagal, tampilkan pesan kesalahan
      }
    } catch (e) {
      rethrow;
    }
  }

  void _sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
          user: currentUser,
          createdAt: DateTime.now(),
          text: "Describe this picture!",
          medias: [
            ChatMedia(
              url: file.path,
              fileName: "",
              type: MediaType.image,
            ),
          ]);
      _sendMessage(chatMessage);
    }
  }
}
