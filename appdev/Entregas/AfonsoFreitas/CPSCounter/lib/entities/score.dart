class Score{
  String username;
  int score = 0;
  double cps = 0;

  Score(this.username, this.score){
    cps = (score/10);
  }

  Score.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        score = json['score'],
        cps = json['score']/10;
  
  int compareTo(Score other) {
    return other.score.compareTo(score);
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'score': score,
      };

}