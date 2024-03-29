class AppUrls {
  static const baseUrl = "http://192.168.1.66:8000";
  // static const baseUrl = "http://192.168.137.230:8000";

  //endpoints
  static const login = '$baseUrl/user/login/';
  static const viewProfile = '$baseUrl/user/view_profile/';
  static const home = '$baseUrl/user/home';
  static const chatList = '$baseUrl/communication/message_list/';
  static const newsList = '$baseUrl/news/news/';
  static const newsAdd = '$baseUrl/news/news_add/';
  static const newsEvent = '$baseUrl/event/post_event/';
  static const eventList = '$baseUrl/event/fetch_event/';
  static const directories = '$baseUrl/business/directories/';
  static const directoriesRegister = '$baseUrl/business/register/';
  static const makePayment = '$baseUrl/payment/make_payment/';
  static const paymentHistory = '$baseUrl/payment/payment_history/';
  static const report = '$baseUrl/report/report/';
  static const updateProfile = '$baseUrl/user/update_profile/';
}
