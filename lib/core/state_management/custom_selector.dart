import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewModelSelector<T, S> extends StatelessWidget {
  const ViewModelSelector({
    super.key,
    required this.selector,
    required this.builder,
    this.shouldRebuild,
    this.child,
  });

  final S Function(BuildContext context, T model) selector;
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final bool Function(S, S)? shouldRebuild;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Selector<T, S>(
      selector: selector,
      builder: (context, value, child) {
        return builder(context, context.read<T>(), child);
      },
      shouldRebuild: shouldRebuild,
      child: child,
    );
  }
}
