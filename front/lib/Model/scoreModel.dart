class ScoreModel{
  int score;
  bool drunk;


  ScoreModel(score, drunk){
    this.score = score;
    this.drunk = drunk;
  }

  ScoreModel.fromJson(Map<String, dynamic> json)
      : score = json['score'],
        drunk = json['drunk'];

  Map<String, dynamic> toJson() => {
    'score': score,
    'drunk': drunk,
  };


}