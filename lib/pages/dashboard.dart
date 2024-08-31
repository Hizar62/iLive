import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<String> memeUrls = [];
  bool isLoading = true;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    fetchMemes();
  }

  Future<void> fetchMemes({bool isLoadMore = false}) async {
    if (isLoadMore) {
      currentPage++;
    }
    try {
      final response = await http.get(Uri.parse()); // Fetch 20 memes at a time

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          memeUrls.addAll(
              List<String>.from(data['memes'].map((meme) => meme['url'])));
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load memes');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load memes: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
                  fetchMemes(isLoadMore: true);
                }
                return true;
              },
              child: RefreshIndicator(
                onRefresh: fetchMemes,
                child: ListView.builder(
                  itemCount: memeUrls.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(memeUrls[index]),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
