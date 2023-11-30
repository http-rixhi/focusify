import 'package:flutter/material.dart';
import 'package:network_image_search/network_image_search.dart';
import 'package:wikipedia/wikipedia.dart';

import '../../widgets/Colors.dart';

class HomeScreenWiki extends StatefulWidget {
  const HomeScreenWiki({super.key});

  @override
  State<HomeScreenWiki> createState() => _HomeScreenWikiState();
}

class _HomeScreenWikiState extends State<HomeScreenWiki> {

  late TextEditingController _controller;

  bool _loading = false;
  List<WikipediaSearch> _data = [];

  @override
  void initState() {
    _controller = TextEditingController(text: "What is Flutter");
    getLandingData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            hintText: "What You Want to learn ?",
            hintStyle: TextStyle(color: tealLevel5),
            suffixIcon: IconButton(
              onPressed: getLandingData,
              icon: Icon(Icons.search),
              color: tealLevel3,
            ),
            focusColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: tealLevel3),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: _data.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) => InkWell(
              onTap: ()async{
                Wikipedia instance = Wikipedia();
                setState(() {
                  _loading = true;
                });
                var pageData = await instance.searchSummaryWithPageId(pageId: _data[index].pageid!);
                setState(() {
                  _loading = false;
                });
                if(pageData==null){
                  const snackBar = SnackBar(
                    content: Text('Data Not Found'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }else{
                  showGeneralDialog(
                    context: context,
                    pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
                      appBar: AppBar(
                        title: Text(_data[index].title!,style: const TextStyle(color: Colors.black)),
                        backgroundColor: Colors.white,
                        iconTheme: const IconThemeData(color: Colors.black),
                      ),
                      body: ListView(
                        padding: const EdgeInsets.all(10),
                        children: [
                          Text(pageData!.title!,style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          const SizedBox(height: 8),
                          Text(pageData.description!,style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),),
                          const SizedBox(height: 8),
                          Text(pageData.extract!)
                        ],
                      ),
                    ),
                  );
                }
              },
              child: Card(
                elevation: 5,
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(_data[index].title!,style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      const SizedBox(height: 10),
                      Unsplash(
                        width: '720',
                        height: '360',
                        category: 'programming',
                      ),
                      const SizedBox(height: 10),
                      Text(_data[index].snippet!),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Visibility(
            visible: _loading,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        ],
      ),
    );
  }
  Future getLandingData()async{
    try{
      setState((){
        _loading = true;
      });
      Wikipedia instance = Wikipedia();
      var result = await instance.searchQuery(searchQuery: _controller.text,limit: 20);
      setState((){
        _loading = false;
        _data = result!.query!.search!;
      });
    }catch(e){
      setState((){
        _loading = false;
      });
    }
  }
}
