import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:midnights/models/game/game.model.dart';
import 'package:midnights/models/game/music.model.dart';
import 'package:midnights/providers/http.provider.dart';

class FirebaseProvider {
  factory FirebaseProvider() {
    return _instance;
  }

  FirebaseProvider._internal();

  static final FirebaseProvider _instance = FirebaseProvider._internal();

  final FirebaseStorage _fStorage = FirebaseStorage.instance;

  String replaceWhitespaces(String s, String replace) => s.replaceAll(' ', replace);

  Future<List<MusicModel>> getRandomMusics(Album album) async {
    List<MusicModel> musics = [];

    String formatedAlbum = replaceWhitespaces(album.title.toLowerCase(), '_');

    final ListResult allRefs = await _fStorage.ref('albuns/$formatedAlbum/').list();

    for (Reference ref in allRefs.prefixes) {
      try {
        musics.add(await getInfoAndDownloadFile(ref));
      } catch (e) {
        debugPrint('deu ruim: \n $e');
      }
    }

    return musics;
  }

  Future<MusicModel> getInfoAndDownloadFile(Reference ref) async {
    Reference infoFile = ref.child('infos.json');

    return await HttpProvider().downloadMusicJson(await infoFile.getDownloadURL());
  }
}
