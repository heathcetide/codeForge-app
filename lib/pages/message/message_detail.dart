import 'package:flutter/material.dart';
import 'package:demo_project/widgets/bonss_avatar.dart';
import 'package:demo_project/common/page_scaffold.dart';
import 'package:icons_plus/icons_plus.dart';
import 'dart:io';

class NotificationDetailPage extends StatefulWidget {
  final Map<String, dynamic> notification;  // 接收通知数据
  const NotificationDetailPage({super.key, required this.notification});

  @override
  State<NotificationDetailPage> createState() => _MessagePageState();
}

class _MessagePageState extends State<NotificationDetailPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    // 在初始化时根据传入的通知数据，生成模拟的聊天记录
    _messages.addAll([
      {
        "uid": 1,
        "name": widget.notification['title'], // 使用通知的标题作为发送者名称
        "avatar": "https://cetide-1325039295.cos.ap-chengdu.myqcloud.com/d6e4c5d9-299f-4cf3-9472-6e53f58fe3b4.jpg", // 你可以根据需求使用实际的头像 URL
        "content": widget.notification['content'], // 使用通知的内容作为聊天内容
        "isMe": false,
        "type": "text",
      },
      {
        "uid": 2,
        "name": "我",
        "avatar": "https://cetide-1325039295.cos.ap-chengdu.myqcloud.com/d6e4c5d9-299f-4cf3-9472-6e53f58fe3b4.jpg",
        "content": "你好，${widget.notification['title']}！我看到了你的通知。",
        "isMe": true,
        "type": "text",
      },
    ]);
  }

  bool _isEmojiPickerVisible = false;

  void _sendMessage({String? content, String type = "text"}) {
    if ((content == null || content.trim().isEmpty) && type == "text") return;

    setState(() {
      _messages.add({
        "uid": 2,
        "name": "我",
        "avatar": "https://cetide-1325039295.cos.ap-chengdu.myqcloud.com/d6e4c5d9-299f-4cf3-9472-6e53f58fe3b4.jpg",
        "content": content ?? _messageController.text.trim(),
        "isMe": true,
        "type": type,
      });
      _messageController.clear();
      _isEmojiPickerVisible = false;
    });
  }

  void _sendImage(File image) {
    _sendMessage(content: image.path, type: "image");
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(12.0),
          height: 120,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('选择图片'),
                onTap: () async {
                  Navigator.pop(context);
                  String imagePath = '/path/to/local/image.jpg';
                  _sendImage(File(imagePath));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.notification['title']}",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 91, 107, 146),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatBubble(
                  isMe: message['isMe'],
                  avatar: message['avatar'],
                  content: message['content'],
                  name: message['name'],
                  type: message['type'],
                );
              },
            ),
          ),
          if (_isEmojiPickerVisible)
            SizedBox(
              height: 200,
              child: GridView.count(
                crossAxisCount: 7,
                children: List.generate(28, (index) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        _messageController.text += String.fromCharCode(
                          0x1F600 + index,
                        );
                      });
                    },
                    icon: Text(String.fromCharCode(0x1F600 + index)),
                  );
                }),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.emoji_emotions_outlined),
                  onPressed: () {
                    setState(() {
                      _isEmojiPickerVisible = !_isEmojiPickerVisible;
                    });
                  },
                  color: Color.fromARGB(255, 91, 107, 146),
                ),
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: _pickImage,
                  color: Color.fromARGB(255, 91, 107, 146),
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "请输入消息...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(EvaIcons.paper_plane),
                  onPressed: () {
                    _sendMessage(content: _messageController.text.trim());
                  },
                  color: Color.fromARGB(255, 91, 107, 146),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final String avatar;
  final String content;
  final String name;
  final String type;

  const ChatBubble({
    Key? key,
    required this.isMe,
    required this.avatar,
    required this.content,
    required this.name,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            Container(
              width: 39,
              height: 39,
              margin: EdgeInsets.only(right: 12.0),
              child: Avatar(avatar, name: name),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            ),
          Flexible(
            child: Column(
              crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isMe)
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 91, 107, 146),
                    ),
                  ),
                Container(
                  margin: EdgeInsets.only(top: 4.0),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.blue[300] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child:
                  type == "text"
                      ? Text(
                    content,
                    style: TextStyle(
                      fontSize: 16,
                      color: isMe ? Colors.white : Colors.black87,
                    ),
                  )
                      : Image.file(
                    File(content),
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                  ),
                ),
              ],
            ),
          ),
          if (isMe)
            Container(
              width: 39,
              height: 39,
              margin: EdgeInsets.only(left: 12.0),
              child: Avatar(avatar, name: name),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            ),
        ],
      ),
    );
  }
}