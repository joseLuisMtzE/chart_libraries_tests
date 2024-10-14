import 'package:flutter/material.dart';

class ZoomableWidget extends StatefulWidget {
  const ZoomableWidget({
    super.key,
    required this.child,
    this.minScale = 1.0,
    this.maxScale = 4.0,
  });

  final Widget child;
  final double minScale;
  final double maxScale;

  @override
  ZoomableWidgetState createState() => ZoomableWidgetState(); 
}

class ZoomableWidgetState extends State<ZoomableWidget> {
  final TransformationController _transformationController = TransformationController();

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
    return GestureDetector(
      onDoubleTap: _handleDoubleTap, // Restablecer zoom al hacer doble toque
      child: InteractiveViewer(
        transformationController: _transformationController,
        panEnabled: true, // Permite desplazar el contenido
        scaleEnabled: true, // Permite hacer zoom
        minScale: widget.minScale, // Escala mínima permitida
        maxScale: widget.maxScale, // Escala máxima permitida
        boundaryMargin: const EdgeInsets.all(16), // Margen adicional para permitir zoom fuera de los límites
        child: widget.child, // El widget hijo que será envuelto
      ),
    );
  }
}