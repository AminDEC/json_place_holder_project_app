import 'package:flutter/material.dart';
import 'package:json_place_holder_project_app/data.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<Pic_List> data;

  @override
  void initState() {
    super.initState();
    data = getdata();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        title: Text("json test app"),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: FutureBuilder(
            future: data,
            builder: (context, AsyncSnapshot<Pic_List> snapshot) {
              List<Pic> all_pic;
              if (snapshot.hasData) {
                all_pic = snapshot.data.pic_list;
                return Container(
                  child: ListView.builder(
                      itemCount: all_pic.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: size.width,
                          height: size.height / 3,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: size.height / 20,
                                left: size.width / 25,
                                child: Container(
                                  width: size.width / 2.4,
                                  height: size.height / 3.6,
                                  //color: Colors.red,
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        width: size.width / 2.4,
                                        height: size.height / 4.6,
                                        decoration: BoxDecoration(
                                          //color: Colors.cyanAccent,
                                          borderRadius: BorderRadius.circular(
                                              size.width / 10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 5,
                                              spreadRadius: 5,
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                size.width / 10),
                                            child: Image.network(
                                              all_pic[index].url,
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        child: Container(
                                          width: size.width / 2.4,
                                          height: size.height / 20,
                                          //color: Colors.pink,
                                          child: Center(
                                              child: Text(
                                            "Id : ${all_pic[index].id}",
                                            style: TextStyle(
                                                fontSize: size.height / 30),
                                          )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: size.height / 20,
                                right: size.width / 25,
                                child: Container(
                                  width: size.width / 2.4,
                                  height: size.height / 4.6,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius:
                                        BorderRadius.circular(size.width / 10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 5,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child:Center(
                                    child: Text(
                                      "${all_pic[index].title}",
                                      style: TextStyle(
                                          fontSize: size.height / 45),
                                    ),
                                  )
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Future<Pic_List> getdata() async {
    var data;
    String url = 'https://jsonplaceholder.typicode.com/photos';
    Network network = Network(url);
    data = network.loadPost();
    return data;
  }
}
