
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'route_names.dart';
import 'router_config.dart';

class AppRouter {
  static Future<T?> go<T>(
    context,
    RouterNames routerName, {
    Map<String, String> pathParameters = const {},
  }) {
    return GoRouter.of(context).pushNamed<T>(
      routerName.name,
      pathParameters: pathParameters,
    );
  }

  static pop(context) => GoRouter.of(context).pop();

  static Provider<GoRouter> config = routerConfig;
}
