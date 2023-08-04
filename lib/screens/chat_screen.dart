import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_chat_types/src/message.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lumios/providers/chat_messages_provider.dart';
import 'package:lumios/providers/chat_user_provider.dart';
import 'package:random_avatar/random_avatar.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatUser = ref.watch(chatUserProvider)!;
    const theme = DefaultChatTheme();
    return ref.watch(isLoadingProvider) 
      ? const Center(child: CircularProgressIndicator())
      : Chat(
        messages: ref.watch(chatMessagesProvider),
        onSendPressed: (p0) {
          ref.read(chatMessagesProvider.notifier).sendMessage(p0.text).catchError(onSendError);
        },
        user: chatUser,
        avatarBuilder: (userId) => RandomAvatar(userId, width: 48),
        showUserAvatars: true,
        showUserNames: true,
        typingIndicatorOptions: TypingIndicatorOptions(typingUsers: ref.watch(typingUsersProvider)),
        bubbleBuilder: (child, {required message, required nextMessageInGroup}) => bubbleBuilder(
          child, 
          message: message,
          nextMessageInGroup: 
          nextMessageInGroup, 
          authorIsUser: message.author.id == chatUser.id,
          theme: theme,
        ),
        theme: theme,
      );
  }

  void onSendError(Object error, StackTrace stackTrace) {
    print('Error sending message: $error');
    print(stackTrace);
    Fluttertoast.showToast(
      msg: "Cloud not send message. Please refresh the page.",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Widget bubbleBuilder(Widget child, {
    required types.Message message, 
    required bool nextMessageInGroup, 
    required bool authorIsUser,
    required ChatTheme theme,
  }) {
    final borderRadius = BorderRadiusDirectional.only(
      bottomEnd: Radius.circular(
        !authorIsUser || nextMessageInGroup ? theme.messageBorderRadius : 0,
      ),
      bottomStart: Radius.circular(
        authorIsUser || nextMessageInGroup ? theme.messageBorderRadius : 0,
      ),
      topEnd: Radius.circular(theme.messageBorderRadius),
      topStart: Radius.circular(theme.messageBorderRadius),
    );
    final iconColor = getUserAvatarNameColor(message.author, theme.userAvatarNameColors);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(!authorIsUser && message.metadata?['isFunctionCall'] == true)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Icon(Icons.call_made, size: 24, color: iconColor,),
          ),
        Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: !authorIsUser ||
                    message.type == types.MessageType.image
                ? theme.secondaryColor
                : theme.primaryColor,
          ),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: child,
          ),
        ),
      ],
    );
  }

  Color getUserAvatarNameColor(User user, List<Color> colors) =>
    colors[user.id.hashCode % colors.length];
}
