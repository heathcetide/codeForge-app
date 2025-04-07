import 'package:flutter/material.dart';
import 'package:demo_project/widgets/bonss_avatar.dart';
import 'package:demo_project/pages/pageScaffold.dart';
import 'package:demo_project/pages/message/message_detail.dart';

class MessageListPage extends StatefulWidget {
  const MessageListPage({super.key});

  @override
  State<MessageListPage> createState() => _MessageListPageState();
}

class _MessageListPageState extends State<MessageListPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _friends = [];
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _friends.addAll([
      {
        "uid": 1,
        "name": "同学一号",
        "avatar": "https://book.flutterchina.club/assets/img/logo.png",
        "message": "文字文字！！！！！",
        "time": "12:02",
        "unreadCount": 2,
      },
      {
        "uid": 2,
        "name": "同学二号",
        "avatar": "https://book.flutterchina.club/assets/img/logo.png",
        "message": "文字文字！！！！！",
        "time": "昨天 19:32",
        "unreadCount": 0,
      },
      {
        "uid": 3,
        "name": "同学三号",
        "avatar": "https://book.flutterchina.club/assets/img/logo.png",
        "message": "文字文字！！！！！",
        "time": "昨天 15:45",
        "unreadCount": 0,
      },
      {
        "uid": 4,
        "name": "同学四号",
        "avatar": "https://book.flutterchina.club/assets/img/logo.png",
        "message": "文字文字！！！！！",
        "time": "昨天 11:02",
        "unreadCount": 0,
      },
      {
        "uid": 5,
        "name": "同学五号",
        "avatar": "https://book.flutterchina.club/assets/img/logo.png",
        "message": "文字文字！！！！！",
        "time": "15:12",
        "unreadCount": 3,
      },
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: const Text("聊天列表"),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchText = value.trim();
                });
              },
              decoration: InputDecoration(
                hintText: "搜索",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _friends.length,
              itemBuilder: (context, index) {
                final friend = _friends[index];
                if (_searchText.isNotEmpty &&
                    !friend['name'].toLowerCase().contains(
                      _searchText.toLowerCase(),
                    )) {
                  return Container();
                }
                return ListTile(
                  leading: Container(
                    width: 48,
                    height: 48,
                    child: Avatar(friend['avatar'], name: friend['name']),
                  ),
                  title: Text(
                    friend['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    friend['message'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        friend['time'],
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      ),
                      if (friend['unreadCount'] > 0)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            friend['unreadCount'] > 99
                                ? '99+'
                                : '${friend['unreadCount']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MessagePage(friend: friend),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
