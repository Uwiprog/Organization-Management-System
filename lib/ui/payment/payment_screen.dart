import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentItem {
  final String id;
  final String nama;
  final String deadline;
  final int harga;
  bool isLunas;
  bool isChecked;

  PaymentItem({
    required this.id,
    required this.nama,
    required this.deadline,
    required this.harga,
    this.isLunas = false,
    this.isChecked = false,
  });
}

class PaymentScreen extends StatefulWidget {
  final String namaKegiatan;
  final int nominalDefault;

  const PaymentScreen({
    super.key,
    this.namaKegiatan = 'HAKRAB 2026',
    this.nominalDefault = 120000,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {
  static const String _paidIdsKey = 'hmti_paid_payment_ids';

  late TabController _tabController;
  String _selectedMethod = 'QRIS Instant';

  final List<PaymentItem> _items = [
    PaymentItem(
      id: 'termin_1_hakrab_2026',
      nama: 'Termin 1 HAKRAB 2026',
      deadline: '28 November 2026',
      harga: 120000,
      isLunas: false,
    ),
    PaymentItem(
      id: 'termin_2_hakrab_2026',
      nama: 'Termin 2 HAKRAB 2026',
      deadline: '10 Desember 2026',
      harga: 100000,
      isLunas: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadPaidItems();
  }

  Future<void> _loadPaidItems() async {
    final prefs = await SharedPreferences.getInstance();
    final paidIds = prefs.getStringList(_paidIdsKey) ?? const <String>[];
    if (!mounted) return;

    setState(() {
      for (final item in _items) {
        if (paidIds.contains(item.id)) {
          item.isLunas = true;
          item.isChecked = false;
        }
      }
    });
  }

  Future<void> _savePaidItems() async {
    final prefs = await SharedPreferences.getInstance();
    final paidIds =
        _items.where((item) => item.isLunas).map((item) => item.id).toList();
    await prefs.setStringList(_paidIdsKey, paidIds);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int get _totalSelectedHarga {
    return _items
        .where((item) => !item.isLunas && item.isChecked)
        .fold(0, (sum, item) => sum + item.harga);
  }

  bool get _isAllChecked {
    final unpaid = _items.where((item) => !item.isLunas).toList();
    if (unpaid.isEmpty) return false;
    return unpaid.every((item) => item.isChecked);
  }

  void _toggleSelectAll(bool? val) {
    setState(() {
      final targetVal = val ?? false;
      for (final item in _items) {
        if (!item.isLunas) {
          item.isChecked = targetVal;
        }
      }
    });
  }

  void _showPaymentMethodBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Metode Pembayaran',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 8),
                  RadioListTile<String>(
                    title: const Text('QRIS (BCA / Mandiri / GoPay / ShopeePay)'),
                    value: 'QRIS Instant',
                    groupValue: _selectedMethod,
                    onChanged: (val) {
                      setModalState(() => _selectedMethod = val!);
                      setState(() {});
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Transfer Bank (VA BCA / Mandiri)'),
                    value: 'Transfer Bank',
                    groupValue: _selectedMethod,
                    onChanged: (val) {
                      setModalState(() => _selectedMethod = val!);
                      setState(() {});
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Tunai / Bendahara HMTI'),
                    value: 'Tunai',
                    groupValue: _selectedMethod,
                    onChanged: (val) {
                      setModalState(() => _selectedMethod = val!);
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F4FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Pembayaran:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Rp ${_totalSelectedHarga.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(0xFF0052CC),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0052CC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        Navigator.pop(ctx);
                        await _processPayment();
                      },
                      child: const Text(
                        'Konfirmasi & Bayar Sekarang',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _processPayment() async {
    setState(() {
      for (final item in _items) {
        if (!item.isLunas && item.isChecked) {
          item.isLunas = true;
          item.isChecked = false;
        }
      }
    });

    await _savePaidItems();

    if (!mounted) return;
    _tabController.animateTo(1);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pembayaran tersimpan! Item pindah ke Sudah Dibayar.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final unpaidItems = _items.where((i) => !i.isLunas).toList();
    final paidItems = _items.where((i) => i.isLunas).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0052CC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Back',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
            child: Text(
              'Payment Info',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: Colors.black87,
              ),
            ),
          ),
          Container(
            height: 42,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(6),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFF0052CC), width: 1.5),
              ),
              labelColor: Colors.black87,
              unselectedLabelColor: Colors.white,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              tabs: const [
                Tab(text: 'Belum Dibayar'),
                Tab(text: 'Sudah Dibayar'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                unpaidItems.isEmpty
                    ? const Center(
                        child: Text(
                          'Semua tagihan sudah dibayar!',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: unpaidItems.length,
                        itemBuilder: (context, index) {
                          final item = unpaidItems[index];
                          return _buildPaymentCard(item: item, isPaid: false);
                        },
                      ),
                paidItems.isEmpty
                    ? const Center(
                        child: Text(
                          'Belum ada riwayat pembayaran.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: paidItems.length,
                        itemBuilder: (context, index) {
                          final item = paidItems[index];
                          return _buildPaymentCard(item: item, isPaid: true);
                        },
                      ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: _tabController,
            builder: (context, _) {
              if (_tabController.index == 0 && unpaidItems.isNotEmpty) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 6,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _isAllChecked,
                        onChanged: _toggleSelectAll,
                      ),
                      const Text(
                        'TOTAL',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Rp ${_totalSelectedHarga.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0052CC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _totalSelectedHarga == 0
                            ? null
                            : () => _showPaymentMethodBottomSheet(context),
                        child: const Text(
                          'Bayar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard({required PaymentItem item, required bool isPaid}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black87, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (!isPaid)
                Checkbox(
                  value: item.isChecked,
                  onChanged: (val) {
                    setState(() {
                      item.isChecked = val ?? false;
                    });
                  },
                ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isPaid ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  isPaid ? 'Sudah Dibayar' : 'Belum Dibayar',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: isPaid ? 4 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 70,
                      child: Text(
                        'Nama',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const Text(' :  '),
                    Expanded(
                      child: Text(
                        item.nama,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const SizedBox(
                      width: 70,
                      child: Text(
                        'Deadline',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const Text(' :  '),
                    Expanded(
                      child: Text(
                        item.deadline,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const SizedBox(
                      width: 70,
                      child: Text(
                        'Harga',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const Text(' :  '),
                    Text(
                      'Rp ${item.harga.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}