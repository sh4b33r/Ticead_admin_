
// ========================================================================
// MovieModel DataType  to store API things and Handle ther errors from APi
// ------------------------------------------------------------------------

class MovieModel {
  String? title;
  String? backdroppath;
  String? originaltitle;
  String? overview;
  String? posterpath;
  String voterating;
  String language;

  MovieModel(
      {required this.title,
      required this.language,
      required this.backdroppath,
      required this.originaltitle,
      required this.overview,
      required this.voterating,
      required this.posterpath});

  static MovieModel fromJson(Map<String, dynamic> frmmap) {
    String data = frmmap["name"] ?? frmmap["title"];

    return MovieModel(
        title: data,
        language: frmmap["original_language"],
        voterating: frmmap["vote_average"] == null? "0"
            : frmmap["vote_average"].toString(),
        posterpath: frmmap["poster_path"],
        overview: frmmap["overview"],
        originaltitle: frmmap["original_title"],
        backdroppath: frmmap["backdrop_path"]);
  }
}
