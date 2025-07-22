import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Map<String, dynamic> _userProfile = {
    'name': 'Sarah Johnson',
    'email': 'sarah.j@email.com',
    'location': 'San Francisco, CA',
    'joinDate': 'March 2024',
    'avatar': 'S',
    'gardenSize': '500 sq ft',
    'experienceLevel': 'Intermediate',
    'specialties': ['Tomatoes', 'Herbs', 'Peppers'],
  };

  final List<Map<String, dynamic>> _myPosts = [
    {
      'title': 'Natural Pesticide Recipe',
      'type': 'tip',
      'date': '2 days ago',
      'likes': 23,
      'comments': 5,
    },
    {
      'title': 'Companion Planting Success',
      'type': 'success',
      'date': '1 week ago',
      'likes': 31,
      'comments': 8,
    },
    {
      'title': 'Tomato Disease Help',
      'type': 'question',
      'date': '2 weeks ago',
      'likes': 12,
      'comments': 15,
    },
  ];

  final List<Map<String, dynamic>> _gardenStats = [
    {
      'title': 'Plants Scanned',
      'value': '47',
      'icon': Icons.camera_alt,
      'color': Colors.blue,
    },
    {
      'title': 'Diseases Detected',
      'value': '12',
      'icon': Icons.bug_report,
      'color': Colors.red,
    },
    {
      'title': 'Tips Shared',
      'value': '8',
      'icon': Icons.lightbulb,
      'color': Colors.orange,
    },
    {
      'title': 'Community Helps',
      'value': '23',
      'icon': Icons.people,
      'color': Colors.green,
    },
  ];

  final List<Map<String, dynamic>> _achievements = [
    {
      'title': 'Plant Doctor',
      'description': 'Helped identify 10+ diseases',
      'icon': Icons.healing,
      'earned': true,
    },
    {
      'title': 'Community Helper',
      'description': 'Received 50+ likes on tips',
      'icon': Icons.favorite,
      'earned': true,
    },
    {
      'title': 'Green Thumb',
      'description': 'Shared 20+ successful tips',
      'icon': Icons.eco,
      'earned': false,
    },
    {
      'title': 'Weather Watcher',
      'description': 'Used weather advice 30+ times',
      'icon': Icons.cloud,
      'earned': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showSettingsDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            _buildProfileHeader(),
            const SizedBox(height: 24),

            // Garden Stats
            _buildGardenStats(),
            const SizedBox(height: 24),

            // My Posts
            _buildMyPostsSection(),
            const SizedBox(height: 24),

            // Achievements
            _buildAchievementsSection(),
            const SizedBox(height: 24),

            // Garden Journal
            _buildGardenJournalSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    _userProfile['avatar'],
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _userProfile['name'],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _userProfile['email'],
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            _userProfile['location'],
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: _editProfile,
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildProfileInfo('Garden Size', _userProfile['gardenSize']),
                ),
                Expanded(
                  child: _buildProfileInfo('Experience', _userProfile['experienceLevel']),
                ),
                Expanded(
                  child: _buildProfileInfo('Member Since', _userProfile['joinDate']),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Specialties',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: (_userProfile['specialties'] as List<String>).map((specialty) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3)),
                      ),
                      child: Text(
                        specialty,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildGardenStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Garden Statistics',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(_gardenStats[0]),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(_gardenStats[1]),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(_gardenStats[2]),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(_gardenStats[3]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              stat['icon'],
              size: 32,
              color: stat['color'],
            ),
            const SizedBox(height: 8),
            Text(
              stat['value'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              stat['title'],
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyPostsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'My Posts',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ..._myPosts.map((post) => _buildPostCard(post)),
      ],
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getPostTypeColor(post['type']),
          child: Icon(
            _getPostTypeIcon(post['type']),
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Text(post['title']),
        subtitle: Text(post['date']),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.thumb_up, size: 14),
                const SizedBox(width: 4),
                Text('${post['likes']}'),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.comment, size: 14),
                const SizedBox(width: 4),
                Text('${post['comments']}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Achievements',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _achievements.length,
          itemBuilder: (context, index) {
            final achievement = _achievements[index];
            return Card(
              color: achievement['earned'] ? null : Colors.grey.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      achievement['icon'],
                      size: 32,
                      color: achievement['earned'] 
                          ? Theme.of(context).primaryColor 
                          : Colors.grey,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      achievement['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: achievement['earned'] ? null : Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      achievement['description'],
                      style: TextStyle(
                        fontSize: 10,
                        color: achievement['earned'] ? Colors.grey[600] : Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildGardenJournalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Garden Journal',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton.icon(
              onPressed: _addJournalEntry,
              icon: const Icon(Icons.add),
              label: const Text('Add Entry'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: const Icon(Icons.note, color: Colors.blue),
            title: const Text('Tomato Harvest'),
            subtitle: const Text('Great yield this season! Notes on care...'),
            trailing: const Text('July 15'),
            onTap: () {},
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.note, color: Colors.green),
            title: const Text('Pest Treatment'),
            subtitle: const Text('Applied neem oil solution to affected plants...'),
            trailing: const Text('July 10'),
            onTap: () {},
          ),
        ),
      ],
    );
  }

  IconData _getPostTypeIcon(String type) {
    switch (type) {
      case 'tip':
        return Icons.lightbulb;
      case 'success':
        return Icons.check_circle;
      case 'question':
        return Icons.help;
      default:
        return Icons.post_add;
    }
  }

  Color _getPostTypeColor(String type) {
    switch (type) {
      case 'tip':
        return Colors.orange;
      case 'success':
        return Colors.green;
      case 'question':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              trailing: Switch(
                value: true,
                onChanged: (value) {},
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: false,
                onChanged: (value) {},
              ),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              trailing: const Text('English'),
              onTap: () {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _addJournalEntry() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Journal Entry'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Journal entry added!')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
