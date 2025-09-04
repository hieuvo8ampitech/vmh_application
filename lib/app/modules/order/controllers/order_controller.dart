import 'package:get/get.dart';
import 'package:vmh_application/app/data/models.dart';

class OrderController extends GetxController {
  final List<ShippingLines> shippingLines = const [
    ShippingLines(
      lineID: 'flat_rate',
      lineName: 'Flat Rate',
      createdBy: '10.00',
      createdDate: '2023-10-01',
      status: 'active',
    ),
  ];
}
