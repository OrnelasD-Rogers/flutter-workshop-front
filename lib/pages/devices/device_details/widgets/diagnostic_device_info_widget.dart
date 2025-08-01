import 'package:flutter/material.dart';
import 'package:flutter_workshop_front/models/customer_device/device_customer.dart';
import 'package:flutter_workshop_front/pages/devices/device_details/controllers/device_customer_page_controller.dart';
import 'package:flutter_workshop_front/widgets/form_fields/custom_text_field.dart';
import 'package:provider/provider.dart';

class DiagnosticDeviceInfoWidget extends StatelessWidget {
  final bool isEditing;

  const DiagnosticDeviceInfoWidget({
    super.key,
    this.isEditing = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.read<DeviceCustomerPageController>();

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: isEditing ? Colors.blue.shade300 : const Color(0xFFE5E7EB)),
      ),
      child: Selector<DeviceCustomerPageController, DeviceCustomer>(
        selector: (context, controller) => controller.deviceCustomer,
        builder: (context, deviceCustomer, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.description_outlined, color: Color(0xFF4B5563)),
                SizedBox(width: 12),
                Text(
                  'Diagnóstico',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            CustomTextField(
              headerLabel: 'Problema',
              controller: TextEditingController(text: deviceCustomer.problem),
              readOnly: !isEditing,
              hintText: 'Descreva o problema relatado pelo cliente...',
              maxLines: 4,
              onSave: (value) {
                final newDeviceCustomer =
                    controller.deviceCustomer.copyWith(problem: value);
                controller.updateNewDeviceCustomer(newDeviceCustomer);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Problema é obrigatório';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              headerLabel: 'Orçamento',
              controller: TextEditingController(text: deviceCustomer.budget),
              readOnly: !isEditing,
              hintText: 'Descreva o orçamento para o conserto...',
              maxLines: 4,
              onSave: (value) {
                final newDeviceCustomer =
                    controller.deviceCustomer.copyWith(budget: value);
                controller.updateNewDeviceCustomer(newDeviceCustomer);
              },
            ),
          ],
        ),
      ),
    );
  }
}
