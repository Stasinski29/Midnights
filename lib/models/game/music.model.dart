class MusicModel {
  MusicModel(this.url, this.title, this.lyrics, this.isCorrect);

  MusicModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    lyrics = json['lyrics'];
    title = json['title'];
    isCorrect = false;
  }

  factory MusicModel.clone(MusicModel source) => MusicModel(
        source.url,
        source.title,
        source.lyrics,
        source.isCorrect,
      );

  late String url;
  late String lyrics;
  late String title;
  bool isCorrect = false;
}
