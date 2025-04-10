https://www.jqueryscript.net/time-clock/event-calendar-evo.html#google_vignette


<!-- Core Stylesheet -->
<link rel="stylesheet" href="evo-calendar.css" />
<!-- Optional Themes -->
<link rel="stylesheet" href="evo-calendar.midnight-blue.css" />
<link rel="stylesheet" href="evo-calendar.orange-coral.css" />
<link rel="stylesheet" href="evo-calendar.royal-navy.css" />
<!-- JavaScript -->
<script src="jquery.min.js"></script>
<script src="evo-calendar.js"></script>


myEvents = [
  { 
    id: "required-id-1",
    name: "New Year", 
    date: "Wed Jan 01 2020 00:00:00 GMT-0800 (Pacific Standard Time)", 
    type: "holiday", 
    everyYear: true 
  },
  { 
    id: "required-id-2",
    name: "Valentine's Day", 
    date: "Fri Feb 14 2020 00:00:00 GMT-0800 (Pacific Standard Time)", 
    type: "holiday", 
    everyYear: true,
    color: "#222"
  },
  { 
    id: "required-id-3",
    name: "Custom Date", 
    badge: "08/03 - 08/05",
    date: ["August/03/2020", "August/05/2020"],
    description: "Description here"
    type: "event", 
  },
  // more events here
],

$('#evoCalendar').evoCalendar({
  calendarEvents: myEvents
});

$('#evoCalendar').evoCalendar({
  format: 'mm/dd/yyyy',
  titleFormat: 'MM yyyy',
  eventHeaderFormat: 'MM d, yyyy'
});

$('#evoCalendar').evoCalendar({
  language: 'en'
});

dates: {
  en: {
      days: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
      daysShort: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
      daysMin: ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"],
      months: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
      monthsShort: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
      noEventForToday: "No event for today.. so take a rest! :)",
      noEventForThisDay: "No event for this day.. so take a rest! :)"
  },
  es: {
      days: ["Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"],
      daysShort: ["Dom", "Lun", "Mar", "Mié", "Jue", "Vie", "Sáb"],
      daysMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
      months: ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
      monthsShort: ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"],
      noEventForToday: "No hay evento para hoy.. ¡así que descanse! :)",
      noEventForThisDay: "Ningún evento para este día.. ¡así que descanse! :)"
  },
  de: {
      days: ["Sonntag", "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag"],
      daysShort: ["So", "Mo", "Di", "Mi", "Do", "Fr", "Sa"],
      daysMin: ["So", "Mo", "Di", "Mi", "Do", "Fr", "Sa"],
      months: ["Januar", "Februar", "März", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember"],
      monthsShort: ["Jan", "Feb", "Mär", "Apr", "Mai", "Jun", "Jul", "Aug", "Sep", "Okt", "Nov", "Dez"],
      noEventForToday: "Keine Veranstaltung für heute.. also ruhen Sie sich aus! :)",
      noEventForThisDay: "Keine Veranstaltung für diesen Tag.. also ruhen Sie sich aus! :)"
  },
  pt: {
      days: ["Domingo", "Segunda-Feira", "Terça-Feira", "Quarta-Feira", "Quinta-Feira", "Sexta-Feira", "Sábado"],
      daysShort: ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb"],
      daysMin: ["Do", "2a", "3a", "4a", "5a", "6a", "Sa"],
      months: ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"],
      monthsShort: ["Jan", "Feb", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"],
      noEventForToday: "Nenhum evento para hoje.. então descanse! :)",
      noEventForThisDay: "Nenhum evento para este dia.. então descanse! :)"
      
  }
}


$('#evoCalendar').evoCalendar({
  todayHighlight: false
});

$('#evoCalendar').evoCalendar({
  sidebarToggler: true,
  sidebarDisplayDefault: true,
  eventListToggler: true,
  eventDisplayDefault: true,
});


$('#evoCalendar').evoCalendar({
  firstDayOfWeek: 1 // Monday
});


$("#evoCalendar").evoCalendar('addCalendarEvent', [
  {
   name: "NEW EVENT",
   date: "February/16/2020",
   type: "birthday",
   everyYear: true
  }
]);


$('#evoCalendar').evoCalendar({
  theme: 'Orange Coral'
});

// set theme
$("#evoCalendar").evoCalendar('setTheme', themeName);

// toggle sidebar
$("#evoCalendar").evoCalendar('toggleSidebar', true/false);

// toggle event list
$("#evoCalendar").evoCalendar('toggleEventList', true/false);

// get the selected date
$("#evoCalendar").evoCalendar('getActiveDate');

// get active events
$("#evoCalendar").evoCalendar('getActiveEvents');

// select a year
$("#evoCalendar").evoCalendar('selectYear', yearNumber);

// select a month
$("#evoCalendar").evoCalendar('selectMonth', monthNumber);

// select a date
$("#evoCalendar").evoCalendar('selectDate', dateNumber);

// add events
$("#evoCalendar").evoCalendar('addCalendarEvent', [{
  id: 'Event ID',
  name: "Event Name",
  date: "Date Here",
  type: "Event Type",
  everyYear: true
}]);

// remove events by ID
$("#evoCalendar").evoCalendar('removeCalendarEvent', eventID);

// destroy the calendar
$("#evoCalendar").evoCalendar('destroy');


$('#evoCalendar').evoCalendar({
  // options here
})
.on('selectDate', function(newDate, oldDate) {
  // do something
})
.on('selectMonth', function(activeMonth, monthIndex) {
  // do something
})
.on('selectYear', function(activeYear) {
  // do something
})
.on('selectEvent', function(activeEvent) {
  // do something
})
.on('destroy', function(calendar) {
  // do something
})