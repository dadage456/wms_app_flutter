import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 顶部导航栏
              _buildHeader(),

              // 状态卡片区域
              _buildStatusCards(),

              // 功能区域
              _buildFunctionArea(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 120,
      decoration: const BoxDecoration(
        color: Color(0xFF1E88E5),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Stack(
        children: [
          // 背景装饰
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            left: -20,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // 标题
          const Center(
            child: Text(
              '金风科技WMS',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Transform.translate(
        offset: const Offset(0, -32),
        child: Row(
          children: [
            Expanded(
              child: _buildStatusCard(
                icon: Icons.warning,
                iconColor: const Color(0xFFFFA726),
                title: '采集异常',
                count: '99+',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatusCard(
                icon: Icons.power,
                iconColor: const Color(0xFFEF5350),
                title: '接口异常',
                count: '99+',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatusCard(
                icon: Icons.chat,
                iconColor: const Color(0xFF42A5F5),
                title: '我的消息',
                count: '99+',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String count,
  }) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(16),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconColor..withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  count,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFunctionArea() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Icon(Icons.apps, size: 20, color: Colors.black87),
                SizedBox(width: 8),
                Text(
                  '功能',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.9,
            children: [
              _buildFunctionButton(
                icon: Icons.local_shipping,
                iconColor: Colors.orange,
                title: '到货接收',
                borderColor: Colors.orange,
              ),
              _buildFunctionButton(
                icon: Icons.view_module,
                iconColor: Colors.purple,
                title: '立库组盘',
                borderColor: Colors.purple,
              ),
              _buildFunctionButton(
                icon: Icons.login,
                iconColor: Colors.green,
                title: '平库入库',
                borderColor: Colors.green,
              ),
              _buildFunctionButton(
                icon: Icons.logout,
                iconColor: Colors.pink,
                title: '平库出库',
                borderColor: Colors.pink,
              ),
              _buildFunctionButton(
                icon: Icons.check_box,
                iconColor: Colors.blue,
                title: '在线拣选',
                borderColor: Colors.blue,
              ),
              _buildFunctionButton(
                icon: Icons.send,
                iconColor: Colors.indigo,
                title: '拉式发料',
                borderColor: Colors.indigo,
              ),
              _buildFunctionButton(
                icon: Icons.bar_chart,
                iconColor: Colors.teal,
                title: '平库盘点',
                borderColor: Colors.teal,
              ),
              _buildFunctionButton(
                icon: Icons.compare_arrows,
                iconColor: Colors.red,
                title: '平库移库',
                borderColor: Colors.red,
              ),
              _buildFunctionButton(
                icon: Icons.widgets,
                iconColor: Colors.amber,
                title: '立库盘点',
                borderColor: Colors.amber,
              ),
              _buildFunctionButton(
                icon: Icons.search,
                iconColor: Colors.blue,
                title: '库存查询',
                borderColor: Colors.blue,
                isFullWidth: true,
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildFunctionButton({
    required IconData icon,
    required Color iconColor,
    required String title,
    required Color borderColor,
    bool isFullWidth = false,
  }) {
    return GestureDetector(
      onTap: () {
        // 添加点击动画效果
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black..withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border(left: BorderSide(color: borderColor, width: 4)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 11, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
