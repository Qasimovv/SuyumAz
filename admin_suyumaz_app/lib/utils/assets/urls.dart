class Urls {
  static const _basicUrl = 'http://18.158.4.101:8089/suyumaz';

  static const LOGIN_URL = '$_basicUrl/api/auth/login';
  static const REGISTER_URL = '$_basicUrl/api/register';
  static const ADD_TASK_URL = '$_basicUrl/api/task/new';
  static const USER_LIST_URL = '$_basicUrl/api/user/list';
  static const CLIENT_LIST_URL = '$_basicUrl/api/client/list';
  static const ADD_CLIENT = '$_basicUrl/api/client/new';
  static const REJECT_TASK = '$_basicUrl/api/task/reject';
  static const ACCEPT_TASK = '$_basicUrl/api/task/accept';
  static const COMPLETE_TASK = '$_basicUrl/api/task/complete';
  static const TERMINATE_TASK = '$_basicUrl/api/task/terminate';
  static const CHANGE_USER = '$_basicUrl/api/task/reassign';
  static const TASK_LIST = '$_basicUrl/api/task/list';
}
