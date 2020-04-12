class DataPath {
  // ユーザー情報(オープンな情報)
  static String user({String uid}) => '/users/$uid';
  // ユーザー情報(プライベートな情報)
  static String userSecretContents({String uid}) => '/users/$uid/secret';
  // ユーザー主催のイベント情報
  static String userMyEvents({String uid}) => '/users/$uid/myEvnts';
  // ユーザー参加のイベント情報
  static String userCheckedEvents({String uid}) => '/users/$uid/checkedEvents';
  // フォロー一覧
  static String userFollowers({String uid}) => '/users/$uid/followers';
  // フォロワー一覧
  static String userFollows({String uid}) => '/users/$uid/follows';
  // イベント単一取得
  static String event({String eventId}) => '/events/$eventId';
}