import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WMSHomePage extends StatelessWidget {
  const WMSHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section with Gradient Background
            Container(
              height: 250,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                ),
              ),
              child: Stack(
                children: [
                  // Background pattern
                  Positioned(
                    right: -50,
                    top: -50,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -80,
                    top: 100,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.05),
                      ),
                    ),
                  ),
                  // Title
                  const Positioned(
                    top: 110,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        '金风科技WMS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  // Exit Icon
                  Positioned(
                    top: 44,
                    right: 20,
                    child: Container(
                      width: 27,
                      height: 24,
                      child: Icon(Icons.logout, color: Colors.white, size: 24),
                    ),
                  ),
                  // Announcement
                  Positioned(
                    bottom: 50,
                    left: 20,
                    right: 20,
                    child: Row(
                      children: [
                        Icon(Icons.volume_up, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        const Text(
                          '公告：重大喜讯，金风科技wms上新了',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Notification Cards
            Transform.translate(
              offset: const Offset(0, -35),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 22),
                padding: const EdgeInsets.symmetric(
                  horizontal: 37,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNotificationCard(
                      '采集异常',
                      Icons.warning,
                      const Color(0xFFFF7637),
                    ),
                    _buildNotificationCard(
                      '接口异常',
                      Icons.link_off,
                      const Color(0xFFFF7637),
                    ),
                    _buildNotificationCard(
                      '我的消息',
                      Icons.message,
                      const Color(0xFF0099F9),
                    ),
                  ],
                ),
              ),
            ),
            // Functions Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '功能',
                    style: TextStyle(
                      color: Color(0xFF374150),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Function Grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 2.85,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: [
                      _buildFunctionCard(
                        '到货接收',
                        Icons.inventory_2,
                        const Color(0xFFF77234),
                        showBadge: true,
                      ),
                      _buildFunctionCard(
                        '立库组盘',
                        Icons.view_module,
                        const Color(0xFF887ADE),
                      ),
                      _buildFunctionCard(
                        '平库入库',
                        Icons.move_to_inbox,
                        const Color(0xFF2BC883),
                      ),
                      GestureDetector(
                        onTap: () => Modular.to.pushNamed('/outbound/'),
                        child: _buildFunctionCard(
                          '平库出库',
                          Icons.outbox,
                          const Color(0xFFDE406C),
                        ),
                      ),
                      _buildFunctionCard(
                        '在线拣选',
                        Icons.assignment,
                        const Color(0xFF4674C5),
                      ),
                      _buildFunctionCard(
                        '拉式发料',
                        Icons.description,
                        const Color(0xFF67A2E0),
                      ),
                      _buildFunctionCard(
                        '平库盘点',
                        Icons.search,
                        const Color(0xFF55BFD4),
                      ),
                      _buildFunctionCard(
                        '平库移库',
                        Icons.sync_alt,
                        const Color(0xFFDE406C),
                      ),
                      _buildFunctionCard(
                        '立库盘点',
                        Icons.edit,
                        const Color(0xFF55BFD4),
                      ),
                      _buildFunctionCard(
                        '库存查询',
                        Icons.search,
                        const Color(0xFF4674C5),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(String title, IconData icon, Color color) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white.withOpacity(0.9), size: 28),
            ),
            Positioned(
              top: -2,
              right: -2,
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF5304),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Center(
                  child: Text(
                    '99',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF323337),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildFunctionCard(
    String title,
    IconData icon,
    Color color, {
    bool showBadge = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (showBadge)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF5304),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
