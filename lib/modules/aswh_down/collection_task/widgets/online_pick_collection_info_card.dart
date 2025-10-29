import 'package:flutter/material.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_state.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';

class OnlinePickCollectionInfoCard extends StatelessWidget {
  const OnlinePickCollectionInfoCard({
    super.key,
    required this.state,
  });

  final OnlinePickCollectionState state;

  Color _stepColor(OnlinePickCollectionStep step) {
    return state.step == step ? const Color(0xFF1976D2) : const Color(0xFF90A4AE);
  }

  @override
  Widget build(BuildContext context) {
    final task = state.task;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _buildChip('任务号', task.outTaskNo),
                _buildChip('库房', task.storeRoomNo ?? '-'),
                _buildChip('工位', task.workStation ?? '-'),
                _buildChip('凭证号', task.taskComment ?? '-'),
                _buildChip('采集模式', _modeLabel(state.mode)),
                _buildChip('提交接口', state.submitChannel.label),
                _buildChip('拣选口', state.selectedLocation?.label ?? '-'),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _buildStepBadge('库位', state.location.isEmpty ? '待扫描' : state.location,
                    color: _stepColor(OnlinePickCollectionStep.location)),
                _buildStepBadge('托盘', state.trayNo.isEmpty ? '待扫描' : state.trayNo,
                    color: _stepColor(OnlinePickCollectionStep.tray)),
                _buildStepBadge(
                  '物料',
                  state.currentItem?.materialCode ??
                      state.barcodeContent?.materialCode ??
                      '待扫描',
                  color: _stepColor(OnlinePickCollectionStep.material),
                ),
                _buildStepBadge(
                  '数量',
                  state.pendingQuantity?.toString() ?? '待录入',
                  color: _stepColor(OnlinePickCollectionStep.quantity),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label：',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF1976D2),
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value.isEmpty ? '-' : value,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF0D47A1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepBadge(String label, String value, {required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value.isEmpty ? '-' : value,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF263238),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _modeLabel(OnlinePickCollectionModeType mode) {
    switch (mode) {
      case OnlinePickCollectionModeType.outbound:
        return '正常采集';
      case OnlinePickCollectionModeType.inventory:
        return '库存核对';
      case OnlinePickCollectionModeType.exception:
        return '异常补录';
    }
  }
}
