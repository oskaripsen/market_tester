import 'package:flutter/material.dart';
import '../../theme/dimens.dart';

/// Horizontal spacing widgets
class HSpace extends StatelessWidget {
  final double width;

  const HSpace.xs({Key? key}) : width = AppDimens.spacing4, super(key: key);
  const HSpace.small({Key? key}) : width = AppDimens.spacing8, super(key: key);
  const HSpace.medium({Key? key}) : width = AppDimens.spacing16, super(key: key);
  const HSpace.large({Key? key}) : width = AppDimens.spacing24, super(key: key);
  const HSpace.xl({Key? key}) : width = AppDimens.spacing32, super(key: key);
  const HSpace.xxl({Key? key}) : width = AppDimens.spacing48, super(key: key);
  const HSpace.custom(this.width, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}

/// Vertical spacing widgets
class VSpace extends StatelessWidget {
  final double height;

  const VSpace.xs({Key? key}) : height = AppDimens.spacing4, super(key: key);
  const VSpace.small({Key? key}) : height = AppDimens.spacing8, super(key: key);
  const VSpace.medium({Key? key}) : height = AppDimens.spacing16, super(key: key);
  const VSpace.large({Key? key}) : height = AppDimens.spacing24, super(key: key);
  const VSpace.xl({Key? key}) : height = AppDimens.spacing32, super(key: key);
  const VSpace.xxl({Key? key}) : height = AppDimens.spacing48, super(key: key);
  const VSpace.custom(this.height, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
} 