import 'package:flutter/material.dart';

import '../../api/api_service.dart';

class ApiPage extends StatefulWidget {
  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      // child: Text("Api"),
      child: Column(
        children: [
          FlatButton(
            child: Text("getBanner"), 
            onPressed: () => { 
              ApiService.getBanner().then((banners){ 
                debugPrint(banners.toString());
              }).catchError((e) {
                print(e);
              })
            }
          ),
          FlatButton(
            child: Text("getArticles"), 
            onPressed: () => { 
              ApiService.getArticles(0).then((aticles){ 
                debugPrint(aticles.toString());
              }).catchError((e) {
                print(e);
              })
            }
          ),
        ],
      ),
    );

    // return Column(
    //   children: <Widget>[
    //     FlatButton(
    //       child: Text("getBanner"), 
    //       onPressed: () => { 
    //         ApiService.getBanner().then((banners){ 
    //           debugPrint(banners.toString());
    //         }).catchError((e) {
    //           print(e);
    //         })
    //       }
    //     ),
    //     FlatButton(
    //       child: Text("getArticles"), 
    //       onPressed: () => { 
    //         ApiService.getArticles(0).then((aticles){ 
    //           debugPrint(aticles.toString());
    //         }).catchError((e) {
    //           print(e);
    //         })
    //       }
    //     ),
    //   ],
    // );
  }
}