import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'chat_detail_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  String _searchQuery = '';

  final List<ChatPreview> _chats = [
    ChatPreview(
      name: 'Abebe Kebede',
      lastMessage: 'Hi, is the room still available?',
      time: '10:30 AM',
      unreadCount: 2,
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      isOnline: true,
    ),
    ChatPreview(
      name: 'Kebede Alemu',
      lastMessage: 'Thanks for the quick response!',
      time: 'Yesterday',
      unreadCount: 0,
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
      isOnline: false,
    ),
    ChatPreview(
      name: 'Sara Haile',
      lastMessage: 'Can we schedule a viewing?',
      time: 'Yesterday',
      unreadCount: 1,
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      isOnline: true,
    ),
    ChatPreview(
      name: 'Dawit Teklu',
      lastMessage: 'The location works perfectly for me',
      time: '2 days ago',
      unreadCount: 0,
      avatarUrl: 'https://i.pravatar.cc/150?img=4',
      isOnline: false,
    ),
    ChatPreview(
      name: 'Martha Solomon',
      lastMessage: 'What are the house rules?',
      time: '3 days ago',
      unreadCount: 0,
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
      isOnline: true,
    ),
  ];

  List<ChatPreview> get _filteredChats {
    if (_searchQuery.isEmpty) return _chats;
    return _chats.where((chat) {
      return chat.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          chat.lastMessage.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            'images/Vector.svg',
            color: Theme.of(context).primaryColor,
          ),
        ),
        title:
            _isSearching
                ? TextField(
                  controller: _searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search conversations...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey[700]),
                  ),
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                )
                : const Text('Chats'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        titleTextStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Container(
        color: Colors.pink.withOpacity(0.05),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _filteredChats.length,
                itemBuilder: (context, index) {
                  final chat = _filteredChats[index];
                  return ChatListItem(chat: chat);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatPreview {
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final String avatarUrl;
  final bool isOnline;

  ChatPreview({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.avatarUrl,
    required this.isOnline,
  });
}

class ChatListItem extends StatelessWidget {
  final ChatPreview chat;

  const ChatListItem({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => ChatDetailScreen(
                  name: chat.name,
                  avatarUrl: chat.avatarUrl,
                  isOnline: chat.isOnline,
                ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[200]!, width: 1),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(chat.avatarUrl),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chat.lastMessage,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            if (chat.unreadCount > 0)
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                alignment: Alignment.center,
                child: Text(
                  chat.unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
