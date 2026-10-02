import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class InfiniteScrollPage extends StatefulWidget {
  const InfiniteScrollPage({super.key});
  @override
  InfiniteScrollPageState createState() => InfiniteScrollPageState();
}

class InfiniteScrollPageState extends State<InfiniteScrollPage> {
  List<dynamic> imageData = [];
  int currentPage = 1;
  ScrollController scrollController = ScrollController();
  bool isLoading = false;
 
  @override
  void initState() {
    super.initState();
    getData(1);

    scrollController.addListener(() {
      //print(scrollController.position.extentAfter); //sanity check
      if (scrollController.position.extentAfter < 700) {
        loadNextPage();
      }
    });
  }

  Future<void> loadNextPage() async {
    if (isLoading) return;
    int nextPage = currentPage + 1;
    bool success = await getData(nextPage);
    if (success) {
      currentPage = nextPage;
    }
  }

  Future<bool> getData(int page) async {
    if (isLoading) return false;

    isLoading = true;
    try {
      //calling the API with the added header of the API Key
      final response = await http.get(
        Uri.parse('https://api.jwstapi.com/all/type/jpg?page=$page&perPage=14'),
        headers: {'X-API-KEY': 'e5ecc611-1818-4806-859c-90fdb3ff7c53'},
      );
      if (response.statusCode == 200) {
        //print("Data Retrieved"); //sanity check
        final decoded = json.decode(response.body);
        final List<dynamic> data = decoded['body'];
        //print(data); //sanity check
        setState(() {
          //updates the page contents
          imageData.addAll(data);
        });
        return true;
      } else {
        if (!mounted) return false;
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: ${response.body}")));
        return false;
      }
    } finally {
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'JWST Images',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
      body: Scrollbar(
        //iniital testing
        //child: FloatingActionButton(onPressed: () => getData())
        child: GridView.builder(
          controller: scrollController,
          itemCount: imageData.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.all(5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Image Description'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text(imageData[index]['details']['description']),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Close'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: SizedBox.expand(
                  child: Image.network(
                    imageData[index]['location'],
                    webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: MediaQuery.sizeOf(context).height * 0.13,
        child: Text(
          "This work is based [in part] on observations made with the NASA/ESA/CSA James Webb Space Telescope. The data were obtained from the Mikulski Archive for Space Telescopes at the Space Telescope Science Institute, which is operated by the Association of Universities for Research in Astronomy, Inc., under NASA contract NAS5-03127 for JWST. These observations are associated with program #____.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}
