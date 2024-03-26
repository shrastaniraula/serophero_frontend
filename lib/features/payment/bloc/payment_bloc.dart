import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/payment/data/payment_model.dart';
import 'package:serophero/features/payment/data/payment_repo.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<PaymentEvent>((event, emit) => payment(event, emit));
  }

  void payment(PaymentEvent event, Emitter<PaymentState> emit) async {
    if (event is PaymentHistoryPageOpened) {
      emit(PaymentLoading());
      try {
        List<PaymentModel> paymentHistoryList =
            await PaymentRepo().getPaymentsList();
        emit(PaymentHistorySuccess(paymentHistoryList: paymentHistoryList));
      } catch (error) {
        if (error is DioException) {
          if (error.response != null) {
            final statusCode = error.response!.statusCode;
            if (statusCode == 522) {
              emit(PaymentFailure(
                  error: 'Connection timed out. Please try again later.'));
            } else if (statusCode == 401) {
              emit(TokenExpired());
            } else {
              emit(PaymentFailure(error: error.response?.data["message"][0]));
            }
          } else {
            print(error);
            emit(PaymentFailure(
                error: "Something went wrong, please try again later."));
          }
        } else {
          print(error);
          emit(PaymentFailure(
              error: "Something went wrong, please try again laterrrr."));
        }
      }
    } else if (event is PaymentMade) {
      emit(PaymentLoading());
      try {
        await PaymentRepo().makePayment(event.token, event.transactionId,
            event.amount, event.userId, event.remarks);
        emit(PaymentMadeSuccess());
      } catch (error) {
        if (error is DioException) {
          if (error.response != null) {
            final statusCode = error.response!.statusCode;
            if (statusCode == 522) {
              emit(PaymentFailure(
                  error: 'Connection timed out. Please try again later.'));
            } else if (statusCode == 401) {
              emit(TokenExpired());
            } else {
              emit(PaymentFailure(error: error.response?.data["message"][0]));
            }
          } else {
            print(error);
            emit(PaymentFailure(
                error: "Something went wrong, please try again later."));
          }
        } else {
          print(error);
          emit(PaymentFailure(
              error: "Something went wrong, please try again laterrrr."));
        }
      }
    }
  }
}
