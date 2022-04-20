import 'package:desktop/ui/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';





class Scan extends StatelessWidget {

  ValueNotifier<dynamic> result = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('SCAN MENU')),
        body: SafeArea(
          child: FutureBuilder<bool>(
            future: NfcManager.instance.isAvailable(),
            builder: (context, ss) =>
            ss.data != true
                ? const Center(child: Text('NfcManager.isAvailable():'))
                : Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.vertical,
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    child: SingleChildScrollView(
                      child: ValueListenableBuilder<dynamic>(
                        valueListenable: result,
                        builder: (context, value, _) =>
                            Text('${value ?? ""}'),

                      ),
                    ),
                  ),
                ),
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
                          child: Text('Clear'), onPressed: _tagClear),
                      ElevatedButton(
                          child: Text('Go to management'), onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(
                              )),
                        );
                      }
                      ),
                      ElevatedButton(
                          child: Text('Log Out'), onPressed:() => FirebaseAuth.instance.signOut()
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
      result.value = Isodep.identifier;
      NfcManager.instance.stopSession();
      print(Isodep.identifier.runtimeType);
      print(Isodep.identifier);

    });
  }

  void _tagClear() {
    result.value = "";
  }

}
