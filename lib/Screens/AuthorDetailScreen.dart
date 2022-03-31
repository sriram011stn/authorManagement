import 'package:flutter/material.dart';

import 'package:favorite_button/favorite_button.dart';

class AuthorDetailScreen extends StatefulWidget {
  Map<dynamic,dynamic> responseObject;
  AuthorDetailScreen(this.responseObject,{Key? key}) : super(key: key);

  @override
  State<AuthorDetailScreen> createState() => _AuthorDetailScreenState();
}

class _AuthorDetailScreenState extends State<AuthorDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.redAccent, //change your color here
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 35),
            child: FavoriteButton(
              isFavorite: widget.responseObject["isFavourite"],
              iconSize: 30,
              iconDisabledColor: Colors.grey[150],
              valueChanged: (_isFavorite) {

              },
            ),
          )

        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Details",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children : [
                Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("assets"+widget.responseObject["author"]["photoUrl"].toString()),
                      radius: 100,
                    ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 35),
                  child: Text(
                    "${widget.responseObject["author"]["name"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                        child: Text("${widget.responseObject["content"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                    )
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}
