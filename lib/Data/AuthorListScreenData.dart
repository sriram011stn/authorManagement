import 'dart:convert';
import 'package:http/http.dart';

class AuthorListScreenData {

    List<dynamic> outputResponse = [];

    Future<List<dynamic>> authorDetails() async{
        var url =Uri.parse("http://message-list.appspot.com/messages");
        final response = await get(url) ;
        var responseObject = json.decode(response.body);
        outputResponse = responseObject["messages"];
        return outputResponse;
    }
}