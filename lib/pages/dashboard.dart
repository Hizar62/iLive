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
  String? errorMessage; // To hold error messages

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
          'https://meme-api.com/gimme/10')); // Ensure this API endpoint is correct

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Check if 'memes' key exists and is a list
        if (data != null &&
            data.containsKey('memes') &&
            data['memes'] is List) {
          setState(() {
            memeUrls.addAll(
                List<String>.from(data['memes'].map((meme) => meme['url'])));
            isLoading = false;
            errorMessage = null; // Clear any previous errors
          });
        } else {
          throw Exception('Invalid response format: ${response.body}');
        }
      } else {
        throw Exception(
            'Failed to load memes with status code ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load memes: $e'; // Set error message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          isLoading
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
                                              Icon(Icons.download),
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                  foregroundColor: Colors.white,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 8.0),
                                                ),
                                                onPressed: () {
                                                  // Add your Save functionality here
                                                },
                                                child: const Text('Save'),
                                              ),
                                              const SizedBox(width: 70),
                                              Icon(Icons
                                                  .switch_access_shortcut_add_outlined),
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                  foregroundColor: Colors.white,
                                                  padding: const EdgeInsets
                                                      .symmetric(
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
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
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
          // Error message banner
          if (errorMessage != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.red,
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        errorMessage!,
                        style: TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          errorMessage = null; // Dismiss the error message
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
