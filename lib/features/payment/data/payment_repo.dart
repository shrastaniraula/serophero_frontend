import 'package:dio/dio.dart';
import 'package:serophero/features/payment/data/payment_model.dart';
import 'package:serophero/utils/shared_preferences.dart';
import 'package:serophero/constants/app_urls.dart';

class PaymentRepo {
  final Dio dio = Dio();

  Future<void> makePayment(String paymentToken, String transactionId,
      int amount, int userId, String remarks) async {
    final token = await SharedUtils.getToken();

    await dio.post(
      AppUrls.makePayment,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      data: {
        'token': paymentToken,
        'transaction_id': transactionId,
        'amount': amount,
        'user_id': userId,
        'remarks': remarks
      },
    );
  }

  Future<List<PaymentModel>> getPaymentsList() async {
    final token = await SharedUtils.getToken();
    final response = await dio.get(
      AppUrls.paymentHistory,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      print(response.data);

      List<PaymentModel> paymentHistory = [];
      for (int i = 0; i < data.length; i++) {
        print(data[i]);
        PaymentModel item =
            PaymentModel.fromMap(data[i] as Map<String, dynamic>);
        paymentHistory.add(item);
      }
      print(paymentHistory);

      return paymentHistory;
    } else {
      print("error");
      throw Exception('Failed to load chat list');
    }
  }
}
