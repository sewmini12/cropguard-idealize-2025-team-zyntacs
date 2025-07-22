import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _postController = TextEditingController();

  final List<Map<String, dynamic>> _posts = [
    {
      'id': 1,
      'author': 'GreenThumb_Sarah',
      'avatar': 'S',
      'time': '2 hours ago',
      'content':
          'Just discovered an amazing natural pesticide recipe! Mix neem oil with soapy water and spray on affected plants. Works wonders for aphids! 🌱',
      'likes': 23,
      'comments': 5,
      'tags': ['pest-control', 'organic', 'tips'],
      'type': 'tip'
    },
    {
      'id': 2,
      'author': 'FarmMaster_John',
      'avatar': 'J',
      'time': '4 hours ago',
      'content':
          'Help needed! My tomato plants are showing yellow spots on leaves. I\'ve attached photos. Has anyone seen this before? Location: California, Zone 9b',
      'likes': 8,
      'comments': 12,
      'tags': ['tomatoes', 'disease', 'help-needed'],
      'type': 'problem'
    },
    {
      'id': 3,
      'author': 'OrganicGuru',
      'avatar': 'O',
      'time': '6 hours ago',
      'content':
          'Companion planting update: My basil and tomatoes are thriving together! The basil seems to be keeping the pests away naturally. Highly recommend this combination! 🍅🌿',
      'likes': 31,
      'comments': 8,
      'tags': ['companion-planting', 'organic', 'success-story'],
      'type': 'tip'
    },
    {
      'id': 4,
      'author': 'NewbieFarmer',
      'avatar': 'N',
      'time': '1 day ago',
      'content':
          'First time growing peppers and they\'re flowering! When should I expect fruits? Any care tips for the flowering stage? So excited! 🌶️',
      'likes': 15,
      'comments': 9,
      'tags': ['peppers', 'beginner', 'flowering'],
      'type': 'question'
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'All Posts'),
            Tab(text: 'Tips'),
            Tab(text: 'Problems'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPostsList(_posts),
          _buildPostsList(
              _posts.where((post) => post['type'] == 'tip').toList()),
          _buildPostsList(
              _posts.where((post) => post['type'] == 'problem').toList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreatePostDialog,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildPostsList(List<Map<String, dynamic>> posts) {
    return RefreshIndicator(
      onRefresh: () async {
        // Simulate refresh
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return _buildPostCard(post);
        },
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    post['avatar'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post['author'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        post['time'],
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  _getPostTypeIcon(post['type']),
                  color: _getPostTypeColor(post['type']),
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Post Content
            Text(
              post['content'],
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 12),

            // Tags
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: (post['tags'] as List<String>).map((tag) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '#$tag',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),

            // Actions
            Row(
              children: [
                InkWell(
                  onTap: () => _toggleLike(post['id']),
                  child: Row(
                    children: [
                      const Icon(Icons.thumb_up_outlined, size: 20),
                      const SizedBox(width: 4),
                      Text('${post['likes']}'),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                InkWell(
                  onTap: () => _showCommentsDialog(post),
                  child: Row(
                    children: [
                      const Icon(Icons.comment_outlined, size: 20),
                      const SizedBox(width: 4),
                      Text('${post['comments']}'),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                InkWell(
                  onTap: () => _sharePost(post),
                  child: const Row(
                    children: [
                      Icon(Icons.share_outlined, size: 20),
                      SizedBox(width: 4),
                      Text('Share'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getPostTypeIcon(String type) {
    switch (type) {
      case 'tip':
        return Icons.lightbulb;
      case 'problem':
        return Icons.help;
      case 'question':
        return Icons.quiz;
      default:
        return Icons.post_add;
    }
  }

  Color _getPostTypeColor(String type) {
    switch (type) {
      case 'tip':
        return Colors.amber;
      case 'problem':
        return Colors.red;
      case 'question':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  void _toggleLike(int postId) {
    setState(() {
      final post = _posts.firstWhere((p) => p['id'] == postId);
      post['likes'] = post['likes'] + 1;
    });
  }

  void _showCommentsDialog(Map<String, dynamic> post) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Comments',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    _buildComment('PlantExpert', '2h ago',
                        'This looks like early blight. Try copper fungicide!'),
                    _buildComment('GardenGuru', '1h ago',
                        'I had the same issue last year. Good drainage helped.'),
                    _buildComment('TomatoLover', '30m ago',
                        'Thanks for sharing! Very helpful tips.'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComment(String author, String time, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.grey[300],
            child: Text(
              author[0],
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      author,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(content),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sharePost(Map<String, dynamic> post) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Post shared!')),
    );
  }

  void _showCreatePostDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create New Post',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _postController,
                maxLines: 6,
                decoration: const InputDecoration(
                  hintText: 'Share your tip, problem, or question...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Type: '),
                  DropdownButton<String>(
                    value: 'tip',
                    items: const [
                      DropdownMenuItem(value: 'tip', child: Text('Tip')),
                      DropdownMenuItem(
                          value: 'problem', child: Text('Problem')),
                      DropdownMenuItem(
                          value: 'question', child: Text('Question')),
                    ],
                    onChanged: (value) {},
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Post created!')),
                      );
                    },
                    child: const Text('Post'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
