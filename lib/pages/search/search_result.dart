import 'package:flutter/material.dart';

// 搜索结果页面
class SearchResultPage extends StatefulWidget {
  final String query;

  const SearchResultPage({Key? key, required this.query}) : super(key: key);

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  bool isLoading = false;
  List<String> searchResults = [];

  // 模拟搜索过程（模拟延迟）
  Future<void> _performSearch() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    // 模拟搜索结果
    setState(() {
      searchResults = List.generate(
        10,
            (index) => '${widget.query} 搜索结果 $index',
      );
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _performSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("搜索结果")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 搜索结果加载中的指示器
              if (isLoading) ...[
                Center(child: CircularProgressIndicator()),
              ],
              // 显示搜索结果
              if (!isLoading && searchResults.isNotEmpty) ...[
                Text('搜索结果', style: TextStyle(fontWeight: FontWeight.bold)),
                // 使用 ListView.builder 来动态构建每个搜索结果的卡片
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16.0),
                        title: Text(
                          searchResults[index],
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          "点击查看详情",
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // 你可以在这里添加点击事件处理逻辑，例如跳转到详情页面
                          print("点击了: ${searchResults[index]}");
                        },
                      ),
                    );
                  },
                ),
              ],
              // 如果没有找到相关结果
              if (!isLoading && searchResults.isEmpty) ...[
                Center(child: Text('没有找到相关结果')),
              ],
            ],
          ),
        ),
      ),
    );
  }
}