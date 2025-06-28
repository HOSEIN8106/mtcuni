import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:intl/intl.dart' as intl;

Future<String?> showPersianDateTimePickerFormatted({
  required BuildContext context,
  Jalali? initialDate,
}) async {
  initialDate ??= Jalali.now();

  final Jalali? pickedJalali = await showPersianDatePicker(
    locale: Locale('fa','IR'),
    context: context,
    initialDate: initialDate,
    firstDate: Jalali(1300, 1),
    lastDate: Jalali(1450, 12),
  );

  if (pickedJalali == null) return null;

  if (!context.mounted) return null;

  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(alwaysUse24HourFormat: true),
          child: child!,
        ),
      );
    },
  );

  final DateTime gregorianDate = pickedJalali.toDateTime();

  final DateTime finalDateTime = pickedTime == null
      ? gregorianDate
      : DateTime(
    gregorianDate.year,
    gregorianDate.month,
    gregorianDate.day,
    pickedTime.hour,
    pickedTime.minute,
  );

  return formatDateTime(finalDateTime);
}

String formatDateTime(DateTime dateTime) {
  final formatter = intl.DateFormat('yyyy-MM-dd HH:mm:ss');
  return formatter.format(dateTime);
}

String formatGregorianToPersian(String dateTimeStr) {
  try {
    // تبدیل رشته به DateTime
    final DateTime dateTime = intl.DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTimeStr);

    // تبدیل به تاریخ شمسی
    final Jalali jalali = Jalali.fromDateTime(dateTime);

    // فرمت خروجی مثلاً: 1403/10/10 - 23:59
    final f = '${jalali.year}/${jalali.month.toString().padLeft(2, '0')}/${jalali.day.toString().padLeft(2, '0')}'
        ' - ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

    return f;
  } catch (e) {
    return '';
  }
}

