import 'package:flutter/material.dart';

class InputSearchWidget extends StatefulWidget {
  Function callback;
  InputSearchWidget(this.callback,{Key? key}) : super(key: key);

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
          bottom: 5.0,
          left: 0.0,
          right: 0.0
      ),
      child:Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextField(
            controller: searchValue,
            onChanged: (searchValue) {
              widget.callback(searchValue);
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
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  iconSize: 25,
                  color: Colors.black38,
                  //color: widgetManagerEngine.getColorForWidget(WidgetManagerColors.WIDGET_MANAGER_CONSTANTS_TEAL),
                  onPressed: () {
                    // if( searchValue.text != ""){
                    //   widget.callback("");
                    //   setState(() {
                    //     searchValue.clear();
                    //   });
                    // }
                    // else{
                    //   setState(() {
                    //     searchValue.clear();
                    //   });
                    // }
                  },
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
