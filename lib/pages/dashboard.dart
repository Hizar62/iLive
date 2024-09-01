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
      final response = await http.get(Uri.parse(
          'https://meme-api.com/gimme/30')); // Fetch 20 memes at a time

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
    const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.red));

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
                            Image.network(
                              memeUrls[index],
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return Column(
                                    children: [
                                      child, // Display the image
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              foregroundColor: Colors.white,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 8.0),
                                            ),
                                            onPressed: () {
                                              // Add your Save functionality here
                                            },
                                            child: const Text('Save'),
                                          ),
                                          const SizedBox(width: 70),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              foregroundColor: Colors.white,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 8.0),
                                            ),
                                            onPressed: () {
                                              // Add your Share functionality here
                                            },
                                            child: const Text('Share'),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                }
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey,
                                  height: 200,
                                  width: double.infinity,
                                  child: const Center(
                                    child: Icon(
                                      Icons.error,
                                      color: Colors.red,
                                      size: 50,
                                    ),
                                  ),
                                );
                              },
                            ),
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
