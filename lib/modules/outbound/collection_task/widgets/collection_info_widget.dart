import 'package:flutter/material.dart';
import '../models/collection_models.dart';

class CollectionInfoWidget extends StatelessWidget {
  final String storeSite;
  final double repQty;
  final BarcodeContent? barcodeContent;
  final double collectQty;

  const CollectionInfoWidget({
    Key? key,
    required this.storeSite,
    required this.repQty,
    this.barcodeContent,
    required this.collectQty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('库位:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(storeSite.isEmpty ? '-' : storeSite),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('库存:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(repQty.toString()),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('物料:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(barcodeContent?.matcode ?? '-'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('采集数量:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(collectQty.toString()),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('名称:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(barcodeContent?.matname ?? '-'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('批次:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(barcodeContent?.batchno ?? '-'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const Text('序列:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Expanded(child: Text(barcodeContent?.sn ?? '-')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}