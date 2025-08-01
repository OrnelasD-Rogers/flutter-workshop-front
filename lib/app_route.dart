import 'package:flutter_workshop_front/models/device/device_filter.dart';
import 'package:flutter_workshop_front/pages/customers/all_customers/all_customers_page.dart';
import 'package:flutter_workshop_front/pages/customers/customer_detail/customer_detail_page.dart';
import 'package:flutter_workshop_front/pages/customers/customer_register/customer_register_page.dart';
import 'package:flutter_workshop_front/pages/devices/all_devices/all_devices_page.dart';
import 'package:flutter_workshop_front/pages/devices/device_details/device_details_page.dart';
import 'package:flutter_workshop_front/pages/devices/device_register/device_register_page.dart';
import 'package:flutter_workshop_front/pages/home/home_page.dart';
import 'package:flutter_workshop_front/pages/not_found_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: HomePage.route,
  routes: _routes,
  errorBuilder: (context, state) => const NotFoundPage(),
);

List<RouteBase> _routes = [
  GoRoute(
    path: HomePage.route,
    name: HomePage.route,
    builder: (context, state) {
      return const HomePage();
    },
  ),
  GoRoute(
    path: '/customer/all',
    name: AllCustomersPage.route,
    builder: (context, state) {
      return const AllCustomersPage();
    },
  ),
  GoRoute(
    path: '/customer/register',
    name: CustomerRegisterPage.route,
    builder: (context, state) {
      return const CustomerRegisterPage();
    },
  ),
  GoRoute(
    path: '/customer/:id',
    name: CustomerDetailPage.route,
    builder: (context, state) {
      var id = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
      return CustomerDetailPage(customerId: id);
    },
  ),
  GoRoute(
    path: '/device/register',
    name: DeviceRegisterPage.route,
    builder: (context, state) {
      var customerId =
          int.tryParse(state.uri.queryParameters['customerId'] ?? '');
      var customerName = state.uri.queryParameters['customerName'];

      return DeviceRegisterPage(
        customerId: customerId,
        customerName: customerName,
      );
    },
  ),
  GoRoute(
    path: '/device/all',
    name: AllDevicesPage.route,
    builder: (context, state) {
      var filter = state.extra as DeviceFilter?;
      return AllDevicesPage(filter: filter);
    },
  ),
  GoRoute(
    path: '/device/:id',
    name: DeviceDetailsPage.route,
    builder: (context, state) {
      var id = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
      return DeviceDetailsPage(deviceId: id);
    },
  ),
];
