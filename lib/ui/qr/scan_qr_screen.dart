import 'package:flutter/material.dart';

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({super.key});

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  bool _cameraPermissionGranted = false;
  bool _permissionDeniedPermanently = false;
  bool _flashOn = false;
  bool _frontCamera = false;
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _requestCameraPermission();
      }
    });
  }

  Future<void> _requestCameraPermission() async {
    final bool? granted = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.camera_alt_outlined, color: Color(0xFF0052CC)),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Izinkan Akses Kamera?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
        content: const Text(
          'HMTI Management System memerlukan izin kamera untuk memindai QR Code presensi kegiatan.',
          style: TextStyle(fontSize: 13, height: 1.4, color: Colors.black87),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Tolak', style: TextStyle(color: Colors.black54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0052CC),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Izinkan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );

    if (!mounted) return;

    if (granted == true) {
      setState(() {
        _cameraPermissionGranted = true;
        _permissionDeniedPermanently = false;
      });
    } else {
      setState(() {
        _cameraPermissionGranted = false;
        _permissionDeniedPermanently = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Izin kamera belum diberikan. Aktifkan kamera untuk scan QR.',
          ),
        ),
      );
    }
  }

  Future<void> _handleScanAction() async {
    if (!_cameraPermissionGranted) {
      await _requestCameraPermission();
      if (!_cameraPermissionGranted || !mounted) return;
    }

    setState(() => _isScanning = true);
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() => _isScanning = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Presensi QR berhasil tercatat (${_frontCamera ? 'Kamera Depan' : 'Kamera Belakang'}).',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _toggleFlash() {
    if (!_cameraPermissionGranted) {
      _requestCameraPermission();
      return;
    }
    setState(() => _flashOn = !_flashOn);
  }

  void _switchCamera() {
    if (!_cameraPermissionGranted) {
      _requestCameraPermission();
      return;
    }
    setState(() => _frontCamera = !_frontCamera);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0052CC),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Back',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          children: [
            const Text(
              'Scan Code Presensi',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            // Kotak Viewfinder QR Gelap
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 410),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: BoxDecoration(
                color: const Color(0xFF232B38),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.14),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!_cameraPermissionGranted) ...[
                    const Icon(
                      Icons.videocam_off_outlined,
                      size: 54,
                      color: Color(0xFFFFD700),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Izin Kamera Diperlukan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _permissionDeniedPermanently
                          ? 'Akses kamera belum diizinkan. Tekan tombol di bawah untuk meminta izin kamera.'
                          : 'Meminta izin akses kamera...',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 18),
                    ElevatedButton.icon(
                      onPressed: _requestCameraPermission,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0052CC),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.camera_alt, size: 18),
                      label: const Text(
                        'Minta Izin Kamera',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ] else ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _frontCamera
                            ? 'Kamera Depan Aktif'
                            : 'Kamera Belakang Aktif',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: 210,
                      height: 210,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 184,
                            height: 184,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: _isScanning
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xFFFFD700),
                                    ),
                                  )
                                : const Icon(
                                    Icons.qr_code_2,
                                    size: 86,
                                    color: Colors.white54,
                                  ),
                          ),
                          // Garis laser kuning
                          Container(
                            width: 196,
                            height: 3,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Color(0xFFFFD700),
                                  Colors.transparent,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          // 4 sudut biru viewfinder
                          const Positioned(
                            top: 0,
                            left: 0,
                            child: _ViewfinderCorner(
                              top: true,
                              left: true,
                            ),
                          ),
                          const Positioned(
                            top: 0,
                            right: 0,
                            child: _ViewfinderCorner(
                              top: true,
                              left: false,
                            ),
                          ),
                          const Positioned(
                            bottom: 0,
                            left: 0,
                            child: _ViewfinderCorner(
                              top: false,
                              left: true,
                            ),
                          ),
                          const Positioned(
                            bottom: 0,
                            right: 0,
                            child: _ViewfinderCorner(
                              top: false,
                              left: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'Arahkan kamera ke QR Code presensi\nkegiatan HMTI',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Bar Tombol Flash, Kamera, Scan
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: _toggleFlash,
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: _flashOn
                              ? const Color(0xFFFFF3C4)
                              : const Color(0xFFEEF3FC),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _flashOn ? Icons.flash_on : Icons.flash_off,
                              size: 18,
                              color: Colors.black87,
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Flash',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: _switchCamera,
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF3FC),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cameraswitch_outlined,
                              size: 18,
                              color: Colors.black87,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Kamera',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: _handleScanAction,
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0052CC),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.qr_code_scanner,
                              size: 18,
                              color: Colors.white,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Scan',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ViewfinderCorner extends StatelessWidget {
  final bool top;
  final bool left;

  const _ViewfinderCorner({
    required this.top,
    required this.left,
  });

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFF0052CC);
    const thickness = 5.0;
    const length = 26.0;

    return SizedBox(
      width: length,
      height: length,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: top
                ? const BorderSide(color: color, width: thickness)
                : BorderSide.none,
            bottom: !top
                ? const BorderSide(color: color, width: thickness)
                : BorderSide.none,
            left: left
                ? const BorderSide(color: color, width: thickness)
                : BorderSide.none,
            right: !left
                ? const BorderSide(color: color, width: thickness)
                : BorderSide.none,
          ),
          borderRadius: BorderRadius.only(
            topLeft: (top && left) ? const Radius.circular(10) : Radius.zero,
            topRight: (top && !left) ? const Radius.circular(10) : Radius.zero,
            bottomLeft:
                (!top && left) ? const Radius.circular(10) : Radius.zero,
            bottomRight:
                (!top && !left) ? const Radius.circular(10) : Radius.zero,
          ),
        ),
      ),
    );
  }
}