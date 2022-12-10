import '../features/booking/blocs/booking_cubit.dart';

class PaymentArgument {
  final BookingCubit bookingCubit;

  PaymentArgument(this.bookingCubit);
}