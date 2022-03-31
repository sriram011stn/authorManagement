import 'package:flutter/material.dart';

class InputSearchWidget extends StatefulWidget {
  Function searchCallback;
  InputSearchWidget(this.searchCallback,{Key? key}) : super(key: key);

  @override
  State<InputSearchWidget> createState() => _InputSearchWidgetState();
}

class _InputSearchWidgetState extends State<InputSearchWidget> {

  final searchValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
          top: 5.0 ,
          bottom: 0.0,
          left: 0.0,
          right: 0.0
      ),
      child:Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextField(
            controller: searchValue,
            onChanged: (searchValue) {
              widget.searchCallback(searchValue);
            },
            keyboardType: TextInputType.text,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13
            ),
            cursorColor: Colors.grey,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[150],
                contentPadding: const EdgeInsets.only(left: 30),
                suffixIcon: Icon(Icons.search,
                  size: 25,
                  color: Colors.black38,
                ),
                hintText:"Search...",
                hintStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.white),
                    borderRadius: BorderRadius.circular(50)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.white),
                    borderRadius: BorderRadius.circular(50)
                )
            ),
          ),
        ),
      ),
    );
    ;
  }
}
