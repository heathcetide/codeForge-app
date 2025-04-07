// lib/pages/discover/discover.dart
import 'package:flutter/material.dart';
import 'package:demo_project/widgets/bonss_skeleton_loading.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('发现')),
      body: SkeletonLoading(
        isLoading: isLoading,
        skeleton: SingleChildScrollView(
          child: Column(
            children: [
              // 修复顶部分类列表骨架屏
              SizedBox(
                // 使用 SizedBox 替代 Container
                height: 120, // 增加高度
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemBuilder:
                      (context, index) => Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: ListItemSkeleton(),
                      ),
                ),
              ),
              // 内容网格骨架屏
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                padding: EdgeInsets.all(16),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context, index) => GridItemSkeleton(),
              ),
            ],
          ),
        ),
        // 实际内容
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 修复顶部分类列表
              SizedBox(
                // 使用 SizedBox 替代 Container
                height: 120, // 增加高度
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // 添加这行
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.person),
                          ),
                          SizedBox(height: 8),
                          Text('分类 ${index + 1}'),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // 内容网格
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                padding: EdgeInsets.all(16),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(8),
                              ),
                            ),
                            child: Center(child: Icon(Icons.image, size: 40)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '标题 ${index + 1}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '描述内容',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
