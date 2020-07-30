part of nhabe;

final defaultTitleBuilder = (MonthAndYear selectedMonth) =>
    DateFormat.yMMM().format(selectedMonth.toDateTime());

const defaultTitleStyle = TextStyle(fontWeight: FontWeight.bold);

const defaultWeekdayLabelStyle = TextStyle(fontWeight: FontWeight.bold);

const componentPadding = const EdgeInsets.only(left: 20, right: 20, top: 5);
