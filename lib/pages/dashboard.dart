import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<String> memeUrls = [];
  bool isLoading = true;
  bool _isDownloading = false; // To track the download state
  int currentPage = 1;
  String? errorMessage;

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
      final response =
          await http.get(Uri.parse('https://meme-api.com/gimme/20'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data != null &&
            data.containsKey('memes') &&
            data['memes'] is List) {
          setState(() {
            memeUrls.addAll(
                List<String>.from(data['memes'].map((meme) => meme['url'])));
            isLoading = false;
            errorMessage = null;
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
        errorMessage = 'Failed to load memes: $e';
      });
    }
  }

  Future<void> _downloadAndSaveImageToGallery(String imageUrl) async {
    setState(() {
      _isDownloading = true; // Disable buttons while downloading
    });

    try {
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Storage permission not granted.'),
        ));
        return;
      }

      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        // ignore: unused_local_variable
        Directory? externalDir = await getExternalStorageDirectory();
        String dirPath = '/storage/emulated/0/Pictures';

        final fileName = p.basename(imageUrl);
        final filePath = p.join(dirPath, fileName);

        final File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Image saved to gallery: $filePath'),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
          duration: Duration(seconds: 2),
        ));

        print('Image saved to gallery: $filePath');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
          content: Text('Failed to download image.'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        content: Text('Error saving image: $e'),
      ));
    } finally {
      setState(() {
        _isDownloading = false; // Re-enable buttons after download
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          isLoading
              ? const Center(child: CircularProgressIndicator())
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
                                              TextButton.icon(
                                                style: TextButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                  foregroundColor: Colors.white,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 8.0),
                                                ),
                                                onPressed: _isDownloading
                                                    ? null
                                                    : () {
                                                        _downloadAndSaveImageToGallery(
                                                            memeUrls[index]);
                                                      },
                                                icon:
                                                    const Icon(Icons.download),
                                                label: const Text('Save'),
                                              ),
                                              const SizedBox(width: 70),
                                              TextButton.icon(
                                                style: TextButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                  foregroundColor: Colors.white,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 8.0),
                                                ),
                                                onPressed: _isDownloading
                                                    ? null
                                                    : () {},
                                                icon: const Icon(Icons.share),
                                                label: const Text('Share'),
                                              ),
                                            ],
                                          ),
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
          if (errorMessage != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.red,
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        errorMessage!,
                        style: const TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          errorMessage = null;
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
