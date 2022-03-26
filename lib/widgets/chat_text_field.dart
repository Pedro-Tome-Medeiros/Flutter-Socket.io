import 'package:flutter/material.dart';
import 'package:flutter_socket_io/core/view_models/chat_vm.dart';
import 'package:provider/provider.dart';

class ChatTexField extends StatelessWidget {
  const ChatTexField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatViewModel>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                  controller: provider.textController,
                  onChanged: (String text) {
                    provider.sendTyping(text.isNotEmpty);
                  })),
          IconButton(
              onPressed: () => provider.sendMessage(), icon: const Icon(Icons.send, size: 20))
        ],
      ),
    );
  }
}
