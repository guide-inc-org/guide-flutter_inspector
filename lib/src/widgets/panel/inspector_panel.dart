import 'package:flutter/material.dart';

class InspectorPanel extends StatefulWidget {
  const InspectorPanel({
    Key? key,
    required this.isInspectorEnabled,
    required this.isColorPickerEnabled,
    this.onInspectorStateChanged,
    this.onColorPickerStateChanged,
    required this.isColorPickerLoading,
  }) : super(key: key);

  final bool isInspectorEnabled;
  final ValueChanged<bool>? onInspectorStateChanged;

  final bool isColorPickerEnabled;
  final ValueChanged<bool>? onColorPickerStateChanged;

  final bool isColorPickerLoading;

  @override
  _InspectorPanelState createState() => _InspectorPanelState();
}

class _InspectorPanelState extends State<InspectorPanel> {
  bool _isVisible = true;

  bool get _isInspectorEnabled => widget.onInspectorStateChanged != null;
  bool get _isColorPickerEnabled => widget.onColorPickerStateChanged != null;

  void _toggleVisibility() {
    setState(() => _isVisible = !_isVisible);
  }

  void _toggleInspectorState() {
    assert(_isInspectorEnabled);
    widget.onInspectorStateChanged!(!widget.isInspectorEnabled);
  }

  void _toggleColorPickerState() {
    assert(_isColorPickerEnabled);
    widget.onColorPickerStateChanged!(!widget.isColorPickerEnabled);
  }

  IconData get _visibilityButtonIcon {
    if (_isVisible) return Icons.chevron_right;

    if (widget.isInspectorEnabled) {
      return Icons.format_shapes;
    } else if (widget.isColorPickerEnabled) {
      return Icons.colorize;
    }

    return Icons.chevron_left;
  }

  Color get _visibilityButtonBackgroundColor {
    if (_isVisible) return Colors.white;

    if (widget.isInspectorEnabled || widget.isColorPickerEnabled) {
      return Colors.blue;
    }

    return Colors.white;
  }

  Color get _visibilityButtonForegroundColor {
    if (_isVisible) return Colors.black54;

    if (widget.isInspectorEnabled || widget.isColorPickerEnabled) {
      return Colors.white;
    }

    return Colors.black54;
  }

  @override
  Widget build(BuildContext context) {
    final _height = 16.0 +
        (_isInspectorEnabled ? 56.0 : 0.0) +
        (_isColorPickerEnabled ? 64.0 : 0.0);

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            mini: true,
            onPressed: _toggleVisibility,
            backgroundColor: _visibilityButtonBackgroundColor,
            foregroundColor: _visibilityButtonForegroundColor,
            child: Icon(_visibilityButtonIcon),
          ),
          if (_isVisible) ...[
            const SizedBox(height: 16.0),
            if (_isInspectorEnabled)
              FloatingActionButton(
                onPressed: _toggleInspectorState,
                backgroundColor:
                    widget.isInspectorEnabled ? Colors.blue : Colors.white,
                foregroundColor:
                    widget.isInspectorEnabled ? Colors.white : Colors.black54,
                child: const Icon(Icons.format_shapes),
              ),
            if (_isColorPickerEnabled) ...[
              const SizedBox(height: 8.0),
              FloatingActionButton(
                onPressed: _toggleColorPickerState,
                backgroundColor:
                    widget.isColorPickerEnabled ? Colors.blue : Colors.white,
                foregroundColor:
                    widget.isColorPickerEnabled ? Colors.white : Colors.black54,
                child: widget.isColorPickerLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Icon(Icons.colorize),
              ),
            ],
          ] else
            SizedBox(height: _height),
        ],
      ),
    );
  }
}
