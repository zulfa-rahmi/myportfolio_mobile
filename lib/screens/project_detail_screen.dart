import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Project Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (project.projectImageUrl.isNotEmpty) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  project.projectImageUrl,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const SizedBox(
                    height: 120,
                    child: Center(child: Text('Unable to load project image.')),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            Text(
              project.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            _DetailItem(label: 'Event', value: project.event),
            _DetailItem(label: 'Year', value: project.year.toString()),
            _DetailItem(label: 'Description', value: project.description),
            _DetailItem(label: 'Project URL', value: project.projectUrl),
            _DetailItem(label: 'Cover Image', value: project.coverImage),
            _DetailItem(label: 'Stars', value: project.starCount.toString()),
            _DetailItem(label: 'Starred By', value: project.starredByNames),
            if (project.id != null)
              _DetailItem(label: 'Project ID', value: project.id!),
          ],
        ),
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  const _DetailItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          SelectableText(value.isEmpty ? '-' : value),
        ],
      ),
    );
  }
}
