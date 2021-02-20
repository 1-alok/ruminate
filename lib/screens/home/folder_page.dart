import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:Ruminate/models/data_model.dart';
import 'package:Ruminate/models/model.dart';
import 'package:Ruminate/screens/widget/animated_container.dart';

class FolderMusicPage extends StatefulWidget {
  FolderMusicPage({Key key, @required this.dataBox}) : super(key: key);

  Box<DataModel> dataBox;

  @override
  _FolderMusicPageState createState() => _FolderMusicPageState();
}

class _FolderMusicPageState extends State<FolderMusicPage> {
  List<FolderModel> folder = [];
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.dataBox.listenable(),
      builder: (context, Box<DataModel> items, _) {
        if (items == null || items.length == 0) {
          return Container(
            child: Center(child: Text("No Data Found")),
          );
        }
        _sortFolder(items);
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: folder.length,
          itemBuilder: (_, index) {
            return Card(
              child: OpenContainerWidget(
                primaryTitle: folder[index].folder,
                songs: folder[index].songs,
              ),
            );
          },
        );
      },
    );
  }

  void _sortFolder(Box<DataModel> items) {
    List<DataModel> data = items.values.toList().cast<DataModel>();
    data.sort((a, b) => a.folder.compareTo(b.folder));
    for (DataModel entity in data) {
      if (folder.where((element) => element.folder == entity.folder).isEmpty) {
        folder.add(FolderModel(folder: entity.folder, songs: [entity]));
      } else {
        int i = folder.indexWhere((element) => element.folder == entity.folder);
        if (folder[i].songs.where((element) => element == entity).isEmpty) {
          folder[i].songs.add(entity);
        }
      }
    }
    folder.sort((a, b) => a.folder.compareTo(b.folder));
  }
}
