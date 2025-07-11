import 'package:flutter/material.dart';
import 'package:flutter_workshop_front/core/route/ws_navigator.dart';
import 'package:flutter_workshop_front/models/customer_device/device_customer.dart';
import 'package:flutter_workshop_front/pages/device_customer/controllers/inherited_device_customer_controller.dart';
import 'package:flutter_workshop_front/utils/phone_utils.dart';
import 'package:flutter_workshop_front/widgets/customer_device/device_status_chip.dart';
import 'package:flutter_workshop_front/widgets/customer_device/urgency_revision_chip.dart';

class CustomerDeviceInfoHeaderWidget extends StatefulWidget {
  final DeviceCustomer deviceCustomer;
  const CustomerDeviceInfoHeaderWidget({
    super.key,
    required this.deviceCustomer,
  });

  @override
  State<CustomerDeviceInfoHeaderWidget> createState() =>
      _CustomerDeviceInfoHeaderWidgetState();
}

class _CustomerDeviceInfoHeaderWidgetState
    extends State<CustomerDeviceInfoHeaderWidget> {
  bool isHoveringCustomer = false;

  String get mainPhone =>
      PhoneUtils.formatPhone(widget.deviceCustomer.customerPhones
          .firstWhere((phone) => phone.isMain)
          .number);

  @override
  Widget build(BuildContext context) {
    final controller = InheritedDeviceCustomerController.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ID do aparelho # ${widget.deviceCustomer.deviceId}',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 8,
              children: [
                if (widget.deviceCustomer.hasUrgency ||
                    widget.deviceCustomer.isRevision) ...[
                  UrgencyRevisionChip(
                      hasUrgency: widget.deviceCustomer.hasUrgency,
                      isRevision: widget.deviceCustomer.isRevision),
                  const SizedBox(height: 4),
                ],
                ValueListenableBuilder(
                  valueListenable: controller.customerDeviceState,
                  builder: (context, _, __) {
                    return DeviceStatusChip(
                        status: widget.deviceCustomer.deviceStatus);
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          spacing: 32,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              onHover: (event) {
                setState(() {
                  isHoveringCustomer = true;
                });
              },
              onExit: (event) {
                setState(() {
                  isHoveringCustomer = false;
                });
              },
              child: GestureDetector(
                onTap: () {
                  WsNavigator.pushCustomerDetail(
                    context,
                    widget.deviceCustomer.customerId,
                  );
                },
                child: Row(
                  spacing: 8,
                  children: [
                    Icon(
                      Icons.person_outline,
                      color: isHoveringCustomer
                          ? Colors.lightBlueAccent
                          : Colors.black,
                    ),
                    Text(
                      'Cliente: ${widget.deviceCustomer.customerName}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isHoveringCustomer
                                ? Colors.lightBlueAccent
                                : Colors.black,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              spacing: 8,
              children: [
                const Icon(Icons.phone_outlined),
                Text('Telefone principal: $mainPhone'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
