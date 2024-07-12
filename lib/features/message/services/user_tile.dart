import 'package:flutter/material.dart';
import 'package:flutter_project/features/appbar_global.dart';
import 'package:flutter_project/features/message/services/chat_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class UserTile extends StatefulWidget {
  final String email;
  final String recieverUid;
  final String senderUid;
  final void Function()? onTap;

  const UserTile({
    super.key,
    required this.email,
    required this.recieverUid,
    required this.senderUid,
    this.onTap,
  });

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  final ChatService _chatService = ChatService();
  late Future<String?> _lastMessageFuture;
  late Future<DateTime?> _lastMessageTimeFuture;

  @override
  void initState() {
    getLastMessage();
    super.initState();
  }

  getLastMessage() {
    List<String> ids = [widget.recieverUid, widget.senderUid];
    ids.sort();
    String chatRoomId = ids.join("-");
    print(chatRoomId);
    _lastMessageFuture = _chatService.getLastMessage(chatRoomId);
    _lastMessageTimeFuture = _chatService.getLastMessageTime(chatRoomId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          splashColor: Colors.white12,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    FutureBuilder<String?>(
                        future:
                            ProfileDataManager.getImageChat(widget.recieverUid),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: CircleAvatar(
                                radius: 26,
                                backgroundColor: Colors.white,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error ${snapshot.error}');
                          } else {
                            return CircleAvatar(
                              radius: 26,
                              backgroundColor: Colors.white30,
                              backgroundImage: NetworkImage(snapshot.data!),
                            );
                          }
                        }),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.email,
                                style: GoogleFonts.raleway(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.6,
                                  ),
                                ),
                              ),
                              FutureBuilder<DateTime?>(
                                future: _lastMessageTimeFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        width: 50,
                                        height: 10,
                                        color: Colors.white,
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    DateTime? lastMessageTime = snapshot.data;
                                    if (lastMessageTime != null) {
                                      DateFormat('d MMMM')
                                          .format(lastMessageTime);
                                      String timeAgo =
                                          _getTimeAgo(lastMessageTime);
                                      return Text(
                                        timeAgo, // Convert Timestamp to DateTime and format it
                                        style: GoogleFonts.raleway(
                                          textStyle: const TextStyle(
                                            color: Colors.black45,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: -0.6,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                          Container(
                            constraints: const BoxConstraints(
                              maxWidth: 280,
                            ),
                            child: FutureBuilder<String?>(
                              future: _lastMessageFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // Tampilkan loading indicator jika data masih diambil
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      width: double.infinity,
                                      height: 20,
                                      color: Colors.white,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  // Tampilkan pesan error jika terjadi kesalahan
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  // Tampilkan last message jika data berhasil diambil
                                  String? lastMessage = snapshot.data;
                                  if (lastMessage != null) {
                                    return Text(lastMessage);
                                  } else {
                                    return const Text('No messages.');
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime time) {
    Duration difference = DateTime.now().difference(time);
    if (difference.inDays > 0) {
      return DateFormat('d MMMM')
          .format(time); // Lebih dari 24 jam, tampilkan tanggal
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'just now';
    }
  }
}
