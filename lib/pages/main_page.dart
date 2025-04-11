import 'package:demo_project/common/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:demo_project/pages/home/home.dart';
import 'package:demo_project/pages/message/message.dart';
import 'package:demo_project/pages/profile/profile.dart';
import 'package:demo_project/common/loading_queue.dart';

import 'logger/logger.dart';

//MyHomePage 类: 继承自 StatefulWidget，表示一个有状态的部件。它包含一个状态类 _MyHomePageState，用于管理部件的状态
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final LoadingQueue _loadingQueue = LoadingQueue();

  Future<void> _initializeData() async {
    _loadingQueue.show('拼命加载中...');

    try {
      // 这里添加你的初始化逻辑
      await Future.delayed(Duration(seconds: 2)); // 模拟加载时间
    } catch (e) {
      print('Error loading data: $e');
    } finally {
      _loadingQueue.dismiss();
    }
  }

  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    NotificationCenterPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    _initializeData();
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // 添加这行以支持超过3个选项
        currentIndex: _currentIndex,
        onTap: (index) {
          // 如果点击个人中心且未登录，跳转到登录页面
          if (index == 2) {
            // 个人中心索引
            if (LocalStorage.user_token.get() == null) {
              Navigator.pushNamed(context, '/login');
              return; // 阻止切换页面
            }
          }
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: '消息'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
        ],
      ),
    );
  }
}
