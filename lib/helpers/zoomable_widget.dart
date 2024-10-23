import 'package:flutter/material.dart';

class ZoomableWidget extends StatefulWidget {
  const ZoomableWidget({
    super.key,
    required this.child,
    this.minScale = 1.0,
    this.maxScale = 2.0,
  });

  final Widget child;
  final double minScale;
  final double maxScale;

  @override
  ZoomableWidgetState createState() => ZoomableWidgetState();
}

class ZoomableWidgetState extends State<ZoomableWidget> {
  final TransformationController _transformationController =
      TransformationController();

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    // Restablecer la transformación al estado inicial
    _transformationController.value = Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: GestureDetector(
        onDoubleTap: _handleDoubleTap,
        child: InteractiveViewer(
          transformationController: _transformationController,
          panEnabled: true,
          scaleEnabled: true,
          minScale: widget.minScale,
          maxScale: widget.maxScale,
          boundaryMargin: const EdgeInsets.all(100), // Ajusta el margen para mayor desplazamiento
          clipBehavior: Clip.none,
          constrained: false, 
          child: widget.child,
        ),
      ),
    );
  }
}
