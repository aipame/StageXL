part of stagexl.drawing.internal;

class GraphicsContextBounds extends GraphicsContext {

  double _minX = 0.0 + double.MAX_FINITE;
  double _minY = 0.0 + double.MAX_FINITE;
  double _maxX = 0.0 - double.MAX_FINITE;
  double _maxY = 0.0 - double.MAX_FINITE;

  //---------------------------------------------------------------------------

  double get minX => _minX;
  double get minY => _minY;
  double get maxX => _maxX;
  double get maxY => _maxY;

  Rectangle<num> get bounds {
    if (minX < maxX && minY < maxY) {
      return new Rectangle<double>(minX, minY, maxX - minX, maxY - minY);
    } else {
      return new Rectangle<double>(0.0, 0.0, 0.0, 0.0);
    }
  }

  //---------------------------------------------------------------------------

  @override
  void fillColor(int color) {
    _updateBoundsForFill();
  }

  @override
  void fillGradient(GraphicsGradient gradient) {
    _updateBoundsForFill();
  }

  @override
  void fillPattern(GraphicsPattern pattern) {
    _updateBoundsForFill();
  }

  @override
  void strokeColor(int color, double width, String jointStyle, String capsStyle) {
    _updateBoundsForStroke();
  }

  @override
  void strokeGradient(GraphicsGradient gradient, double width, String jointStyle, String capsStyle) {
    _updateBoundsForStroke();
  }

  @override
  void strokePattern(GraphicsPattern pattern, double width, String jointStyle, String capsStyle) {
    _updateBoundsForStroke();
  }

  //---------------------------------------------------------------------------

  void _updateBoundsForFill() {
    _path.segments.forEach(_updateBoundsForMesh);
  }

  void _updateBoundsForStroke() {
    var stroke = _stroke ?? new GraphicsStroke(_path, _command);
    stroke.segments.forEach(_updateBoundsForMesh);
  }

  void _updateBoundsForMesh(GraphicsMesh mesh) {
    _minX = _minX > mesh.minX ? mesh.minX : _minX;
    _minY = _minY > mesh.minY ? mesh.minY : _minY;
    _maxX = _maxX < mesh.maxX ? mesh.maxX : _maxX;
    _maxY = _maxY < mesh.maxY ? mesh.maxY : _maxY;
  }

}
