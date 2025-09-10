import 'package:flutter/material.dart';

class EarningCard extends StatelessWidget {
  final String titleTop;
  final String titleBottom;
  final String amount;
  final Color cardColor;
  final Color accent;
  final Color subtle;
  final bool isTablet;

  const EarningCard({
    super.key,
    required this.titleTop,
    required this.titleBottom,
    required this.amount,
    required this.cardColor,
    required this.accent,
    required this.subtle,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 28 : 20,
        vertical: isTablet ? 28 : 22,
      ),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$titleTop\n$titleBottom',
            style: TextStyle(
              color: subtle,
              fontSize: isTablet ? 22 : 18,
              height: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: isTablet ? 18 : 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Responsive coin icon
              Container(
                width: isTablet ? 48 : 36,
                height: isTablet ? 48 : 36,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(isTablet ? 24 : 18),
                  border: Border.all(color: accent, width: isTablet ? 4 : 3),
                ),
                alignment: Alignment.center,
                child: Icon(Icons.eco, color: accent, size: isTablet ? 28 : 20),
              ),
              SizedBox(width: isTablet ? 16 : 12),
              Expanded(
                child: Text(
                  amount,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: isTablet ? 56 : 44,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isTablet ? 18 : 14),
        ],
      ),
    );
  }
}
