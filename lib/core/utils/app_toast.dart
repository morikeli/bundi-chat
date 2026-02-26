import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../theme/color.dart';

class AppToast {
  static dynamic showSuccess(
    BuildContext context, {
    required String title,
    String? message,
    Duration? autoCloseDuration = const Duration(seconds: 5),
  }) {
    return toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      title: Text(title),
      description: message != null ? Text(message) : null,
      autoCloseDuration: autoCloseDuration,
      alignment: Alignment.bottomCenter,
      borderRadius: BorderRadius.circular(12),
      pauseOnHover: true,
      showProgressBar: true,
    );
  }

  static dynamic showError(
    BuildContext context, {
    required String title,
    String? message,
    Duration? autoCloseDuration = const Duration(seconds: 5),
  }) {
    return toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: kTextLightColor,
          fontSize: 14.0,
        ),
      ),
      description: message != null
          ? Text(
              message,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: kTextLightColor),
            )
          : null,
      autoCloseDuration: autoCloseDuration,
      alignment: Alignment.bottomCenter,
      borderRadius: BorderRadius.circular(12),
      pauseOnHover: true,
      showProgressBar: true,
    );
  }

  static dynamic showInfo(
    BuildContext context, {
    required String title,
    String? message,
    Duration? autoCloseDuration = const Duration(seconds: 5),
  }) {
    return toastification.show(
      context: context,
      type: ToastificationType.info,
      style: ToastificationStyle.minimal,
      title: Text(title),
      description: message != null ? Text(message) : null,
      autoCloseDuration: autoCloseDuration,
      alignment: Alignment.bottomCenter,
      borderRadius: BorderRadius.circular(12),
      pauseOnHover: true,
      showProgressBar: true,
    );
  }

  static dynamic showWarning(
    BuildContext context, {
    required String title,
    String? message,
    Duration? autoCloseDuration = const Duration(seconds: 5),
    bool? pauseOnHover = true,
    bool? showProgressBar = true,
  }) {
    return toastification.show(
      context: context,
      type: ToastificationType.warning,
      style: ToastificationStyle.flatColored,
      title: Text(title),
      description: message != null ? Text(message) : null,
      autoCloseDuration: autoCloseDuration,
      alignment: Alignment.bottomCenter,
      borderRadius: BorderRadius.circular(12),
      pauseOnHover: pauseOnHover,
      showProgressBar: showProgressBar,
    );
  }
}
