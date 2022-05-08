/* import 'package:desktop/helpers/sql_helper.dart';

class Data {
  // to define the variables
  int id;
  String matricule;
  String tagId;
  String img;
  Data();

  Data.fromMap(Map map) {
    id = map[idColumn];
    matricule = map[matriculeColumn];
    tagId = map[tagIdColumn];
    img = map[imgColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      matriculeColumn: matricule,
      tagIdColumn: tagId,
      imgColumn: img,
    };
    if (id != null) {
      map[idColumn] = id;
    }

    return map;
  }

  @override
  String toString() {
    return "Data(id: $id, matricule: $matricule,"
        " img: $img,description:$tagId,)";
  }
}
 */