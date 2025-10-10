import 'dart:io';
import 'package:clock_mate/features/home/data/models/day.dart';
import 'package:excel/excel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class FileRepository {
  late Excel _excel;
  final List<DayData> _data;

  FileRepository(this._data);

  Future<File> createAndSaveExcel() async {
    try {
      // Create a new Excel file
      _excel = Excel.createExcel();

      // Get the default sheet
      Sheet sheet = _excel['Sheet1'];

      // Create headers
      sheet.cell(CellIndex.indexByString("A1")).value = TextCellValue("Date");
      sheet.cell(CellIndex.indexByString("B1")).value = TextCellValue(
        "Description",
      );
      sheet.cell(CellIndex.indexByString("C1")).value = TextCellValue("Hours");

      // Style the headers (simplified)
      var headerStyle = CellStyle(bold: true);

      sheet.cell(CellIndex.indexByString("A1")).cellStyle = headerStyle;
      sheet.cell(CellIndex.indexByString("B1")).cellStyle = headerStyle;
      sheet.cell(CellIndex.indexByString("C1")).cellStyle = headerStyle;

      // Add data rows
      for (int i = 0; i < _data.length; i++) {
        final dayData = _data[i];
        final rowIndex = i + 2; // Start from row 2 (after headers)

        // Format date as readable string
        final formattedDate =
            "${dayData.date.day}/${dayData.date.month}/${dayData.date.year}";

        // Calculate hours and minutes
        final hours = dayData.timeSpent ~/ 60;
        final minutes = dayData.timeSpent % 60;
        final hoursString = "${hours}h ${minutes}m";

        sheet.cell(CellIndex.indexByString("A$rowIndex")).value = TextCellValue(
          formattedDate,
        );
        sheet.cell(CellIndex.indexByString("B$rowIndex")).value = TextCellValue(
          dayData.description,
        );
        sheet.cell(CellIndex.indexByString("C$rowIndex")).value = TextCellValue(
          hoursString,
        );
      }

      // Get the app's documents directory
      final directory = await getApplicationDocumentsDirectory();

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = "clock_mate_data_$timestamp.xlsx";
      final filePath = join(directory.path, fileName);

      // Save the file
      final fileBytes = _excel.save();
      if (fileBytes != null) {
        final file = File(filePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes);
        return file;
      } else {
        throw Exception("Failed to generate Excel file");
      }
    } catch (e) {
      throw Exception("Error creating Excel file: $e");
    }
  }

  Future<void> readFile(String filePath) async {
    try {
      final file = File(filePath);
      final bytes = await file.readAsBytes();
      _excel = Excel.decodeBytes(bytes);
      print('Excel file saved at: $filePath');

      for (var table in _excel.tables.keys) {
        print("Sheet: $table");
        final sheet = _excel.tables[table];
        if (sheet != null) {
          for (var row in sheet.rows) {
            final rowData = row
                .map((cell) => cell?.value?.toString() ?? '')
                .toList();
            print("Row: $rowData");
          }
        }
      }
    } catch (e) {
      throw Exception("Error reading Excel file: $e");
    }
  }

  Future<void> shareFile(File file) async {
    final String filePath = file.path;
    final params = ShareParams(
      // since all data has same month and year just check 1
      text: 'Summary for ${_data[0].date.month}/${_data[0].date.year}',
      files: [XFile(filePath)],
    );
    final result = await SharePlus.instance.share(params);
    if (result.status != ShareResultStatus.success) {
      throw FormatException("Error sharing file: ${result.status}");
    }
  }
}
