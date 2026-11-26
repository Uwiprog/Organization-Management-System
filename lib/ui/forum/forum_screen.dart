import 'package:flutter/material.dart';

class ForumMessage {
  final String id;
  final String senderName;
  final String roleBadge;
  final Color badgeBg;
  final Color badgeColor;
  final String time;
  final String text;
  final String topic;
  final bool isMe;
  final String? reactionEmoji;
  final int reactionCount;
  final String? attachmentName;

  const ForumMessage({
    required this.id,
    required this.senderName,
    required this.roleBadge,
    required this.badgeBg,
    required this.badgeColor,
    required this.time,
    required this.text,
    required this.topic,
    required this.isMe,
    this.reactionEmoji,
    this.reactionCount = 0,
    this.attachmentName,
  });

  ForumMessage copyWith({
    int? reactionCount,
    String? attachmentName,
  }) {
    return ForumMessage(
      id: id,
      senderName: senderName,
      roleBadge: roleBadge,
      badgeBg: badgeBg,
      badgeColor: badgeColor,
      time: time,
      text: text,
      topic: topic,
      isMe: isMe,
      reactionEmoji: reactionEmoji,
      reactionCount: reactionCount ?? this.reactionCount,
      attachmentName: attachmentName ?? this.attachmentName,
    );
  }
}

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  String _selectedTopic = 'Semua';
  String? _pendingAttachment;

  final List<String> _topics = const [
    'Semua',
    'Coding Help',
    'Event HMTI',
    'Santai',
  ];

  final List<ForumMessage> _messages = [
    const ForumMessage(
      id: 'm1',
      senderName: 'Dimas Pratama',
      roleBadge: 'Anggota',
      badgeBg: Color(0xFFD6E4FF),
      badgeColor: Color(0xFF0052CC),
      time: '10:14',
      text:
          'Bang ada yg bisa bantuin error ini nggak ya? Stuck di API integration tugas praktikum nih 😅',
      topic: 'Coding Help',
      isMe: false,
      reactionEmoji: '👍',
      reactionCount: 4,
    ),
    const ForumMessage(
      id: 'm2',
      senderName: 'Kak Raka',
      roleBadge: 'Pengurus',
      badgeBg: Color(0xFFFFF3C4),
      badgeColor: Color(0xFF9A6700),
      time: '10:16',
      text: 'Coba kirim error nya sini, nanti kita cek bareng-bareng!',
      topic: 'Coding Help',
      isMe: false,
      reactionEmoji: '🔥',
      reactionCount: 3,
    ),
    const ForumMessage(
      id: 'm3',
      senderName: 'M Dwi Haryanto',
      roleBadge: 'Pengurus',
      badgeBg: Color(0xFFFFF3C4),
      badgeColor: Color(0xFF9A6700),
      time: '10:17',
      text: 'Halo guys apa kabar nih',
      topic: 'Santai',
      isMe: true,
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<ForumMessage> get _filteredMessages {
    if (_selectedTopic == 'Semua') return _messages;
    return _messages.where((m) => m.topic == _selectedTopic).toList();
  }

  String _formatNow() {
    final now = DateTime.now();
    final hh = now.hour.toString().padLeft(2, '0');
    final mm = now.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }

  void _attachSampleFile() {
    setState(() {
      _pendingAttachment = 'error_log_praktikum.txt';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Lampiran error_log_praktikum.txt ditambahkan.'),
      ),
    );
  }

  void _sendMessage() {
    final raw = _messageController.text.trim();
    if (raw.isEmpty && _pendingAttachment == null) return;

    final topicForMessage =
        _selectedTopic == 'Semua' ? 'Coding Help' : _selectedTopic;

    final newMsg = ForumMessage(
      id: 'm_${DateTime.now().microsecondsSinceEpoch}',
      senderName: 'M Dwi Haryanto',
      roleBadge: 'Pengurus',
      badgeBg: const Color(0xFFFFF3C4),
      badgeColor: const Color(0xFF9A6700),
      time: _formatNow(),
      text: raw.isEmpty ? 'Mengirim lampiran file' : raw,
      topic: topicForMessage,
      isMe: true,
      attachmentName: _pendingAttachment,
    );

    setState(() {
      _messages.add(newMsg);
      _messageController.clear();
      _pendingAttachment = null;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 120,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _toggleReaction(String messageId) {
    setState(() {
      final idx = _messages.indexWhere((m) => m.id == messageId);
      if (idx == -1) return;
      final current = _messages[idx];
      _messages[idx] = current.copyWith(
        reactionCount: current.reactionCount + 1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredMessages;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: Column(
        children: [
          // Header Biru HMTI
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 44,
              left: 16,
              right: 16,
              bottom: 18,
            ),
            color: const Color(0xFF0052CC),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFFD700),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.shield,
                    size: 30,
                    color: Color(0xFF0052CC),
                  ),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HMTI',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        height: 1.05,
                      ),
                    ),
                    Text(
                      'MANAGEMENT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        height: 1.05,
                      ),
                    ),
                    Text(
                      'SYSTEM',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        height: 1.05,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Notifikasi forum aktif.')),
                    );
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul Forum & Badge 24 ONLINE
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'HMTI - FORUM',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Where every HMTI member can sharing and talk',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.circle,
                              size: 8,
                              color: Color(0xFF0052CC),
                            ),
                            SizedBox(width: 5),
                            Text(
                              '24 ONLINE',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Filter Topik Horizontal
                  SizedBox(
                    height: 36,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _topics.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final topic = _topics[index];
                        final selected = _selectedTopic == topic;
                        return ChoiceChip(
                          label: Text(topic),
                          selected: selected,
                          onSelected: (_) => setState(() => _selectedTopic = topic),
                          selectedColor: const Color(0xFFD6E4FF),
                          backgroundColor: Colors.white,
                          labelStyle: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.bold,
                            color: selected
                                ? const Color(0xFF0052CC)
                                : Colors.black54,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide.none,
                          ),
                          showCheckmark: false,
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Area Chat Container
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F4FC),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'HARI INI',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        if (items.isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 28),
                            child: Text(
                              'Belum ada pesan di topik ini.',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          )
                        else
                          ...items.map((msg) {
                            if (msg.isMe) {
                              return _buildOutgoingBubble(msg);
                            }
                            return _buildIncomingBubble(msg);
                          }),

                        const SizedBox(height: 18),

                        if (_pendingAttachment != null)
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.insert_drive_file_outlined,
                                  size: 16,
                                  color: Color(0xFF0052CC),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  _pendingAttachment!,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                GestureDetector(
                                  onTap: () =>
                                      setState(() => _pendingAttachment = null),
                                  child: const Icon(
                                    Icons.close,
                                    size: 15,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        // Input Bar Kirim Pesan
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.attach_file,
                                  color: Colors.black54,
                                  size: 20,
                                ),
                                onPressed: _attachSampleFile,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _messageController,
                                  textInputAction: TextInputAction.send,
                                  onSubmitted: (_) => _sendMessage(),
                                  decoration: const InputDecoration(
                                    hintText: 'Tulis pesan untuk HMTI...',
                                    hintStyle: TextStyle(
                                      fontSize: 12.5,
                                      color: Colors.grey,
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              GestureDetector(
                                onTap: _sendMessage,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF0052CC),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.send_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomingBubble(ForumMessage msg) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xFFD6E4FF),
            child: Icon(Icons.person, size: 20, color: Color(0xFF0052CC)),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      msg.senderName,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: msg.badgeBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        msg.roleBadge,
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                          color: msg.badgeColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      msg.time,
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        msg.text,
                        style: const TextStyle(
                          fontSize: 12.5,
                          height: 1.38,
                          color: Colors.black87,
                        ),
                      ),
                      if (msg.attachmentName != null) ...[
                        const SizedBox(height: 6),
                        Text(
                          '📎 ${msg.attachmentName}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF0052CC),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (msg.reactionEmoji != null) ...[
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () => _toggleReaction(msg.id),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${msg.reactionEmoji} ${msg.reactionCount}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutgoingBubble(ForumMessage msg) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 320),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: const BoxDecoration(
                color: Color(0xFF0052CC),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(4),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    msg.text,
                    style: const TextStyle(
                      fontSize: 12.5,
                      height: 1.35,
                      color: Colors.white,
                    ),
                  ),
                  if (msg.attachmentName != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      '📎 ${msg.attachmentName}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  msg.time,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.done_all,
                  size: 14,
                  color: Color(0xFF0052CC),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}