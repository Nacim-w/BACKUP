import 'dart:io';
import 'package:desktop/helpers/sql_helper.dart';
import 'package:desktop/model/model_data.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'data_page.dart';

// to change between sort option
enum OrderOptions { orderaz, orderza }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // to call Helpers for insert/query/update/delete queries
  SqlHelper helper = SqlHelper();

  // to call class data
  List<Data> data = List();

  @override
  void initState() {
    super.initState();

    // to Loading the data when the app starts
    _getAllData();
  }

  @override
  Widget build(BuildContext context) {
    // UI of home page
    return Scaffold(
        appBar: AppBar(
          title: Text("CURD SQL Flutter"),
          backgroundColor: Color(0xFF4285F4),
          centerTitle: true,

          // UI of Popup Menu Button
          actions: <Widget>[
            PopupMenuButton<OrderOptions>(
              itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
                const PopupMenuItem<OrderOptions>(
                  child: Text("Sort to A-Z"),
                  value: OrderOptions.orderaz,
                ),
                const PopupMenuItem<OrderOptions>(
                  child: Text("Sort to Z-A"),
                  value: OrderOptions.orderza,
                ),
              ],

              // call _sortList function to select menu///
              onSelected: _sortList,
            )
          ],
        ),
        backgroundColor: Color(0xFFECEFF1),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // call _showDataPage function to add data and update ///
            _showDataPage();
          },

          // ui of icon floatingActionButton
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
        body: Stack(
          children: <Widget>[
            ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  // to call _dataCard
                  return _dataCard(context, index);
                }),
          ],
        ));
  }

  // ui of data card
  Widget _dataCard(BuildContext context, int index) {
    return GestureDetector(
        child: Card(
          color: Color(0xFF2C384A),
          child: Padding(
            padding: EdgeInsets.all(16),

            // ui of listTile for matricule and tagId and image
            child: ListTile(
              title: Text(
                data[index].matricule ?? "",
                style: TextStyle(
                    color: Colors.tealAccent,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              ),

              // ui of ReadMoreText
              subtitle: ReadMoreText(
                data[index].tagId ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                trimLines: 2,
                colorClickableText: Colors.blue,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'more',
                trimExpandedText: 'less',
                moreStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              leading: Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    // If you do not pick a picture, the default picture will be displayed
                      image: data[index].img != null
                          ? FileImage(File(data[index].img))
                          : AssetImage("images/user-default.png"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ),

        // call _showOptions function to show Modal of BottomSheet
        onTap: () {
          _showOptions(context, index);
        });
  }

  // function for BottomSheet to click edit or delete data
  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FlatButton(
                          child: Icon(
                            Icons.edit,
                            size: 40.0,
                            color: Colors.blue,
                          ),

                          // code to navigation to edit data page
                          onPressed: () {
                            Navigator.pop(context);
                            _showDataPage(data: data[index]);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FlatButton(
                          child: Icon(
                            Icons.delete,
                            size: 40.0,
                            color: Colors.blue,
                          ),

                          // code to delete data
                          onPressed: () {
                            helper.deleteData(data[index].id);
                            setState(() {
                              data.removeAt(index);
                              Navigator.pop(context);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }

  // This function will be active when the floating button is clicked
  // It will also be active when you want to update an item
  void _showDataPage({Data data}) async {
    final recData = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => DataPage(data: data)));

    if (recData != null) {
      if (data != null) {
        await helper.updateData(recData);
      } else {
        await helper.insertData(recData);
      }
      _getAllData();
    }
  }

  // This function is used to get all data from the database
  void _getAllData() {
    helper.getData().then((list) {
      setState(() {
        data = list;
      });
    });
  }

  // This function is used to Order data by matricule ///
  void _sortList(OrderOptions result) {
    switch (result) {

    // to order from A to Z //
      case OrderOptions.orderaz:
        data.sort((a, b) {
          return a.matricule.toLowerCase().compareTo(b.matricule.toLowerCase());
        });
        break;

    // to order from Z to A //
      case OrderOptions.orderza:
        data.sort((a, b) {
          return b.matricule.toLowerCase().compareTo(a.matricule.toLowerCase());
        });
        break;
    }
    setState(() {});
  }
}
