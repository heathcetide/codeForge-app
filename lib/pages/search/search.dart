import 'package:flutter/material.dart';
import 'package:demo_project/pages/search/search_result.dart';

// 搜索页面
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller = TextEditingController();
  List<String> searchHistory = [];

  // 添加到搜索历史
  void _addToSearchHistory(String query) {
    setState(() {
      if (!searchHistory.contains(query)) {
        searchHistory.insert(0, query); // 最近的搜索放在前面
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("搜索页面")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 搜索框
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: '请输入搜索内容',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      String query = _controller.text.trim();
                      if (query.isNotEmpty) {
                        _addToSearchHistory(query);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => SearchResultPage(query: query),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              // 搜索历史
              if (searchHistory.isNotEmpty) ...[
                Text('搜索历史', style: TextStyle(fontWeight: FontWeight.bold)),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchHistory.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(searchHistory[index]),
                      onTap: () {
                        _controller.text = searchHistory[index];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => SearchResultPage(
                                  query: searchHistory[index],
                                ),
                          ),
                        );
                      },
                    );
                  },
                ),
                Divider(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
