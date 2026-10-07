// ─── Skeleton ─────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

const _pagePadding = 16.0;
const _sectionSpacing = 16.0;
const _galleryHeight = 320.0;

class DetailSkeleton extends StatelessWidget {
  const DetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Bone(
            width: double.infinity,
            height: _galleryHeight,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(_pagePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Bone(
                  width: 110,
                  height: 22,
                  borderRadius: BorderRadius.circular(100),
                ),
                const SizedBox(height: 12),
                const Bone.multiText(lines: 2),
                const SizedBox(height: 12),
                Bone(
                  width: 140,
                  height: 14,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: _sectionSpacing),
                Bone(
                  width: double.infinity,
                  height: 96,
                  borderRadius: BorderRadius.circular(16),
                ),
                const SizedBox(height: _sectionSpacing),
                Bone(
                  width: double.infinity,
                  height: 64,
                  borderRadius: BorderRadius.circular(16),
                ),
                const SizedBox(height: _sectionSpacing),
                Bone(
                  width: double.infinity,
                  height: 140,
                  borderRadius: BorderRadius.circular(16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
