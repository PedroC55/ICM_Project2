class ProgressModel{
  late String start_time;
  late String end_time;
  late String user;
  late int level;
  late String peddypaper;

  ProgressModel(String start_time, String end_time, String user, int level, String peddypaper){
    this.start_time = start_time;
    this.end_time = end_time;
    this.user = user;
    this.level = level;
    this.peddypaper = peddypaper;
  }

  toJson(){
    return{
      "start_time" : start_time,
      "end_time": end_time,
      "level": level,
      "user":user,
      "peddypaper":peddypaper,
    };
  }

}