import 'package:get/get.dart';
import 'package:vmh_application/app/data/models.dart';

class OrderController extends GetxController {
  final List<ShippingLines> shippingLines =  [
    ShippingLines(
      shippingLinesID: '',
      shippingLinesName: 'Miền Tây 2',
      createdBy: 'Võ Lê Khang',
      createdAt: DateTime.now(),
      status: 'active',
    ),
  ];
}
