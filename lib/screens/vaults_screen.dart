import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value;
import '../main.dart';
import '../data/database.dart';
import '../widgets/app_drawer.dart';

class VaultsScreen extends StatefulWidget {
  const VaultsScreen({super.key});

  @override
  State<VaultsScreen> createState() => _VaultsScreenState();
}

class _VaultsScreenState extends State<VaultsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaults'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'Founder'), Tab(text: 'Knowledge')],
        ),
      ),
      drawer: const AppDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _VaultTab(vaultType: 'founder'),
          _VaultTab(vaultType: 'knowledge'),
        ],
      ),
    );
  }
}

class _VaultTab extends StatefulWidget {
  final String vaultType;
  const _VaultTab({required this.vaultType});

  @override
  State<_VaultTab> createState() => _VaultTabState();
}

class _VaultTabState extends State<_VaultTab> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _entryDialog(BuildContext context, {VaultEntry? existing}) {
    final titleController = TextEditingController(text: existing?.title ?? '');
    final contentController =
        TextEditingController(text: existing?.content ?? '');
    final tagsController = TextEditingController(text: existing?.tags ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(existing == null ? 'New entry' : 'Edit entry'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: contentController,
                maxLines: 6,
                decoration: const InputDecoration(labelText: 'Content'),
              ),
              TextField(
                controller: tagsController,
                decoration: const InputDecoration(
                    labelText: 'Tags (comma-separated)'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final title = titleController.text.trim();
              if (title.isEmpty) return;
              if (existing == null) {
                await db.addVaultEntry(VaultEntriesCompanion(
                  vaultType: Value(widget.vaultType),
                  title: Value(title),
                  content: Value(contentController.text.trim()),
                  tags: Value(tagsController.text.trim()),
                ));
              } else {
                await db.updateVaultEntry(existing.copyWith(
                  title: title,
                  content: contentController.text.trim(),
                  tags: tagsController.text.trim(),
                  updatedAt: DateTime.now(),
                ));
              }
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: Text(existing == null ? 'Add' : 'Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final stream = _query.isEmpty
        ? db.watchVaultEntries(widget.vaultType)
        : db.searchVaultEntries(widget.vaultType, _query);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'add_${widget.vaultType}',
        onPressed: () => _entryDialog(context),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search title, content, or tags',
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => setState(() => _query = val.trim()),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<VaultEntry>>(
              stream: stream,
              builder: (context, snapshot) {
                final entries = snapshot.data ?? [];
                if (entries.isEmpty) {
                  return Center(
                    child: Text(_query.isEmpty
                        ? 'No entries yet — add one'
                        : 'No matches for "$_query"'),
                  );
                }
                return ListView.builder(
                  itemCount: entries.length,
                  itemBuilder: (context, i) {
                    final e = entries[i];
                    final snippet = e.content.length > 100
                        ? '${e.content.substring(0, 100)}…'
                        : e.content;
                    return Dismissible(
                      key: ValueKey(e.id),
                      onDismissed: (_) => db.deleteVaultEntry(e.id),
                      background: Container(color: Colors.red),
                      child: ListTile(
                        title: Text(e.title),
                        subtitle: Text(
                          [
                            if (snippet.isNotEmpty) snippet,
                            if (e.tags.isNotEmpty) '🏷 ${e.tags}',
                          ].join('\n'),
                        ),
                        isThreeLine: e.tags.isNotEmpty,
                        onTap: () => _entryDialog(context, existing: e),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
