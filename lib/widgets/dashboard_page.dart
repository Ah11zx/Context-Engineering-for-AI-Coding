import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../models/data_models.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<Reminder> _reminders = [
    Reminder(
      title: 'اجتماع فريق التطوير',
      description: 'مراجعة تقدم المشروع وتوزيع المهام الجديدة.',
      dateTime: DateTime.now().add(const Duration(hours: 3)),
    ),
    Reminder(
      title: 'تذكير شرب الماء',
      description: 'كوب ماء دافئ مع الليمون قبل الغداء.',
      dateTime: DateTime.now().add(const Duration(hours: 5)),
    ),
  ];

  final List<Note> _notes = [
    Note(
      title: 'ملخص أفكار المحتوى لهذا الأسبوع',
      content:
          '١. حملة تعريفية بالخدمات.
٢. فيديو قصير لنتائج التدريب.
٣. تصميم قوالب جاهزة للعيد.',
    ),
    Note(
      title: 'ملاحظات من مكالمة العميل',
      content:
          '• يريد صورًا مدمجة مع صورته الشخصية.
• التركيز على الألوان الخضراء والذهبية.
• إضافة خيار النشر السريع على الشبكات.',
    ),
  ];

  final List<MealPlan> _mealPlans = [
    MealPlan(
      day: 'الأحد',
      breakfast: 'شوفان بالفواكه والمكسرات',
      lunch: 'دجاج مشوي مع خضار سوتيه',
      dinner: 'سلطة كينوا مع حمص وأفوكادو',
      snack: 'تمر + شاي أخضر',
    ),
    MealPlan(
      day: 'الاثنين',
      breakfast: 'عصير أخضر + بيض مسلوق',
      lunch: 'سمك سلمون مشوي مع أرز بني',
      dinner: 'شوربة عدس وشرائح خبز أسمر',
      snack: 'زبادي يوناني بالعسل',
    ),
  ];

  final List<WorkoutRoutine> _workouts = [
    WorkoutRoutine(
      name: 'جلسة HIIT سريعة',
      focusArea: 'حرق الدهون وتحسين اللياقة',
      duration: '٢٠ دقيقة',
      description: '٤ جولات من تمارين عالية الشدة مع استراحة نشطة.',
    ),
    WorkoutRoutine(
      name: 'يوغا مسائية',
      focusArea: 'استرخاء ومرونة العضلات',
      duration: '٣٠ دقيقة',
      description: 'تسلسل حركات مهدئة مع تمارين تنفس عميق.',
    ),
  ];

  final List<TrainerTip> _tips = const [
    TrainerTip(
      title: 'ابدأ يومك بتمدد بسيط',
      detail: '٥ دقائق من التمدد تحسن الدورة الدموية وتزيد التركيز.',
      icon: Icons.self_improvement,
    ),
    TrainerTip(
      title: 'تغذية متوازنة',
      detail: 'احرص على وجود مصدر بروتين وخضار في كل وجبة رئيسية.',
      icon: Icons.restaurant_menu,
    ),
    TrainerTip(
      title: 'تنفس عميق',
      detail: 'تمرين تنفس ٤-٧-٨ يساعد على تخفيف التوتر بسرعة.',
      icon: Icons.air,
    ),
  ];

  late final List<TemplateAsset> _templates = [
    const TemplateAsset(
      id: 'template-hero-1',
      name: 'واجهة إعلانية لحملة تدريب',
      category: TemplateCategory.image,
      description: 'قالب صورة ١٠٨٠×١٣٥٠ مع مساحة لوضع صورة شخصية ونص متدرج.',
      accentColor: kPrimaryColor,
      icon: Icons.image_outlined,
      aspectRatio: 4 / 5,
    ),
    const TemplateAsset(
      id: 'template-story-1',
      name: 'قصة تفاعلية للإنستغرام',
      category: TemplateCategory.image,
      description: 'شرائح متتابعة مع توجيهات نصية وأزرار استفتاء.',
      accentColor: kAccentColor,
      icon: Icons.crop_portrait,
      aspectRatio: 9 / 16,
    ),
    const TemplateAsset(
      id: 'template-video-1',
      name: 'مقدمة فيديو تدريبية',
      category: TemplateCategory.video,
      description: 'مشهد افتتاحي مع طبقات نصية متحركة وموسيقى حماسية.',
      accentColor: kSecondaryColor,
      icon: Icons.video_camera_front_outlined,
      aspectRatio: 16 / 9,
    ),
    const TemplateAsset(
      id: 'template-video-2',
      name: 'شرح تمرين منزلي',
      category: TemplateCategory.video,
      description: 'تسلسل خطوات مرئية مع مساحة لإضافة صور المستخدم.',
      accentColor: kPrimaryColor,
      icon: Icons.video_collection_outlined,
      aspectRatio: 9 / 16,
    ),
    const TemplateAsset(
      id: 'template-audio-1',
      name: 'تأمل صباحي موجه',
      category: TemplateCategory.audio,
      description: 'قالب صوتي بإرشادات صوتية وخلفية موسيقية هادئة.',
      accentColor: kSuccessColor,
      icon: Icons.graphic_eq,
      aspectRatio: 1,
    ),
    const TemplateAsset(
      id: 'template-audio-2',
      name: 'رسالة صوتية تحفيزية',
      category: TemplateCategory.audio,
      description: 'هيكل جاهز مع نغمة خلفية ومساحة لتعليقات المدرب.',
      accentColor: kAccentColor,
      icon: Icons.volume_up_outlined,
      aspectRatio: 1,
    ),
  ];

  TemplateCategory _selectedCategory = TemplateCategory.image;
  TemplateAsset? _selectedTemplate;
  final TextEditingController _promptController = TextEditingController();
  final List<GeneratedContent> _generatedHistory = [];

  @override
  void initState() {
    super.initState();
    _selectedTemplate = _templates.firstWhere(
      (template) => template.category == _selectedCategory,
    );
  }

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return DateFormat('EEEE d MMMM، h:mm a', 'ar').format(date);
  }

  List<TemplateAsset> get _filteredTemplates => _templates
      .where((template) => template.category == _selectedCategory)
      .toList(growable: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('فَنَان - مساعدك الشخصي بالعربية'),
        actions: [
          IconButton(
            tooltip: 'تفعيل الوضع الليلي',
            onPressed: () {},
            icon: const Icon(Icons.dark_mode_outlined),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final columns = width >= 1280
              ? 3
              : width >= 900
                  ? 2
                  : 1;
          final spacing = kSpacing;
          final contentWidth = width - (kSpacing * 2);
          final effectiveContentWidth = contentWidth > 0 ? contentWidth : width;
          final availableWidth =
              effectiveContentWidth - (spacing * (columns - 1));
          final cardWidth = columns == 1
              ? effectiveContentWidth
              : availableWidth / columns;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(kSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildWelcomeHeader(),
                const SizedBox(height: kSpacing),
                Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  alignment: WrapAlignment.start,
                  children: [
                    SizedBox(
                      width: cardWidth,
                      child: _buildRemindersCard(),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: _buildNotesCard(),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: _buildMealPlannerCard(),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: _buildWorkoutCard(),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: _buildTrainerTipsCard(),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: _buildTemplatesCard(),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: _buildGeneratorCard(),
                    ),
                  ],
                ),
                const SizedBox(height: kSpacing),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Container(
      padding: const EdgeInsets.all(kSpacing),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kPrimaryColor.withOpacity(0.12), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: kPrimaryColor,
                  size: 34,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مرحبًا بك 👋',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'اجعل تنظيم يومك وإنتاج محتواك المتكامل أسهل من أي وقت مضى. كل شيء جاهز باللغة العربية وبتجربة سلسة.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: kTextColor.withOpacity(0.8)),
                    ),
                  ],
                ),
              ),
              FilledButton.icon(
                onPressed: _openDailyFocusDialog,
                icon: const Icon(Icons.flag),
                label: const Text('وضع تركيز اليوم'),
              ),
            ],
          ),
          const SizedBox(height: kSpacing),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildQuickStatChip(
                icon: Icons.event_available,
                label: 'التذكيرات النشطة',
                value: _reminders
                    .where((reminder) => !reminder.isCompleted)
                    .length
                    .toString(),
              ),
              _buildQuickStatChip(
                icon: Icons.menu_book_outlined,
                label: 'ملاحظات اليوم',
                value: _notes.length.toString(),
              ),
              _buildQuickStatChip(
                icon: Icons.restaurant,
                label: 'خطة الوجبات',
                value: '${_mealPlans.length} أيام',
              ),
              _buildQuickStatChip(
                icon: Icons.fitness_center,
                label: 'جلسات التدريب',
                value: '${_workouts.length}',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatChip({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Chip(
      avatar: CircleAvatar(
        backgroundColor: kPrimaryColor.withOpacity(0.12),
        child: Icon(icon, color: kPrimaryColor, size: 18),
      ),
      label: Text('$label: $value'),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required String subtitle,
    List<Widget>? actions,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: kTextColor.withOpacity(0.7)),
                ),
              ],
            ),
          ),
          if (actions != null) ...actions,
        ],
      ),
    );
  }

  Widget _buildRemindersCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              title: 'التذكيرات الذكية',
              subtitle: 'تابع مواعيدك اليومية بسهولة مع إشعارات عربية واضحة.',
              actions: [
                OutlinedButton.icon(
                  onPressed: _openAddReminderDialog,
                  icon: const Icon(Icons.add_alert_outlined),
                  label: const Text('إضافة تذكير'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final reminder = _reminders[index];
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: reminder.isCompleted
                        ? kSuccessColor.withOpacity(0.08)
                        : kBackgroundColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: reminder.isCompleted
                          ? kSuccessColor.withOpacity(0.4)
                          : kPrimaryColor.withOpacity(0.1),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: reminder.isCompleted,
                        activeColor: kSuccessColor,
                        onChanged: (_) => _toggleReminder(index),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reminder.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    decoration: reminder.isCompleted
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              reminder.description,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: kTextColor.withOpacity(0.7),
                                  ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 16,
                                  color: kTextColor.withOpacity(0.6),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  _formatDate(reminder.dateTime),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: kTextColor.withOpacity(0.6),
                                        fontWeight: FontWeight.w600,
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
              },
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemCount: _reminders.length,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              title: 'دفتر الملاحظات',
              subtitle: 'دون أفكارك ومهام المحتوى السريع مع دعم كامل للغة العربية.',
              actions: [
                OutlinedButton.icon(
                  onPressed: _openAddNoteDialog,
                  icon: const Icon(Icons.note_add_outlined),
                  label: const Text('ملاحظة جديدة'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final note = _notes[index];
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: kPrimaryColor.withOpacity(0.1), width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.push_pin, color: kSecondaryColor, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              note.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        note.content,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(height: 1.6),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: Text(
                          DateFormat('d MMMM، h:mm a', 'ar').format(note.createdAt),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: kTextColor.withOpacity(0.6)),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemCount: _notes.length,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealPlannerCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              title: 'مخطط الوجبات',
              subtitle: 'خطط أسبوعك الغذائي مع اقتراحات متوازنة ومكونات عربية.',
              actions: [
                IconButton(
                  onPressed: () => _showMealSuggestions(context),
                  icon: const Icon(Icons.auto_awesome_motion),
                  tooltip: 'اقتراح خطة آلية',
                ),
              ],
            ),
            const SizedBox(height: 12),
            ..._mealPlans.map(
              (plan) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: kSecondaryColor.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: kSecondaryColor, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          plan.day,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _buildMealRow('الإفطار', plan.breakfast),
                    _buildMealRow('الغداء', plan.lunch),
                    _buildMealRow('العشاء', plan.dinner),
                    if (plan.snack != null)
                      _buildMealRow('وجبة خفيفة', plan.snack!),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: kTextColor.withOpacity(0.8)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              title: 'برنامج التمارين',
              subtitle: 'تابع تدريباتك اليومية مع مدربك الشخصي الافتراضي.',
              actions: [
                OutlinedButton.icon(
                  onPressed: _openAddWorkoutDialog,
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('جلسة جديدة'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _workouts.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final workout = _workouts[index];
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: LinearGradient(
                      colors: [
                        kPrimaryColor.withOpacity(0.08),
                        Colors.white,
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    border: Border.all(
                      color: workout.completed
                          ? kSuccessColor.withOpacity(0.5)
                          : kPrimaryColor.withOpacity(0.2),
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.fitness_center, color: kPrimaryColor),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              workout.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                          Switch.adaptive(
                            value: workout.completed,
                            activeColor: kSuccessColor,
                            onChanged: (_) => _toggleWorkout(index),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 10,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Chip(
                            avatar: const Icon(Icons.timer, size: 18),
                            label: Text(workout.duration),
                          ),
                          Chip(
                            avatar: const Icon(Icons.track_changes, size: 18),
                            label: Text(workout.focusArea),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        workout.description,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(height: 1.6),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrainerTipsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              title: 'المدرب الذكي',
              subtitle: 'إرشادات يومية سريعة لتحسين نمط حياتك ورفع نشاطك.',
            ),
            const SizedBox(height: 12),
            ..._tips.map(
              (tip) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: kPrimaryColor.withOpacity(0.2)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(tip.icon ?? Icons.bolt, color: kPrimaryColor),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tip.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            tip.detail,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(height: 1.6),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _openTrainerChatDialog,
              icon: const Icon(Icons.chat_bubble_outline),
              label: const Text('ابدأ جلسة استشارة سريعة'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplatesCard() {
    final filtered = _filteredTemplates;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              title: 'معرض القوالب الذكية',
              subtitle:
                  'اختَر قالبًا وادمج صورتك الشخصية أو محتوى فيديو وصوت مع أدوات الذكاء الاصطناعي.',
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: TemplateCategory.values.map((category) {
                  final isSelected = _selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8),
                    child: ChoiceChip(
                      selected: isSelected,
                      label: Text(templateCategoryLabel(category)),
                      avatar: Icon(
                        category == TemplateCategory.image
                            ? Icons.photo_library_outlined
                            : category == TemplateCategory.video
                                ? Icons.video_library_outlined
                                : Icons.library_music_outlined,
                      ),
                      onSelected: (_) {
                        setState(() {
                          _selectedCategory = category;
                          final options = _filteredTemplates;
                          _selectedTemplate = options.isNotEmpty ? options.first : null;
                        });
                      },
                      selectedColor: kPrimaryColor,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : kTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filtered.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.3,
              ),
              itemBuilder: (context, index) {
                final template = filtered[index];
                final isActive = _selectedTemplate?.id == template.id;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTemplate = template;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isActive
                            ? kPrimaryColor
                            : template.accentColor.withOpacity(0.35),
                        width: 2,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          template.accentColor.withOpacity(0.18),
                          Colors.white,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: template.accentColor.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Icon(template.icon, color: template.accentColor),
                            ),
                            const Spacer(),
                            IconButton(
                              tooltip: 'رفع صورة شخصية',
                              onPressed: () => _showUploadDialog(template),
                              icon: const Icon(Icons.upload_file_outlined),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          template.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 6),
                        Expanded(
                          child: Text(
                            template.description,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(height: 1.6),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: AlignmentDirectional.bottomStart,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: template.accentColor.withOpacity(0.18),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'نسبة العرض: ${template.aspectRatio.toStringAsFixed(2)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneratorCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              title: 'مولد المحتوى الذكي',
              subtitle:
                  'اكتب وصفك ودع الذكاء الاصطناعي يبني صورة أو فيديو أو مقطعًا صوتيًا باستخدام القوالب المختارة.',
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<TemplateCategory>(
              value: _selectedCategory,
              decoration: const InputDecoration(labelText: 'نوع المحتوى'),
              items: TemplateCategory.values
                  .map(
                    (category) => DropdownMenuItem(
                      value: category,
                      child: Text(templateCategoryLabel(category)),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _selectedCategory = value;
                  final options = _filteredTemplates;
                  _selectedTemplate = options.isNotEmpty ? options.first : null;
                });
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<TemplateAsset>(
              value: _selectedTemplate,
              decoration: const InputDecoration(labelText: 'القالب المختار'),
              items: _filteredTemplates
                  .map(
                    (template) => DropdownMenuItem(
                      value: template,
                      child: Text(template.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() => _selectedTemplate = value);
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _promptController,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'وصف المحتوى أو النص المطلوب',
                hintText: 'مثال: قصة مصورة لتحفيز المتابعين على بدء تدريب منزلي...',
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _generateContent,
                    icon: const Icon(Icons.auto_awesome),
                    label: const Text('إنشاء المحتوى'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _showTemplatesPreview,
                    icon: const Icon(Icons.visibility_outlined),
                    label: const Text('معاينة القوالب'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Divider(color: kTextColor.withOpacity(0.1)),
            const SizedBox(height: 16),
            Text(
              'سجل المحتوى المُنشأ',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (_generatedHistory.isEmpty)
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: kPrimaryColor.withOpacity(0.08)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.hourglass_empty, color: kPrimaryColor, size: 36),
                    const SizedBox(height: 12),
                    Text(
                      'لم يتم إنشاء محتوى بعد. ابدأ الآن بتوليد أول فكرة!',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: kTextColor.withOpacity(0.7)),
                    ),
                  ],
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _generatedHistory.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = _generatedHistory[index];
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: kPrimaryColor.withOpacity(0.1)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              item.category == TemplateCategory.image
                                  ? Icons.photo
                                  : item.category == TemplateCategory.video
                                      ? Icons.movie
                                      : Icons.graphic_eq,
                              color: kPrimaryColor,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                item.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                            Text(
                              DateFormat('d MMMM، h:mm a', 'ar')
                                  .format(item.timestamp),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: kTextColor.withOpacity(0.6)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item.prompt,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(height: 1.6),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  void _toggleReminder(int index) {
    setState(() {
      _reminders[index].isCompleted = !_reminders[index].isCompleted;
    });
  }

  Future<void> _openAddReminderDialog() async {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    DateTime? selectedDate;

    await showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('إضافة تذكير جديد'),
              content: SizedBox(
                width: 420,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'عنوان التذكير'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: descriptionController,
                      minLines: 2,
                      maxLines: 3,
                      decoration:
                          const InputDecoration(labelText: 'التفاصيل أو الملاحظات'),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: () async {
                        final now = DateTime.now();
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedDate ?? now,
                          firstDate: now,
                          lastDate: DateTime(now.year + 1),
                          locale: const Locale('ar'),
                        );
                        if (pickedDate == null) return;
                        final pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(selectedDate ?? now),
                        );
                        if (pickedTime == null) return;
                        setDialogState(() {
                          selectedDate = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                        });
                      },
                      icon: const Icon(Icons.access_time),
                      label: Text(
                        selectedDate == null
                            ? 'اختيار التاريخ والوقت'
                            : _formatDate(selectedDate!),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('إلغاء'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.trim().isEmpty || selectedDate == null) {
                      return;
                    }
                    setState(() {
                      _reminders.add(
                        Reminder(
                          title: titleController.text.trim(),
                          description: descriptionController.text.trim(),
                          dateTime: selectedDate!,
                        ),
                      );
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('حفظ التذكير'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _openAddNoteDialog() async {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('ملاحظة جديدة'),
          content: SizedBox(
            width: 420,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'عنوان الملاحظة'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: contentController,
                  minLines: 4,
                  maxLines: 8,
                  decoration: const InputDecoration(labelText: 'النص الكامل'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.trim().isEmpty ||
                    contentController.text.trim().isEmpty) {
                  return;
                }
                setState(() {
                  _notes.add(
                    Note(
                      title: titleController.text.trim(),
                      content: contentController.text.trim(),
                    ),
                  );
                });
                Navigator.pop(context);
              },
              child: const Text('إضافة'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _openAddWorkoutDialog() async {
    final nameController = TextEditingController();
    final focusController = TextEditingController();
    final durationController = TextEditingController();
    final descriptionController = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('جلسة تدريب جديدة'),
          content: SizedBox(
            width: 420,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'اسم الجلسة'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: focusController,
                  decoration: const InputDecoration(labelText: 'منطقة التركيز'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: durationController,
                  decoration: const InputDecoration(labelText: 'المدة (مثال: ٣٠ دقيقة)'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descriptionController,
                  minLines: 3,
                  maxLines: 6,
                  decoration: const InputDecoration(labelText: 'تفاصيل التمرين'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.trim().isEmpty ||
                    focusController.text.trim().isEmpty ||
                    durationController.text.trim().isEmpty) {
                  return;
                }
                setState(() {
                  _workouts.add(
                    WorkoutRoutine(
                      name: nameController.text.trim(),
                      focusArea: focusController.text.trim(),
                      duration: durationController.text.trim(),
                      description: descriptionController.text.trim(),
                    ),
                  );
                });
                Navigator.pop(context);
              },
              child: const Text('حفظ'),
            ),
          ],
        );
      },
    );
  }

  void _toggleWorkout(int index) {
    setState(() {
      _workouts[index].completed = !_workouts[index].completed;
    });
  }

  void _generateContent() {
    if (_promptController.text.trim().isEmpty || _selectedTemplate == null) {
      return;
    }
    final template = _selectedTemplate!;
    setState(() {
      _generatedHistory.insert(
        0,
        GeneratedContent(
          title: '${template.name} - ${DateFormat('jm', 'ar').format(DateTime.now())}',
          category: template.category,
          prompt: _promptController.text.trim(),
          timestamp: DateTime.now(),
        ),
      );
      _promptController.clear();
    });
  }

  void _openDailyFocusDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('وضع تركيز اليوم'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('حدّد أهم ثلاثة أهداف لليوم:'),
              SizedBox(height: 12),
              Text('١. إعداد ٣ تصاميم للانستغرام باستخدام القوالب الجاهزة.'),
              Text('٢. تسجيل جلسة فيديو تدريب منزلي مدتها ١٥ دقيقة.'),
              Text('٣. إرسال رسائل صوتية تحفيزية للمشتركين الجدد.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إغلاق'),
            ),
          ],
        );
      },
    );
  }

  void _showMealSuggestions(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('اقتراح خطة غذائية'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('اقتراح اليوم:'),
              SizedBox(height: 8),
              Text('• الإفطار: توست حبّة كاملة مع زبدة الفستق والموز.'),
              Text('• الغداء: معكرونة قمح كامل مع صوص البيستو والدجاج.'),
              Text('• العشاء: سلطة تونة متوسطية مع زيت الزيتون.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('تم'),
            ),
          ],
        );
      },
    );
  }

  void _showUploadDialog(TemplateAsset template) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('رفع صورة إلى "${template.name}"'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('قم بسحب الصورة أو اخترها من جهازك ليتم دمجها داخل القالب تلقائيًا.'),
              SizedBox(height: 10),
              Text('يدعم النظام ملفات JPG وPNG بدقة عالية.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('رجوع'),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.file_upload_outlined),
              label: const Text('اختيار ملف'),
            ),
          ],
        );
      },
    );
  }

  void _showTemplatesPreview() {
    if (_selectedTemplate == null) return;
    final template = _selectedTemplate!;
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('معاينة: ${template.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: template.aspectRatio,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: LinearGradient(
                      colors: [
                        template.accentColor.withOpacity(0.3),
                        Colors.white,
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'منطقة المعاينة',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                template.description,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(height: 1.6),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إغلاق'),
            ),
          ],
        );
      },
    );
  }

  void _openTrainerChatDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('جلسة استشارة سريعة'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                minLines: 3,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'ما الهدف الذي ترغب في تحقيقه هذا الأسبوع؟',
                  hintText: 'مثال: زيادة اللياقة القلبية أو الالتزام بخطة غذائية...',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'كيف يمكن للمساعد دعمك؟',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إرسال الطلب'),
            ),
          ],
        );
      },
    );
  }
}
