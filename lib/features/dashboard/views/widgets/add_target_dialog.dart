import 'package:flutter/material.dart';
import '../../models/target_model.dart';

class AddTargetDialog extends StatefulWidget {
  final List<TargetModel> availableTemplates;
  final Function(TargetModel) onTargetSelected;

  const AddTargetDialog({
    super.key,
    required this.availableTemplates,
    required this.onTargetSelected,
  });

  @override
  State<AddTargetDialog> createState() => _AddTargetDialogState();
}

class _AddTargetDialogState extends State<AddTargetDialog> {
  TargetModel? selectedTemplate;
  late TextEditingController titleController;
  late TextEditingController targetValueController;
  late TextEditingController unitController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    targetValueController = TextEditingController();
    unitController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    targetValueController.dispose();
    unitController.dispose();
    super.dispose();
  }

  void _selectTemplate(TargetModel template) {
    setState(() {
      selectedTemplate = template;
      titleController.text = template.title;
      targetValueController.text = template.targetValue.toInt().toString();
      unitController.text = template.unit;
    });
  }

  void _createTarget() {
    if (selectedTemplate == null) return;
    
    final targetValue = double.tryParse(targetValueController.text) ?? 0.0;
    if (targetValue <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid target value')),
      );
      return;
    }

    final newTarget = selectedTemplate!.copyWith(
      id: '',
      title: titleController.text.trim().isEmpty ? selectedTemplate!.title : titleController.text.trim(),
      targetValue: targetValue,
      unit: unitController.text.trim().isEmpty ? selectedTemplate!.unit : unitController.text.trim(),
      currentValue: 0.0,
      createdAt: DateTime.now(),
    );

    widget.onTargetSelected(newTarget);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add New Target',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Choose a habit template:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.5,
                ),
                itemCount: widget.availableTemplates.length,
                itemBuilder: (context, index) {
                  final template = widget.availableTemplates[index];
                  final isSelected = selectedTemplate?.id == template.id;
                  
                  return GestureDetector(
                    onTap: () => _selectTemplate(template),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected ? template.color.withOpacity(0.1) : Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? template.color : Colors.grey[300]!,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: template.color.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                template.emoji,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  template.title,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '${template.targetValue.toInt()} ${template.unit}',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (selectedTemplate != null) ...[
              const SizedBox(height: 20),
              const Text(
                'Customize your target:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter target title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: targetValueController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Target Value',
                        hintText: 'Enter target amount',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: unitController,
                      decoration: InputDecoration(
                        labelText: 'Unit',
                        hintText: 'e.g., glasses, steps',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _createTarget,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedTemplate!.color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Add ${selectedTemplate!.emoji} ${titleController.text.isEmpty ? selectedTemplate!.title : titleController.text}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
