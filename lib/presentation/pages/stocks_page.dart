import 'package:flutter/material.dart';
import 'package:stock_investment_app/presentation/assets/asset_index.dart';
import 'package:stock_investment_app/presentation/components/defocus.dart';
import 'package:stock_investment_app/presentation/components/search_bar_x.dart';

class StocksPage extends StatefulWidget {
  const StocksPage({super.key});

  @override
  State<StocksPage> createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DeFocus(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Stock Investments',
            style: AppTextStyles.subtitle1,
          ),
          centerTitle: false,
          leading: const BackButton(),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenSize.w16,
                  vertical: ScreenSize.h12,
                ),
                child: SearchBarX(
                  onChanged: (v) {},
                  controller: controller,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
