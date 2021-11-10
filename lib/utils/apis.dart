class APIs {
  static const serverURL = 'http://localhost:4000';
  static const loginAPI = '$serverURL/api/auth/login';
  static const registerAPI = '$serverURL/api/auth/register';
  static const getMeAPI = '$serverURL/api/auth/getme';

  static const getRoomsAPI = '$serverURL/api/rooms';
  static String getMessagesOfRoomAPI(String roomId) =>
      '$serverURL/api/room/$roomId/messages';
}