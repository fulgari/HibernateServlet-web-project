<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="javaweb.StringUtil"%>
<%@page import="javaweb.bean.Employee"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="ISO-8859-1">
<title>Employee Servlet: List</title>

<script type="text/javascript">
	function addEmployee(){
		var url = window.location.href;
		url = url.replace(/\?[^\?]*$/,"");
		url += "?action=add";
		window.location.href = url; 
	}
</script>
</head>
<body>
<input class="btn btn-danger" style="    position: absolute; top: 0px; right: 0px;" type="button" value="Add Employee (randomly)" onclick="addEmployee()">
<%
	String message = (String) request.getAttribute("message");
	if(!StringUtil.isNull(message)){
		out.println("<div class=message>"+message+"</div>"); 
	}
%>

<table>
	<tr>
		<%
			if("id".equals(request.getAttribute("sort"))){
		%>
		<th class="sortable sorted ${ order }" >
			<a href="${ url }action=list&sort=id&order=${ order=='asc'?'desc':'asc' }">Number</a>
		</th>
		<% } else { %>
		<th class="sortable " >
			<a href="${ url }action=list&sort=id&order=asc">Number</a>
		</th>
		<% } %>

		<th class="sortable">Name</th>
		<th class="sortable">Sex</th>
		<th class="sortable">Age</th>
		<th class="sortable">Birthday</th>
		<th class="sortable">Salary</th>
		<th class="sortable">Start Time</th>
		<th class="sortable">End Time</th>
		<th class="sortable">Operation</th>
	</tr>
	<%
		List<Employee> employeeList = (List<Employee>) request.getAttribute("employeeList");
		NumberFormat salary = new DecimalFormat("0.00");
		for(int i=0; employeeList != null && i<employeeList.size(); i++){
			Employee e = employeeList.get(i);
			out.println("  <td>"+e.getId()+"</td>");
			out.println("  <td>"+e.getName()+"</td>");
			out.println("  <td>"+e.getSex()+"</td>");
			out.println("  <td>"+e.getAge()+"</td>");
			out.println("  <td>"+e.getBirthday()+"</td>");
			out.println("  <td>$"+salary.format(e.getSalary())+"</td>");
			out.println("  <td>"+e.getStartTime()+"</td>");
			out.println("  <td>"+e.getEndTime()+"</td>");
			out.println("  <td>"+(e.isDisabled()?"Stopped":"Normal")+"</td>");
			out.println("  <td>&nbsp;</td>");
			out.println("</tr>");
		}
	%>
		
	<div></div>
</table>
</body>
</html>