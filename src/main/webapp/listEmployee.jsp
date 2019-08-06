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
<!-- Bootstrap -->
<link href="webjars/bootstrap/4.3.1/css/bootstrap.min.css"
	rel="stylesheet">
<script src="webjars/jquery/3.3.1/jquery.min.js"></script>
<script src="webjars/bootstrap/4.3.1/css/bootstrap.min.js"></script>
<meta charset="ISO-8859-1">
<title>Employee Servlet: List</title>

<script type="text/javascript">
	function addEmployee() {
		var url = window.location.href;
		url = url.replace(/\?[^\?]*$/, "");
		url += "?action=add";
		window.location.href = url;
	}

	$(document).ready(function(){
		$('#msg').click(function(){
			$('#msg').fadeOut("slow");
		});
		setTimeout(function(){
			$('#msg').fadeOut("slow");
		},3000);

	})
</script>
</head>
<body>
	<div class=container>
		<%
			String message = (String) request.getAttribute("message");
			if (!StringUtil.isNull(message)) {
		%>

			<div id='msg' class='alert text-center alert-success'>
				<%= message %>
			</div>
		
		<% } %>
		

		<div class="row float-right mr-auto p-2">
			<div class=clearfix>
				<input class="btn btn-danger float-right" type="button"
					value="Add Employee (randomly)" onclick="addEmployee()">
			</div>
		</div>
		<form class=p-2 action="/HibernetServlet/EmployeeServlet">
			<div>
				<h2>Query employee</h2>
			</div>
			<div class="p-2 row">
				<div class=col-md-4>
					<label class=mx-1 for="name_in">name</label> <input
						class="form-control" id="name_in" name="name" type="text">
					<small id="nameHelp" class="form-text text-muted">You can
						input part of the name of the employee.</small>
				</div>
				<div class=col-md-4>
					<label class=mx-1 for="sex_in">sex</label> <select
						class="form-control" id=sex_in name="sex">
						<option selected value>---select---</option>
						<option value="M">M</option>
						<option value="F">F</option>
					</select>
				</div>
				<div class=col-md-4>
					<div class="form-group">
						<label class=mx-1 for="age_in">age</label>
						<div class="form-row">
							<div class="col-md-3">
								<select class=form-control name=ageOperate>
									<option>></option>
									<option><</option>
									<option>=</option>
								</select>
							</div>
							<div class="col">
								<select class="form-control" id=age_in name="age"></select>
								<script>
									$(function() {
										var $select = $("#age_in");
										$select
												.append($(
														'<option selected value></option')
														.val('').html(
																'---select---'))
										for (i = 18; i <= 65; i++) {
											$select.append($(
													'<option></option>').val(i)
													.html(i))
										}
									});
								</script>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="p-2 row">
				<div class=col-md-4>
					<label class=mx-1 for=birthday_in>birthday</label> <input
						class=form-control name=birthday id=birthday_in type="date">
				</div>
				<div class=col-md-4>
					<label class=mx-1 for=startTime_in>start time</label> <input
						class=form-control name=startTime id=startTime_in type="time">
				</div>
				<div class=col-md-4>
					<label class=mx-1 for=salary_in>salary</label>
					<div class=form-row>
						<div class=col-md-3>
						<select class="form-control" name=salaryOperate>
							<option>></option>
							<option><</option>
							<option>=</option>
						</select> 
						</div>
						<div class=col>
						<input name=salary class="form-control" id=salary_in type="text">
						</div>
					</div>
				</div>
			</div>
			<div class=text-center>
				<input class="row text-center btn btn-primary mb-2" type="submit"
					value="query">
			</div>
		</form>
		<div class="p-2 mx-auto">
			<table class="table table-striped ">
				<tr>
					<!-- id -->
					<%
						if ("id".equals(request.getAttribute("sort"))) {
					%>
					<th class="sortable"><a
						href="${ url }action=list&sort=id&order=${ order=='asc'?'desc':'asc' }">Number</a>
					</th>
					<%
						} else {
					%>
					<th class="sortable"><a
						href="${ url }action=list&sort=id&order=asc">Number</a></th>
					<%
						}
					%>
					<!-- name -->
					<%
						if ("name".equals(request.getAttribute("sort"))) {
					%>
					<th class="sortable"><a
						href="${ url }action=list&sort=name&order=${ order=='asc'?'desc':'asc' }">Name</a>
					</th>
					<%
						} else {
					%>
					<th class="sortable"><a
						href="${ url }action=list&sort=name&order=asc">Name</a></th>
					<%
						}
					%>
					<!-- sex -->
					<%
						if ("sex".equals(request.getAttribute("sort"))) {
					%>
					<th class="sortable"><a
						href="${ url }action=list&sort=sex&order=${ order=='asc'?'desc':'asc' }">Sex</a>
					</th>
					<%
						} else {
					%>
					<th class="sortable"><a
						href="${ url }action=list&sort=sex&order=asc">Sex</a></th>
					<%
						}
					%>
					<!-- Age -->
					<%
						if ("age".equals(request.getAttribute("sort"))) {
					%>
					<th class="sortable"><a
						href="${ url }action=list&sort=age&order=${ order=='asc'?'desc':'asc' }">Age</a>
					</th>
					<%
						} else {
					%>
					<th class="sortable"><a
						href="${ url }action=list&sort=age&order=asc">Age</a></th>
					<%
						}
					%>
					<!-- birthday -->
					<%
						if ("birthday".equals(request.getAttribute("sort"))) {
					%>
					<th class="sortable"><a
						href="${ url }action=list&sort=birthday&order=${ order=='asc'?'desc':'asc' }">Birthday</a>
					</th>
					<%
						} else {
					%>
					<th class="sortable"><a
						href="${ url }action=list&sort=birthday&order=asc">Birthday</a></th>
					<%
						}
					%>
					<!-- salary -->
					<%
						if ("salary".equals(request.getAttribute("sort"))) {
					%>
					<th class="sortable"><a
						href="${ url }action=list&sort=salary&order=${ order=='asc'?'desc':'asc' }">Salary</a>
					</th>
					<%
						} else {
					%>
					<th class="sortable"><a
						href="${ url }action=list&sort=salary&order=asc">Salary</a></th>
					<%
						}
					%>
					<!-- start -->
					<%
						if ("startTime".equals(request.getAttribute("sort"))) {
					%>
					<th class="sortable"><a
						href="${ url }action=list&sort=startTime&order=${ order=='asc'?'desc':'asc' }">Start
							Time</a></th>
					<%
						} else {
					%>
					<th class="sortable"><a
						href="${ url }action=list&sort=startTime&order=asc">Start Time</a></th>
					<%
						}
					%>
					<!-- end -->
					<%
						if ("endTime".equals(request.getAttribute("sort"))) {
					%>
					<th class="sortable"><a
						href="${ url }action=list&sort=endTime&order=${ order=='asc'?'desc':'asc' }">End
							Time</a></th>
					<%
						} else {
					%>
					<th class="sortable"><a
						href="${ url }action=list&sort=endTime&order=asc">End Time</a></th>
					<%
						}
					%>
					<!-- operation -->
					<%
						if ("disabled".equals(request.getAttribute("sort"))) {
					%>
					<th class="sortable"><a
						href="${ url }action=list&sort=disabled&order=${ order=='asc'?'desc':'asc' }">Operation</a>
					</th>
					<%
						} else {
					%>
					<th class="sortable"><a
						href="${ url }action=list&sort=disabled&order=asc">Operation</a></th>
					<%
						}
					%>
				</tr>
				<%
					List<Employee> employeeList = (List<Employee>) request.getAttribute("employeeList");
					NumberFormat salary = new DecimalFormat("0.00");
					for (int i = 0; employeeList != null && i < employeeList.size(); i++) {
						Employee e = employeeList.get(i);
						out.println("<tr>");
						out.println("  <td>" + e.getId() + "</td>");
						out.println("  <td>" + e.getName() + "</td>");
						out.println("  <td>" + e.getSex() + "</td>");
						out.println("  <td>" + e.getAge() + "</td>");
						out.println("  <td>" + e.getBirthday() + "</td>");
						out.println("  <td>$" + salary.format(e.getSalary()) + "</td>");
						out.println("  <td>" + e.getStartTime() + "</td>");
						out.println("  <td>" + e.getEndTime() + "</td>");
						out.println("  <td>" + (e.isDisabled() ? "Stopped" : "Normal") + "</td>");
						out.println("</tr>");
					}
				%>

			</table>
		</div>
	</div>
</body>
</html>