import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class PostTest
{
  String nama;
  String job;

  PostTest({this.nama, this.job});

  factory PostTest.createPostTest(Map<String, dynamic> o){
    return PostTest(
      nama: o['name'],
      job: o['job']
    );
  }

  factory PostTest.createPostTestList(Map<String, dynamic> o){
    return PostTest(
        nama: o['first_name']+" "+o['last_name'],
        job: o['email']
    );
  }



  static Future<List<PostTest>> connectApiList(String page) async {
    String url = "https://reqres.in/api/users?page="+page;

    var getResult = await http.get(url);
    var resultObject = json.decode(getResult.body);

   List<dynamic> listData = (resultObject as Map<String, dynamic>)['data'];
   List<PostTest> data = [];
   for(int i=0; i<listData.length; i++)
     data.add(PostTest.createPostTestList(listData[i]));

   return data;

  }


  static Future<PostTest> connectApiPost(String nama,String job) async {
    String url = "https://reqres.in/api/users";

    var getResult = await http.post(url, body: {
      "name" : nama,
      "job" : job
    });

    var resultObject = json.decode(getResult.body);

    return PostTest.createPostTest(resultObject);
  }

  static Future<PostTest> connectApi(String nama,String job) async {
    String url = "https://reqres.in/api/users/2";

    var getResult = await http.get(url);

    var resultObject = json.decode(getResult.body);

    print(resultObject);

    var resulDecode = (resultObject as Map<String, dynamic>)['data'];

    return PostTest.createPostTest(resulDecode);
  }
}