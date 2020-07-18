part of nhabe;

final defaultTitleBuilder = (MonthAndYear selectedMonth) =>
    DateFormat.yMMM().format(selectedMonth.toDateTime());

const defaultTitleStyle = TextStyle(fontWeight: FontWeight.bold);
