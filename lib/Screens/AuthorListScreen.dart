import 'package:flutter/material.dart';

import '../WidgetManager/InputSearchWidget.dart';
import '../WidgetManager/CardWidget.dart';
import '../Data/AuthorListScreenData.dart';

AuthorListScreenData authorListScreenData = AuthorListScreenData();

class AuthorListScreen extends StatefulWidget {
  const AuthorListScreen({Key? key}) : super(key: key);

  @override
  State<AuthorListScreen> createState() => _AuthorListScreenState();
}

class _AuthorListScreenState extends State<AuthorListScreen> {

  late Future<dynamic> responseObtained;

  List<dynamic> responseObject = [];
  List<dynamic> displayObject = [];

  bool isSearched = false;

  String searchInput = "";
  String id = "";

  @override
  void initState() {
    responseObtained = initiateAuthorDetailsData();
    super.initState();
  }

  initiateAuthorDetailsData() async{
    await authorListScreenData.authorDetails().then((value) => responseObject = value);
    displayObject = responseObject;
  }

  searchCallback(inputValue){
    searchInput = inputValue;
    if(searchInput == ""){
      setState(() {
        displayObject = responseObject;
        isSearched = false;
      });
    }
    else{
      setState(() {
        displayObject = responseObject.where((e) => e["author"]["name"].toString().toLowerCase().contains(searchInput.toLowerCase()) == true).toList();
      });
      isSearched = true;
    }
  }
  
  deleteCallback(id) {
    if(id != ""){
      setState(() {
        responseObject = responseObject.where((element) => element["id"].toString() != id).toList();
        displayObject = responseObject;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MaterialApp(
        debugShowCheckedModeBanner:false,
        home: Scaffold(
            body: SafeArea(
                child: Column(
                  children: [
                    InputSearchWidget(searchCallback),
                    isSearched ? Container(
                      margin : EdgeInsets.only(bottom: 10.0),
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Search Results",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold
                                      )
                                  )
                              ),
                            ),
                            Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("${displayObject.length} found",
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                        fontWeight: FontWeight.bold
                                    ),
                                  )
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                        :
                    Container() ,
                    FutureBuilder(
                        future:responseObtained,
                        builder: (context,snapshot)
                        {
                          if(snapshot.connectionState == ConnectionState.none){
                            return Text("None");
                          }
                          else if(snapshot.connectionState == ConnectionState.waiting){
                            return Expanded(
                                child:  Container(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.redAccent,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                )
                            );
                          }
                          else if(snapshot.connectionState == ConnectionState.done){
                            if(displayObject.isEmpty ){
                              return  Expanded(
                                  child:  Container(
                                    child: Center(
                                      child: Text("No Results Found"),
                                    ),
                                  )
                              );
                            }
                            else{
                              return  Expanded(
                                  child: ListView.builder(
                                      itemCount: displayObject.length,
                                      itemBuilder: (context,index) {
                                        return CardWidget(displayObject[index],deleteCallback);
                                      }
                                  )
                              );
                            }
                          }
                          throw{
                            Text("Something Went Wrong")
                          };
                        }
                    ),
                  ],
                )
            )
        ),
      ),
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
        FocusScope.of(context).unfocus();
      },
      onVerticalDragCancel: () {
        FocusManager.instance.primaryFocus!.unfocus();
        FocusScope.of(context).unfocus();
      },
    );
  }
}


