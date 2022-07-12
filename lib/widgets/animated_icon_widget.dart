import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';
import 'package:mhicha/providers/profile_provider.dart';
import 'package:mhicha/utilities/snackbars.dart';

class AnimateIconsWidget extends StatefulWidget {
  const AnimateIconsWidget({
    Key? key,
    required this.startIcon,
    required this.endIcon,
    required this.controller,
    required this.onStartIconPress,
    required this.onEndIconPress,
    this.size = 24.0,
    this.duration = const Duration(milliseconds: 1000),
    this.curve = Curves.easeInOut,
    this.clockwise = true,
    this.startIconColor,
    this.endIconColor,
    this.amplitude = 180.0,
    this.splashRadius,
    this.splashColor = Colors.transparent,
    this.startTooltip,
    this.endTooltip,
  }) : super(key: key);

  final IconData startIcon;

  final IconData endIcon;

  final AnimateIconController controller;

  final bool Function() onStartIconPress;

  final bool Function() onEndIconPress;

  final double size;

  final Duration duration;

  final Curve curve;

  final bool clockwise;

  final Color? startIconColor;

  final Color? endIconColor;

  final double amplitude;

  final double? splashRadius;

  final Color splashColor;

  final String? startTooltip;

  final String? endTooltip;

  @override
  _AnimateIconsWidgetState createState() => _AnimateIconsWidgetState();
}

class _AnimateIconsWidgetState extends State<AnimateIconsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.clockwise ? widget.curve : widget.curve.flipped,
      ),
    );
    _initControllers();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _initControllers() {
    widget.controller.animateToEnd = () {
      if (mounted) {
        _controller.forward();
        return true;
      } else {
        return false;
      }
    };
    widget.controller.animateToStart = () {
      if (mounted) {
        _controller.reverse();
        return true;
      } else {
        return false;
      }
    };
    widget.controller.isStart = () => _animation.value == 0.0;
    widget.controller.isEnd = () => _animation.value == 1.0;
  }

  _onStartIconPress() {
    if (widget.onStartIconPress() && mounted) _controller.forward();
  }

  _onEndIconPress() {
    if (widget.onEndIconPress() && mounted) _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    double x = _animation.value;
    double y = 1.0 - _animation.value;
    double opacityX = x >= 0 && x <= 1.0 ? x : _controller.value;
    double opacityY = y >= 0 && y <= 1.0 ? y : (1 - _controller.value);
    double angleX = math.pi / 180 * (widget.amplitude * x);
    double angleY = math.pi / 180 * (widget.amplitude * y);

    Widget _first() {
      final icon = Icon(widget.startIcon, size: widget.size);
      return Transform.rotate(
        angle: widget.clockwise ? angleX : -angleX,
        child: Opacity(
          opacity: opacityY,
          child: IconButton(
            splashColor: widget.splashColor,
            splashRadius: widget.splashRadius,
            iconSize: widget.size,
            color: widget.startIconColor ?? Theme.of(context).primaryColor,
            disabledColor: Colors.grey.shade500,
            icon: widget.startTooltip == null
                ? icon
                : Tooltip(
                    message: widget.startTooltip!,
                    child: icon,
                  ),
            onPressed: () async {
              _onStartIconPress();
              try {
                await Provider.of<ProfileProvider>(
                  context,
                  listen: false,
                ).getMyProfile();
              } on SocketException {
                SnackBars.showNoInternetConnectionSnackBar(context);
              } catch (e) {
                SnackBars.showErrorSnackBar(context, e.toString());
              }
            },
          ),
        ),
      );
    }

    Widget _second() {
      final icon = Icon(widget.endIcon);
      return Transform.rotate(
        angle: widget.clockwise ? -angleY : angleY,
        child: Opacity(
          opacity: opacityX,
          child: IconButton(
            splashColor: widget.splashColor,
            splashRadius: widget.splashRadius,
            iconSize: widget.size,
            color: widget.endIconColor ?? Theme.of(context).primaryColor,
            disabledColor: Colors.grey.shade500,
            icon: widget.endTooltip == null
                ? icon
                : Tooltip(
                    message: widget.endTooltip!,
                    child: icon,
                  ),
            onPressed: () async {
              _onEndIconPress();
              try {
                await Provider.of<ProfileProvider>(
                  context,
                  listen: false,
                ).getMyProfile();
              } on SocketException {
                SnackBars.showNoInternetConnectionSnackBar(context);
              } catch (e) {
                SnackBars.showErrorSnackBar(context, e.toString());
              }
            },
          ),
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        x == 1 && y == 0 ? _second() : _first(),
        x == 0 && y == 1 ? _first() : _second(),
      ],
    );
  }
}

class AnimateIconController {
  late bool Function() animateToStart;

  late bool Function() animateToEnd;

  late bool Function() isStart;

  late bool Function() isEnd;
}
