import 'package:flutter/material.dart';

class CustomSpeedDial extends StatefulWidget {
  final List<SpeedDialItem> items;
  final IconData icon;
  final IconData activeIcon;

  const CustomSpeedDial({
    super.key,
    required this.items,
    this.icon = Icons.add,
    this.activeIcon = Icons.close,
  });

  @override
  State<CustomSpeedDial> createState() => _CustomSpeedDialState();
}

class _CustomSpeedDialState extends State<CustomSpeedDial> with SingleTickerProviderStateMixin {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // Background tap to close
        if (_isOpen)
          GestureDetector(
            onTap: () => setState(() => _isOpen = false),
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

        // Action buttons
        ...List.generate(widget.items.length, (index) {
          final item = widget.items[index];
          return AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            right: 2,
            bottom: _isOpen ? 80.0 + (index * 60.0) : 20,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: _isOpen ? 1 : 0,
              child: Row(
                children: [
                  if (item.label != null)
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(item.label!, style: const TextStyle(color: Colors.black)),
                    ),
                  FloatingActionButton(
                    heroTag: item.heroTag,
                    mini: true,
                    backgroundColor: item.color ?? Colors.white54,
                    onPressed: () {
                      item.onTap();
                      setState(() => _isOpen = false);
                    },
                    child: Icon(item.icon, size: 20),
                  ),
                ],
              ),
            ),
          );
        }),

        // Main FAB
        Positioned(
          right: 2,
          bottom: 10,
          child: SizedBox(
            width: 45,
            height: 45,
            child: FloatingActionButton(
              backgroundColor: Colors.white54,
              shape: CircleBorder(),
              onPressed: () => setState(() => _isOpen = !_isOpen),
              child: Icon(_isOpen ? widget.activeIcon : widget.icon),
            ),
          ),
        ),
      ],
    );
  }
}

class SpeedDialItem {
  final IconData icon;
  final String? label;
  final VoidCallback onTap;
  final String heroTag;
  final Color? color;

  SpeedDialItem({
    required this.icon,
    required this.onTap,
    required this.heroTag,
    this.label,
    this.color,
  });
}

