import 'data_model.dart';

class AlbumModel {
  String albumName;
  List<DataModel> songs;

  AlbumModel({this.albumName, this.songs});
}

class FolderModel {
  String folder;
  List<DataModel> songs;

  FolderModel({this.folder, this.songs});
}

class ArtistModel {
  String artist;
  List<DataModel> songs;

  ArtistModel({this.artist, this.songs});
}