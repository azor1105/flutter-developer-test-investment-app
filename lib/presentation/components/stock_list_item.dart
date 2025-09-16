import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/stock_entity.dart';
import '../assets/asset_index.dart';

class StockListItem extends StatelessWidget {
  final StockEntity stock;
  final VoidCallback? onTap;

  const StockListItem({
    Key? key,
    required this.stock,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(ScreenSize.w16),
        margin: EdgeInsets.symmetric(
          horizontal: ScreenSize.w16,
          vertical: ScreenSize.h6,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Company Logo
            Container(
              width: ScreenSize.h48,
              height: ScreenSize.h48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[100],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: stock.logo,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.business,
                      color: Colors.grey,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.business,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(width: ScreenSize.w12),

            // Company Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stock.companyName,
                    style: AppTextStyles.subtitle2.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: ScreenSize.h4),
                  Row(
                    children: [
                      Text(
                        stock.tradingSymbol,
                        style: AppTextStyles.bodyText2.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(width: ScreenSize.w8),
                      Text(
                        stock.currency,
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Price and Compliance Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${stock.price.price.toStringAsFixed(2)}',
                  style: AppTextStyles.subtitle2.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: ScreenSize.h4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Price Change
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenSize.w6,
                        vertical: ScreenSize.h2,
                      ),
                      decoration: BoxDecoration(
                        color: stock.price.changePercent >= 0
                            ? Colors.green.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${stock.price.changePercent >= 0 ? '+' : ''}${stock.price.changePercent.toStringAsFixed(2)}%',
                        style: AppTextStyles.caption.copyWith(
                          color: stock.price.changePercent >= 0
                              ? Colors.green[700]
                              : Colors.red[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    SizedBox(width: ScreenSize.w8),

                    // Compliance Status
                    if (stock.shariahCheck)
                      Container(
                        width: ScreenSize.w20,
                        height: ScreenSize.w20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: stock.isCompliant ? Colors.green : Colors.red,
                        ),
                        child: Icon(
                          stock.isCompliant ? Icons.check : Icons.close,
                          color: Colors.white,
                          size: ScreenSize.w12,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
