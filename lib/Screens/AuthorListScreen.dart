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

  late Future<dynamic> obtainedResponse;

  List<dynamic> responseObject = [];

  List<dynamic> displayObject = [];

  String searchInput = "";

  @override
  void initState() {
    // TODO: implement initState
    obtainedResponse = initiateAuthorDetailsData();
    super.initState();
  }

  initiateAuthorDetailsData() async{
    await authorListScreenData.authorDetails().then((value) => responseObject = value);
  }

  callback(inputValue){
    searchInput = inputValue;

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
                    InputSearchWidget(callback),
                    FutureBuilder(
                        future:obtainedResponse,
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
                            if(responseObject.isEmpty ){
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
                                      itemCount: responseObject.length,
                                      itemBuilder: (context,index) {
                                        return CardWidget(responseObject[index]);
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


