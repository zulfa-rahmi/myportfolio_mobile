import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

/// Halaman formulir untuk menambahkan Pengalaman ke portofolio.
///
/// Field mengikuti model Pengalaman: posisi, organisasi, tipe, tanggal mulai,
/// tanggal selesai (atau masih berlangsung), deskripsi, dan tautan bukti.
class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  static const String _defaultType = 'Kepanitiaan';
  static const int _maxTitleLength = 100;
  static const int _minDescriptionLength = 10;
  static const int _maxDescriptionLength = 500;

  final _formKey = GlobalKey<FormState>();
  final _endDateKey = GlobalKey<FormFieldState<DateTime>>();

  final _positionController = TextEditingController();
  final _organizationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _linkController = TextEditingController();

  String _type = _defaultType;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrent = false;

  // Dinaikkan setiap form di-reset agar dropdown dibangun ulang dengan nilai awal.
  int _resetCount = 0;

  final List<String> _types = [
    'Kepanitiaan',
    'Organisasi',
    'Magang',
    'Pekerjaan',
    'Freelance',
    'Lainnya',
  ];

  @override
  void dispose() {
    _positionController.dispose();
    _organizationController.dispose();
    _descriptionController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Helper
  // ---------------------------------------------------------------------------

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  /// Validator untuk isian teks wajib: tidak boleh kosong/hanya spasi dan
  /// tidak boleh melebihi [maxLength].
  String? _validateRequiredText(String? value, String label, int maxLength) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return '$label tidak boleh kosong!';
    }
    if (text.length > maxLength) {
      return '$label maksimal $maxLength karakter!';
    }
    return null;
  }

  String? _validateDescription(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Deskripsi tidak boleh kosong!';
    }
    if (text.length < _minDescriptionLength) {
      return 'Deskripsi minimal $_minDescriptionLength karakter!';
    }
    if (text.length > _maxDescriptionLength) {
      return 'Deskripsi maksimal $_maxDescriptionLength karakter!';
    }
    return null;
  }

  /// Tautan bersifat opsional, tetapi jika diisi harus berupa URL http/https.
  String? _validateLink(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return null;
    }
    final uri = Uri.tryParse(text);
    final isValid = uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.contains('.');
    if (!isValid) {
      return 'URL tidak valid! Contoh: https://github.com/username';
    }
    return null;
  }

  Future<void> _pickDate({
    required DateTime? current,
    required DateTime firstDate,
    required ValueChanged<DateTime> onPicked,
    required FormFieldState<DateTime> fieldState,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: current ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: DateTime(2035),
    );
    if (!mounted || picked == null) {
      return;
    }
    setState(() => onPicked(picked));
    fieldState.didChange(picked);
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _positionController.clear();
    _organizationController.clear();
    _descriptionController.clear();
    _linkController.clear();
    setState(() {
      _type = _defaultType;
      _startDate = null;
      _endDate = null;
      _isCurrent = false;
      _resetCount++;
    });
  }

  Future<void> _saveExperience() async {
    // Dialog hanya muncul jika seluruh input lolos validasi.
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final link = _linkController.text.trim();

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pengalaman berhasil ditambahkan!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSummaryRow('Posisi', _positionController.text.trim()),
                _buildSummaryRow(
                    'Organisasi', _organizationController.text.trim()),
                _buildSummaryRow('Tipe', _type),
                _buildSummaryRow('Mulai', _formatDate(_startDate!)),
                _buildSummaryRow(
                  'Selesai',
                  _isCurrent ? 'Masih berlangsung' : _formatDate(_endDate!),
                ),
                _buildSummaryRow(
                    'Deskripsi', _descriptionController.text.trim()),
                _buildSummaryRow('Tautan', link.isEmpty ? '-' : link),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Tutup'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );

    // Setelah dialog ditutup, kembali ke formulir yang sudah bersih.
    if (!mounted) {
      return;
    }
    _resetForm();
  }

  // ---------------------------------------------------------------------------
  // Widget builder
  // ---------------------------------------------------------------------------

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  InputDecoration _decoration({
    required String label,
    String? hint,
    IconData? icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: icon == null ? null : Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? value,
    required String? Function(DateTime?) validator,
    required VoidCallback? Function(FormFieldState<DateTime>) onTapBuilder,
    Key? fieldKey,
    bool enabled = true,
    String? disabledText,
  }) {
    return FormField<DateTime>(
      key: fieldKey,
      validator: validator,
      builder: (state) {
        final text = !enabled
            ? (disabledText ?? '-')
            : (value == null ? 'Pilih tanggal' : _formatDate(value));
        return InkWell(
          onTap: enabled ? onTapBuilder(state) : null,
          child: InputDecorator(
            decoration: _decoration(
              label: label,
              icon: Icons.calendar_today,
            ).copyWith(
              errorText: state.errorText,
              enabled: enabled,
            ),
            child: Text(text),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Add Experience Form'),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      // SingleChildScrollView menjaga seluruh field dan tombol Simpan tetap
      // dapat dijangkau pada layar sempit maupun saat papan ketik tampil.
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Posisi ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _positionController,
                  textInputAction: TextInputAction.next,
                  decoration: _decoration(
                    label: 'Posisi / Peran',
                    hint: 'Contoh: Staff Business Development',
                    icon: Icons.badge_outlined,
                  ),
                  validator: (value) => _validateRequiredText(
                      value, 'Posisi', _maxTitleLength),
                ),
              ),

              // === Organisasi ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _organizationController,
                  textInputAction: TextInputAction.next,
                  decoration: _decoration(
                    label: 'Organisasi / Perusahaan',
                    hint: 'Contoh: Open House Fasilkom UI',
                    icon: Icons.business_outlined,
                  ),
                  validator: (value) => _validateRequiredText(
                      value, 'Organisasi', _maxTitleLength),
                ),
              ),

              // === Tipe ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  key: ValueKey('type-$_resetCount'),
                  decoration: _decoration(
                    label: 'Tipe Pengalaman',
                    icon: Icons.category_outlined,
                  ),
                  initialValue: _type,
                  items: _types
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _type = newValue!;
                    });
                  },
                ),
              ),

              // === Tanggal Mulai ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildDateField(
                  label: 'Tanggal Mulai',
                  value: _startDate,
                  validator: (_) =>
                      _startDate == null ? 'Tanggal mulai wajib dipilih!' : null,
                  onTapBuilder: (state) => () => _pickDate(
                        current: _startDate,
                        firstDate: DateTime(2015),
                        onPicked: (d) => _startDate = d,
                        fieldState: state,
                      ),
                ),
              ),

              // === Masih berlangsung ===
              SwitchListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                title: const Text('Masih berlangsung'),
                value: _isCurrent,
                onChanged: (bool value) {
                  setState(() {
                    _isCurrent = value;
                    _endDate = null;
                  });
                  _endDateKey.currentState?.reset();
                },
              ),

              // === Tanggal Selesai ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildDateField(
                  fieldKey: _endDateKey,
                  label: 'Tanggal Selesai',
                  value: _endDate,
                  enabled: !_isCurrent,
                  disabledText: 'Masih berlangsung',
                  validator: (_) {
                    if (_isCurrent) {
                      return null;
                    }
                    if (_endDate == null) {
                      return 'Tanggal selesai wajib dipilih!';
                    }
                    if (_startDate != null && _endDate!.isBefore(_startDate!)) {
                      return 'Tanggal selesai tidak boleh sebelum tanggal mulai!';
                    }
                    return null;
                  },
                  onTapBuilder: (state) => () => _pickDate(
                        current: _endDate ?? _startDate,
                        firstDate: _startDate ?? DateTime(2015),
                        onPicked: (d) => _endDate = d,
                        fieldState: state,
                      ),
                ),
              ),

              // === Deskripsi ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  maxLength: _maxDescriptionLength,
                  keyboardType: TextInputType.multiline,
                  decoration: _decoration(
                    label: 'Deskripsi',
                    hint: 'Ceritakan tanggung jawab dan pencapaianmu',
                  ).copyWith(alignLabelWithHint: true),
                  validator: _validateDescription,
                ),
              ),

              // === Tautan ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _linkController,
                  keyboardType: TextInputType.url,
                  decoration: _decoration(
                    label: 'Tautan Bukti (opsional)',
                    hint: 'https://...',
                    icon: Icons.link,
                  ),
                  validator: _validateLink,
                ),
              ),

              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: _saveExperience,
                    child: const Text(
                      'Simpan',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
