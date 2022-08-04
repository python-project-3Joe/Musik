// user 테이블 클래스

class _User{
  String u_id;
  String u_pw;
  String u_email;
  String u_nickname;
  DateTime u_joindate;
  DateTime u_quitdate;
  int u_quit;

// constructor
  _User(
    {
      required this.u_id,
      required this.u_pw,
      required this.u_email,
      required this.u_nickname,
      required this.u_joindate,
      required this.u_quitdate,
      required this.u_quit,
    }
  );
}