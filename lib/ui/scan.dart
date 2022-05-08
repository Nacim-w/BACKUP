import 'package:desktop/add/chauffeur.dart';
import 'package:desktop/ui/navbar.dart';
import 'package:desktop/ui/settings.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';
import 'package:http/http.dart' as http;



class Scan extends StatelessWidget {

  ValueNotifier<dynamic> result = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          centerTitle: true,
          title:Text('SCAN MENU'),
          actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Show Snackbar',
            onPressed: () {
              test();
              Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Chauffeur(
                              )),
                        );
            },
          ),
        ],
        ),
          

      
        body: SafeArea(
           
          child: FutureBuilder<bool>(
            future: NfcManager.instance.isAvailable(),
            builder: (context, ss) =>
            ss.data != true
                ? const Center(child: Text('Turn on NFC'))
                : Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.vertical,
              children: [
                Flexible(
                  flex: 3,
                  child: GridView.count(
                    padding: EdgeInsets.all(4),
                    crossAxisCount: 2,
                    childAspectRatio: 4,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    children: [
                      ElevatedButton(
                          child: Text('Tag Read'), onPressed: _tagRead),                         
                      ElevatedButton(
                          child: Text('Go to management'), onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Chauffeur(
                              )),
                        );
                      }
                      ),                                     
                    ],
                  ),
                ),
              ], //children
            ),
          ),
        ),
      ),
    );
  }

  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      final Isodep = IsoDep.from(tag);
      if (Isodep == null) {
        print('Tag is not compatible with Isodep.');
        return;
      }
      result.value = Isodep.identifier.toString();
      NfcManager.instance.stopSession();
    print(Isodep.identifier.toString().runtimeType);
    try{
          
	  final response = await http.post
    (Uri.parse("http://192.168.1.7/faith/insertdata.php"),
     body: {
	    "tagid": result.value,
	     });
       print(response.body);
	}
  catch (e) {

       print("exception: ${e.toString()}");
  }

    });
  }
}
