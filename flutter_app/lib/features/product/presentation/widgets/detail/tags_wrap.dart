// ─── Tags ─────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';

class TagsWrap extends StatelessWidget {
  const TagsWrap({super.key, required this.tags});

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final tag in tags)
          Chip(
            label: Text(tag),
            visualDensity: VisualDensity.compact,
            side: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
      ],
    );
  }
}
