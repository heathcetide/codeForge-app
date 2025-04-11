import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:demo_project/pages/search/search.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _tabs = ['首页', '泌尿外科', '妇科', '骨科', '血管外科'];
  int _selectedIndex = 0;
  RefreshController refreshController = RefreshController();

  List<Widget> tabPages = [
    RefreshableContent(),
    RefreshableContent(),
    RefreshableContent(),
    RefreshableContent(),
    RefreshableContent(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(),
            TabBarWidget(
              tabs: _tabs,
              selectedIndex: _selectedIndex,
              onTabSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
            Expanded(
              child: IndexedStack(index: _selectedIndex, children: tabPages),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // 点击搜索框时跳转到搜索页面
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
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
          ),
          SizedBox(width: 8),
          IconButtonWithCircle(icon: Icons.message_outlined),
          SizedBox(width: 8),
          IconButtonWithCircle(icon: Icons.add),
        ],
      ),
    );
  }
}

class IconButtonWithCircle extends StatelessWidget {
  final IconData icon;

  const IconButtonWithCircle({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(18),
      ),
      child: Icon(icon, color: Colors.grey),
    );
  }
}

class TabBarWidget extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabSelected;

  const TabBarWidget({
    Key? key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onTabSelected(index),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    color: selectedIndex == index ? Colors.blue : Colors.black,
                    fontSize: 16,
                    fontWeight:
                        selectedIndex == index
                            ? FontWeight.bold
                            : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class RefreshableContent extends StatelessWidget {
  const RefreshableContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: RefreshController(),
      enablePullDown: true,
      enablePullUp: true,
      header: ClassicHeader(),
      footer: ClassicFooter(),
      onLoading: () async {
        await Future.delayed(Duration(seconds: 3));
      },
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 3));
      },
      child: SingleChildScrollView(
        child: Column(children: [BannerSlider(), ItemGrid()]),
      ),
    );
  }
}

class BannerSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> imageUrls = [
      'https://cetide-1325039295.cos.ap-chengdu.myqcloud.com/codeforge/course/MySQL/MySQL_COURSE_2.png',
      'https://cetide-1325039295.cos.ap-chengdu.myqcloud.com/codeforge/course/MySQL/MySQL_COURSE_3.png',
      'https://cetide-1325039295.cos.ap-chengdu.myqcloud.com/codeforge/course/MySQL/MySQL_COURSE_4.png',
      'https://cetide-1325039295.cos.ap-chengdu.myqcloud.com/codeforge/course/Git/Git_COURSE_1.png',
    ];

    return Container(
      height: 180,
      width: double.infinity,
      child: Swiper(
        indicatorLayout: PageIndicatorLayout.NONE,
        autoplay: true,
        pagination: const SwiperPagination(),
        control: const SwiperControl(),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            margin: EdgeInsets.all(20),
            height: 150,
            child: Image.network(imageUrls[index], fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}

class ItemGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
        return ItemCard(index: index);
      },
    );
  }
}

class ItemCard extends StatelessWidget {
  final int index;

  const ItemCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
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
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
