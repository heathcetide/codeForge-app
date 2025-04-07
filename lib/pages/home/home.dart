import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _tabs = ['首页', '泌尿外科', '妇科', '骨科', '血管外科'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 自定义 AppBar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  // 搜索框
                  Expanded(
                    child: Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(Icons.search, color: Colors.grey),
                          ),
                          Text(
                            '请输入',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  // 消息按钮
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(Icons.message_outlined, color: Colors.grey),
                  ),
                  SizedBox(width: 8),
                  // 更多按钮
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(Icons.add, color: Colors.grey),
                  ),
                ],
              ),
            ),
            // 标签栏
            Container(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _tabs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: Text(
                        _tabs[index],
                        style: TextStyle(
                          color: index == 0 ? Colors.blue : Colors.black,
                          fontSize: 16,
                          fontWeight:
                              index == 0 ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // 内容区域
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 轮播图
                    Container(
                      margin: EdgeInsets.all(16),
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/banner.png',
                          ), // 确保你有这个图片资源
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // 这里可以添加更多内容
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
