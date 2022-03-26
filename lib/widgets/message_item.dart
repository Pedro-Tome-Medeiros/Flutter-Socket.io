import 'package:flutter/cupertino.dart';
import 'package:flutter_socket_io/models/message_model.dart';

class MessageItem extends StatelessWidget {
  final MessageModel message;
  final bool me;

  const MessageItem({Key? key, required this.message, required this.me})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: me ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [Text(message.message)],
      ),
    );
  }
}
