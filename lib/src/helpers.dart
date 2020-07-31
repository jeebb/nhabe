part of nhabe;

final defaultTitleBuilder = (MonthAndYear selectedMonth) =>
    DateFormat.yMMM().format(selectedMonth.toDateTime());
