import 'package:flutter/material.dart';

import 'package:author_list_management/Screens/AuthorDetailScreen.dart';
import 'package:favorite_button/favorite_button.dart';

class CardWidget extends StatefulWidget {
  Map<dynamic,dynamic> responseObject = {};
  CardWidget(this.responseObject,{Key? key}) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.045),
      height: MediaQuery.of(context).size.height *0.1,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
        ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 0.55,
                    child: ListTile(
                      leading: Container(
                         padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.015),
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            //backgroundImage: Image.asset('${widget.responseObject["author"]["photoUrl"]}'),
                          ),
                      ),
                      subtitle: Container(
                          child: Column(
                            children : [
                              Text(widget.responseObject["author"]["name"],
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(widget.responseObject["updated"],
                                style: TextStyle(
                                  fontSize: 7
                                ),
                              )
                            ],
                          ),
                      ),
                      //subtitle: Text(widget.responseObject["updated"]),
                    ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthorDetailScreen()));
                },
              ),
              Container(
                margin: EdgeInsets.only(left:7,right: 10),
                child: FavoriteButton(
                  isFavorite: false,
                  iconSize: 35,
                  iconDisabledColor: Colors.grey[150],
                  valueChanged: (_isFavorite) {
                    print('Is Favorite : $_isFavorite');
                  },
                ),
              ),
              Container(
                width: 80,
              padding: EdgeInsets.only(left: 10),
              child:Center(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 2.0,color: Colors.redAccent),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        minimumSize: Size.zero,
                        padding: EdgeInsets.symmetric(vertical: 7,horizontal: 10)
                      ),
                      onPressed: () {  },
                      child: Text("Delete",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 14
                        )
                      ),
                    )
                )
              )
            ],
          ),
      )
    );
  }
}
