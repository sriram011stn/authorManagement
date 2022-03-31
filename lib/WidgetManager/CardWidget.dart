
import 'package:flutter/material.dart';

import 'package:author_list_management/Screens/AuthorDetailScreen.dart';
import 'package:favorite_button/favorite_button.dart';

class CardWidget extends StatefulWidget {
  Map<dynamic,dynamic> responseObject = {};
  Function deleteCallback;

  CardWidget(this.responseObject,this.deleteCallback,{Key? key}) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {

  bool isFavourite = false;
  late bool favouriteValueResponse;

  @override
  void initState() {
   widget.responseObject["isFavourite"] = false;
    super.initState();
  }

  int yearsBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inDays / 365).round();
  }

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
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage("assets"+widget.responseObject["author"]["photoUrl"].toString())
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                              Expanded(child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(widget.responseObject["author"]["name"],
                                    style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                              ),
                              Expanded(child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("${yearsBetween(DateTime.parse(widget.responseObject["updated"]),DateTime.now()).toString()} years ago",
                                       style: const TextStyle(
                                       fontSize: 10,
                                       fontWeight: FontWeight.w500
                                     ),
                                  ),
                               )
                              ),
                            SizedBox(height: 5)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorDetailScreen(widget.responseObject)));
                },
              ),
              Container(
                margin: EdgeInsets.only(left:7,right: 10),
                child: FavoriteButton(
                  isFavorite: isFavourite,
                  iconSize: 35,
                  iconDisabledColor: Colors.grey[150],
                  valueChanged: (_isFavorite) {
                    widget.responseObject["isFavourite"] = _isFavorite;
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
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                insetPadding: EdgeInsets.zero,
                                shape:  const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                title: const Text("Delete this author?"),
                                content: Container(
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  width: MediaQuery.of(context).size.width * 0.55,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: MediaQuery.of(context).size.height,
                                        width: MediaQuery.of(context).size.width * 0.15,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage: AssetImage("assets"+widget.responseObject["author"]["photoUrl"].toString())
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Expanded(child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(widget.responseObject["author"]["name"],
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            )
                                            ),
                                            Expanded(child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("${yearsBetween(DateTime.parse(widget.responseObject["updated"]),DateTime.now()).toString()} years ago",
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            )
                                            ),
                                            SizedBox(height: 5)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context,'Dialog'),
                                    child: const Text('Cancel',
                                      style: TextStyle(
                                        color: Colors.black
                                      ),
                                    )
                                  ),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side: const BorderSide(width: 2.0,color: Colors.redAccent),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                        minimumSize: Size.zero,
                                        padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10)
                                    ),
                                    onPressed: () {
                                       widget.deleteCallback(widget.responseObject["id"].toString());
                                       Navigator.of(context, rootNavigator: true).pop('Dialog');
                                    },
                                    child: const Text("Delete",
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 14
                                        )
                                    ),
                                  )
                                ],
                              );
                            }
                        );
                      },
                      child: const Text("Delete",
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

