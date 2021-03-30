import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:wisatapandeglang/constant/constant.dart';
import 'package:wisatapandeglang/page/detailwisata.dart';
class wisata extends StatefulWidget {
  @override
  _wisataState createState() => _wisataState();
}

class _wisataState extends State<wisata> {

  Map data;
  List wisataData = [];
  var loading=false;

  Map datadetail;
  dynamic userDataDetail;

  Future getData() async {
    setState(() {
      loading=true;
    });
    http.Response response = await http
        .get("https://$base_url/api/wisata");
    data = jsonDecode(response.body);
    print(data);
    setState(() {
      wisataData = data["data"];
      //untuk menampilkan di concole
      print(data);
      loading=false;
    });
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(

        decoration: InputDecoration(

            hintText: 'Search...'
        ),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            // wisataData= wisataData.where((note) {
            //   var noteTitle = note.toLowerCase();
            //   return noteTitle.contains(text);
            // }).toList();
          });
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Wisata",
            style: TextStyle(
                color: Colors.black87
            )
        ),
        elevation: 1,
        backgroundColor: Colors.white,

      ),
      body: Container(
        child: Container(
          child:  loading?Center(child: CircularProgressIndicator()):ListView.builder(
           itemCount:wisataData.length,
            // ignore: missing_return
            itemBuilder: (context, index) {
             return _listitem(index);
            },
            //itemCount: wisataData.length+1,

          ),


        ),
      ),
    );
  }
  _listitem(index){
    return Container(

      child: Card(

        elevation: 1,
        child: Container(


          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Image.network(
                 // listwisata[index].photo,
                  "https://$base_url/img/${wisataData[index]['gambar']}",


              ),
              Container(
                  margin: EdgeInsets.all(10),
                  child: Text('${wisataData[index]['nama_wisata']}',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(left: 10,right: 10),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on_rounded,
                      color: Colors.black38,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          "${wisataData[index]['alamat']}",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black38
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator
                      .push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext
                        context) =>
                            Detail(


                              description: wisataData[index]['deskripsi'],
                              location: wisataData[index]['alamat'],
                              place: wisataData[index]['nama_wisata'],
                              lat: wisataData[index]['latitude'],
                              long: wisataData[index]['longitude'],
                              photo: "https://$base_url/img/${wisataData[index]['gambar']}",
                              jam_buka: wisataData[index]['jam_buka'],
                              jam_tutup: wisataData[index]['jam_tutup'],
                              harga_tiket: wisataData[index]['harga_tiket'],
                            )),);
                },
                child: Container(
                    margin: EdgeInsets.only(right: 10,bottom: 10
                    ),
                    height: 50,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("LIHAT DETAIL",
                          style: TextStyle(
                              fontSize: 16,color: Colors.blueAccent
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
}


