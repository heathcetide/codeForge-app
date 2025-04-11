import 'package:flutter/material.dart';
import 'package:demo_project/widgets/bonss_avatar.dart';
import 'package:demo_project/common/page_scaffold.dart';
import 'package:demo_project/pages/message/message_detail.dart';

class NotificationCenterPage extends StatefulWidget {
  const NotificationCenterPage({super.key});

  @override
  State<NotificationCenterPage> createState() => _NotificationCenterPageState();
}

class _NotificationCenterPageState extends State<NotificationCenterPage> {
  // 模拟通知数据
  final List<Map<String, dynamic>> _notifications = [];
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _notifications.addAll([
      {
        "id": 1,
        "title": "系统通知",
        "content": "您有一条新的系统消息。",
        "time": "12:02",
        "unread": true,
      },
      {
        "id": 2,
        "title": "活动通知",
        "content": "别错过我们的最新活动，立即报名！",
        "time": "昨天 19:32",
        "unread": false,
      },
      {
        "id": 3,
        "title": "系统更新",
        "content": "系统将在明天进行维护，请提前做好准备。",
        "time": "昨天 15:45",
        "unread": false,
      },
      {
        "id": 4,
        "title": "提醒通知",
        "content": "您的账户存在异常登录行为，请及时处理。",
        "time": "昨天 11:02",
        "unread": true,
      },
      {
        "id": 5,
        "title": "促销活动",
        "content": "超值促销活动正在进行，赶快参与吧！",
        "time": "15:12",
        "unread": true,
      },
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: const Text("消息"),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];

                return ListTile(
                  leading: Icon(
                    Icons.notifications,
                    color: notification['unread'] ? Colors.red : Colors.grey,
                  ),
                  title: Text(
                    notification['title'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    notification['content'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        notification['time'],
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      ),
                      if (notification['unread'])
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
                            '新',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                    ],
                  ),
                  onTap: () {
                    // 这里跳转到详细的通知页面
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationDetailPage(notification: notification),
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