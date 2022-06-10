import 'package:flutter/material.dart';
import 'package:job_timer/app/view_models/project_model.dart';

class ProjectTile extends StatelessWidget {
  final ProjectModel projectModel;
  const ProjectTile({super.key, required this.projectModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 90),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 4,
        ),
      ),
      child: Column(
        children: [_ProjectName(projectModel: projectModel)],
      ),
    );
  }
}

class _ProjectName extends StatelessWidget {
  final ProjectModel projectModel;
  const _ProjectName({super.key, required this.projectModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(projectModel.name),
      ],
    );
  }
}
