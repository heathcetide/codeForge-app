import 'package:flutter/material.dart';
import 'package:demo_project/pages/login/login.dart';
import 'package:demo_project/pages/home/home.dart';
import 'package:demo_project/pages/discover/discover.dart';
import 'package:demo_project/pages/message/message.dart';
import 'package:demo_project/pages/profile/profile.dart';
import 'package:demo_project/common/loading_queue.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

//程序入口点
void main() {
  runApp(MyApp());
}

//MyAPP 继承StatelessWidget 表示一个无状态的部件，返回一个MaterialApp 包含应用程序的基本结构和设计的部件
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //MaterialApp提供应用的主题，路由和其他全局配置
    return MaterialApp(
      title: 'CodeForge',
      // 在 MaterialApp 主题中配置
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 101, 218, 206),
        ),
        appBarTheme: AppBarTheme(
          // 新增 AppBar 主题
          backgroundColor: Colors.teal, // 全局 AppBar 背景颜色
          foregroundColor: Colors.white, // 全局文字颜色
        ),
        useMaterial3: true,
      ),
      // 定义路由表
      routes: {
        '/': (context) => MainPage(), // 主页面（包含底部导航栏）
        '/login': (context) => Login(), // 登录页面
      },
      initialRoute: '/', // 设置初始路由
      builder: (context, child) {
        return FlutterSmartDialog(child: child!);
      },
    );
  }
}

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
    DiscoverPage(),
    MessageListPage(),
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
          if (index == 3) {
            // 个人中心索引
            bool isLoggedIn = false; // 这里替换为实际的登录状态检查
            if (!isLoggedIn) {
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
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: '发现'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: '消息'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
        ],
      ),
    );
  }
}
