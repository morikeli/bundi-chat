import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../theme/color.dart';

class AppLoadingIndicators {
  static Widget loadingIndicatorExtraSmall() {
    return LoadingAnimationWidget.threeRotatingDots(
      color: kIconLightColor,
      size: 12.0,
    );
  }

  static Widget loadingIndicatorSmall() {
    return LoadingAnimationWidget.threeRotatingDots(
      color: kIconLightColor,
      size: 16.0,
    );
  }

  static Widget loadingIndicatorMedium() {
    return LoadingAnimationWidget.threeRotatingDots(
      color: kIconLightColor,
      size: 24.0,
    );
  }

  static Widget loadingIndicatorLarge() {
    return LoadingAnimationWidget.threeRotatingDots(
      color: kIconLightColor,
      size: 64.0,
    );
  }
}
