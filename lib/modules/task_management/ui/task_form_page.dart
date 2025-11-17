import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/exports.dart';
import '../notifier/notifier.dart';

@RoutePage()
/// Unified page for adding or editing a task.
/// If [task] is null, it's in add mode. If [task] is provided, it's in edit mode.
class TaskFormPage extends ConsumerWidget {
  /// Creates a [TaskFormPage].
  /// [task] is optional - null for add mode, provided for edit mode.
  const TaskFormPage({this.task, super.key});

  /// The task to edit. If null, the page is in add mode.
  final TaskModel? task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TaskFormView(task: task);
  }
}

/// View widget for the task form.
class TaskFormView extends ConsumerStatefulWidget {
  /// Creates a [TaskFormView].
  const TaskFormView({this.task, super.key});

  /// The task to edit. If null, the page is in add mode.
  final TaskModel? task;

  @override
  ConsumerState<TaskFormView> createState() => _TaskFormViewState();
}

class _TaskFormViewState extends ConsumerState<TaskFormView> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late DateTime _selectedDate;
  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _isEditMode = widget.task != null;
    
    if (_isEditMode) {
      _titleController = TextEditingController(text: widget.task!.title);
      _descriptionController = TextEditingController(text: widget.task!.description);
      _selectedDate = widget.task!.dueDate;
    } else {
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
      _selectedDate = DateTime.now().add(const Duration(days: 1));
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: MainConfig.appColors.mainColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: MainConfig.appColors.mainColor,
              ),
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: Colors.white,
              titleTextStyle: context.textTheme.headlineMedium?.copyWith(
                color: Colors.black,
                fontSize: Dimens.fontSize20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDate),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: MainConfig.appColors.mainColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: MainConfig.appColors.mainColor,
              ),
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  Future<void> _saveTask() async {
    if (_formKey.currentState!.validate()) {
      final TaskNotifier notifier = ref.read(taskNotifierProvider.notifier);
      
      if (_isEditMode) {
        final TaskModel updatedTask = widget.task!.copyWith(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          dueDate: _selectedDate,
        );
        await notifier.updateTask(updatedTask);
      } else {
        final TaskModel newTask = TaskModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          dueDate: _selectedDate,
          createdAt: DateTime.now(),
        );
        await notifier.addTask(newTask);
      }

      if (mounted) {
        Navigator.of(context).pop(true); // Return true to indicate success
        displaySnackBar(
          _isEditMode ? 'Task updated successfully' : 'Task added successfully',
          context,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: CustomTextLabelWidget(
          label: _isEditMode ? 'Edit Task' : 'Add Task',
          textAlign: TextAlign.start,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimens.size16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Task Title *',
                  hintText: 'Enter task title',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a task title';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.sentences,
              ),
             const SizedBox(height: Dimens.size16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description *',
                  hintText: 'Enter task description',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: Dimens.maxLength4,
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a task description';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: Dimens.size16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.size16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const CustomTextLabelWidget(
                        label: 'Due Date & Time',
                        style: TextStyle(
                          fontSize: Dimens.fontSize16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: Dimens.space12),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _selectDate(context),
                              icon: const Icon(
                                  color: Colors.black,
                                  Icons.calendar_today),
                              label: CustomTextLabelWidget(
                                label: DateFormat('MMM dd, yyyy').format(_selectedDate),
                              ),
                            ),
                          ),
                          const SizedBox(width: Dimens.space12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _selectTime(context),
                              icon: const Icon(Icons.access_time),
                              label: CustomTextLabelWidget(
                                label: DateFormat('hh:mm a').format(_selectedDate),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Dimens.space24),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final TaskState state = ref.watch(taskNotifierProvider);
                  return CustomButtonWidget(
                    title: state.status == BaseStateStatus.loading
                        ? 'Please wait...'
                        : (_isEditMode ? 'Update Task' : 'Save Task'),
                    onTap: _saveTask,
                    isButtonEnabled: state.status != BaseStateStatus.loading,
                    icon: state.status == BaseStateStatus.loading
                        ? const SizedBox(
                            height: Dimens.size20,
                            width: Dimens.size20,
                            child: CircularProgressIndicator(
                              strokeWidth: Dimens.size2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : null,
                    titleTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: Dimens.fontSize16),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

