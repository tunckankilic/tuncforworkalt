import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:tuncforworkalt/controllers/chat_provider.dart';
import 'package:tuncforworkalt/models/message.dart';
import 'package:tuncforworkalt/services/helpers/messaging_helper.dart';
import 'package:tuncforworkalt/views/common/app_bar.dart';
import 'package:tuncforworkalt/views/common/exports.dart';
import 'package:tuncforworkalt/views/common/height_spacer.dart';
import 'package:tuncforworkalt/views/common/loader.dart';
import 'package:tuncforworkalt/views/ui/chat/widgets/textfield.dart';
import 'package:tuncforworkalt/views/ui/mainscreen.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    required this.title,
    required this.id,
    required this.profile,
    required this.user,
    super.key,
  });

  final String title;
  final String id;
  final String profile;
  final List<String> user;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late Stream<List<Message>> messagesStream;
  TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late String receiver;
  int limit = 20;

  void _setReceiver() {
    final chatNotifier = Provider.of<ChatNotifier>(context, listen: false);
    receiver = widget.user.firstWhere(
      (id) => id != chatNotifier.userId,
      orElse: () => 'unknown', // Eğer eşleşen bir ID bulunamazsa
    );
  }

  @override
  void initState() {
    super.initState();
    messagesStream = FirebaseMessagingHelper.getMessages(widget.id, limit);
    _setReceiver();
  }

  void sendMessage(String content, String chatId, String receiver) {
    final model = Message(
      id: '', // Firestore will generate this
      senderId: Provider.of<ChatNotifier>(context, listen: false).userId!,
      receiverId: receiver,
      content: content,
      timestamp: DateTime.now(),
    );

    FirebaseMessagingHelper.sendMessage(model).then((response) {
      final emission = response[2];
      // Eğer soket işlevselliğini korumak istiyorsanız, burada soket emit işlemini yapabilirsiniz
      // socket!.emit('new message', emission);

      setState(() {
        messageController.clear();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatNotifier>(
      builder: (context, chatNotifier, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: CustomAppBar(
              text: widget.title,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.profile),
                  ),
                ),
              ],
              child: Padding(
                padding: EdgeInsets.all(12.0.h),
                child: GestureDetector(
                  onTap: () => Get.to(() => const MainScreen()),
                  child: const Icon(MaterialCommunityIcons.arrow_left),
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.h),
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder<List<Message>>(
                      stream: messagesStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return ReusableText(
                            text: 'Error ${snapshot.error}',
                            style: appstyle(
                                20,
                                Color(AppConstants.kOrange.value),
                                FontWeight.bold),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const SearchLoading(text: 'No messages yet');
                        } else {
                          final messages = snapshot.data!;
                          return ListView.builder(
                            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
                            itemCount: messages.length,
                            reverse: true,
                            controller: _scrollController,
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              return Padding(
                                padding: EdgeInsets.only(top: 8, bottom: 12.h),
                                child: Column(
                                  children: [
                                    ReusableText(
                                      text: chatNotifier.msgTime(
                                          message.timestamp.toString()),
                                      style: appstyle(
                                          16,
                                          Color(AppConstants.kDark.value),
                                          FontWeight.normal),
                                    ),
                                    const HeightSpacer(size: 15),
                                    ChatBubble(
                                      alignment: message.senderId ==
                                              chatNotifier.userId
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      backGroundColor: message.senderId ==
                                              chatNotifier.userId
                                          ? Color(AppConstants.kOrange.value)
                                          : Color(
                                              AppConstants.kLightBlue.value),
                                      elevation: 0,
                                      clipper: ChatBubbleClipper4(
                                        radius: 8,
                                        type: message.senderId ==
                                                chatNotifier.userId
                                            ? BubbleType.sendBubble
                                            : BubbleType.receiverBubble,
                                      ),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: width * 0.8),
                                        child: ReusableText(
                                          text: message.content,
                                          style: appstyle(
                                              14,
                                              Color(AppConstants.kLight.value),
                                              FontWeight.normal),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12.h),
                    alignment: Alignment.bottomCenter,
                    child: MessaginTextField(
                      onSubmitted: (_) {
                        final msg = messageController.text;
                        sendMessage(msg, widget.id, receiver);
                      },
                      sufixIcon: GestureDetector(
                        onTap: () {
                          final msg = messageController.text;
                          sendMessage(msg, widget.id, receiver);
                        },
                        child: Icon(
                          Icons.send,
                          size: 24,
                          color: Color(AppConstants.kLightBlue.value),
                        ),
                      ),
                      onTapOutside: (_) {
                        // Eğer typing olayını işlemek istiyorsanız:
                        // sendStopTypingEvent(widget.id);
                      },
                      onChanged: (_) {
                        // Eğer typing olayını işlemek istiyorsanız:
                        // sendTypingEvent(widget.id);
                      },
                      onEditingComplete: () {
                        final msg = messageController.text;
                        sendMessage(msg, widget.id, receiver);
                      },
                      messageController: messageController,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
