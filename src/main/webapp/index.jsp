<%@ page import="java.util.Calendar,java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to COMP367</title>
</head>
<body>
<%
    Calendar cal = Calendar.getInstance();
    SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
    String time = sdf.format(cal.getTime());
    String name = "Milankumar Khunt"; // Change this to your name

    String greeting = "Welcome to COMP367";

    int hour = cal.get(Calendar.HOUR_OF_DAY);

    if (hour >= 6 && hour < 12) {
        greeting = "Good morning, " + name + ", " + greeting;
    } else if (hour >= 12 && hour < 18) {
        greeting = "Good afternoon, " + name + ", " + greeting;
    } else {
        greeting = "Good evening, " + name + ", " + greeting;
    }
%>

<h1><%= greeting %></h1>
</body>
</html>
