import 'package:flutter/material.dart';

import 'package:favorite_button/favorite_button.dart';

class AuthorDetailScreen extends StatefulWidget {
  const AuthorDetailScreen({Key? key}) : super(key: key);

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
              isFavorite: false,
              iconSize: 30,
              iconDisabledColor: Colors.grey[150],
              valueChanged: (_isFavorite) {
                print('Is Favorite : $_isFavorite');
              },
            ),
          )

        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Details",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children : [
              Container(
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 100,
                  ),
              ),
              Container(
                child: Text(
                  "Author Name"
                ),
              ),
              Expanded(
                  child: Container(
                      child: Text("Her pretty looks have been mine enemies, And therefore have I invoked thee for her seal, and meant thereby Thou shouldst print more, not let that pine to aggravate thy store Buy terms divine in selling hours of dross Within be fed, without be rich no more So shalt thou feed on Death, that feeds on men, And Death once dead, there's no more to shame nor me nor you."
                      ),
                  )
              )
            ]
          ),
        ),
      ),
    );
  }
}
