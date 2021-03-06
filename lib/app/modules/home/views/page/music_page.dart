import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ruminate/app/modules/home/controllers/home_controller.dart';
import 'package:ruminate/app/services/database_service.dart';
import 'package:ruminate/app/utils/database_model.dart';

class MusicPage extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  final SongDatabase database  = Get.find<SongDatabase>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ValueListenableBuilder<Box<Song>>(
          valueListenable: Hive.box<Song>("songs_database").listenable(),
          builder: (context, Box<Song> data, child) {
            if (data.values.isEmpty) {
              return Center(child: Text("No Songs"));
            }
            return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: data.values.length,
                itemBuilder: (context, index) {
                  final Song? song = data.getAt(index);
                  return Card(
                    elevation: 0,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text("$index"),
                      ),
                      title: Text(song!.title),
                      subtitle: Text(song.album),
                    ),
                  );
                });
          }),
    );
  }
}
