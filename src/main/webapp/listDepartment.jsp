<%@page import="javaweb.bean.Employee"%>
<%@page import="javaweb.bean.Department"%>
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
<title>Department Servlet: List</title>
</head>
<body>
	<div class="container">
		<form class=p-2 action="/HibernetServlet/DepartmentServlet">
			<div>
				<h2>Query department</h2>
			</div>
			<div class="p-2 row">
				<div class=col-md-4>
					<label class=mx-1 for="name_in">name</label> <input
						class="form-control" id="name_in" name="name" type="text">
					<small id="nameHelp" class="form-text text-muted">You can
						input part of the name of the department.</small>
				</div>
				<div class=col-md-4>
					<label class=mx-1 for=managerName_in>manager name</label> <input
						class=form-control name=managerName id=managerName_in type="text">
				</div>
				<div class=col-md-4>
					<div class="form-group">
						<label class=mx-1 for="employeesSize_in">employees</label>
						<div class="form-row">
							<div class="col-md-3">
								<select class=form-control name=employeesOperator>
									<option>></option>
									<option><</option>
									<option>=</option>
								</select>
							</div>
							<div class="col">
								<select class="form-control" id=employeesSize_in
									name="employeesSize"></select>
								<script>
									$(function() {
										var $select = $("#employeesSize_in");
										$select
												.append($(
														'<option selected value></option')
														.val('').html(
																'---select---'))
										for (i = 1; i <= 100; i++) {
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
			<div class=text-center>
				<input class="row text-center btn btn-primary mb-2" type="submit"
					value="query">
			</div>
		</form>

		<!-- table -->
		<table class="table table-striped">
			<tr>
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
				<%
					if ("lineManager".equals(request.getAttribute("sort"))) {
				%>
				<th class="sortable"><a
					href="${ url }action=list&sort=lineManager&order=${ order=='asc'?'desc':'asc' }">Manager</a>
				</th>
				<%
					} else {
				%>
				<th class="sortable"><a
					href="${ url }action=list&sort=lineManager&order=asc">Manager</a></th>
				<%
					}
				%>
			</tr>


			<%
				List<Department> departmentList = (List<Department>) request.getAttribute("departmentList");

				for (int i = 0; departmentList != null && i < departmentList.size(); i++) {

					Department d = departmentList.get(i);
					Employee lineManager = d.getLineManager();
					out.println("<tr>");
					out.println("  <td>" + d.getId() + "</td>");
					out.println("  <td>" + d.getName() + "</td>");
					out.println("  <td>" + (lineManager == null ? "" : lineManager.getName()) + "</td>");
					out.println("  <td>" + d.getEmployees().size());
					boolean endFlag = false;
					if (d.getEmployees().size() > 0) {
						out.println("( ");
						for (Employee ee : d.getEmployees()) {
							out.println(ee.getName() + " ");
						}
						out.println(")");
					}

					out.println("</td>");
					out.println("  <td><a href=DepartmentServlet?action=edit&id=" + d.getId() + ">Modify</a>");
					out.println(
							"  <a onclick=\"return confirm('sure to delete department?')\" href=DepartmentServlet?action=delete&id="
									+ d.getId() + ">delete</a></td>");
					out.println("</tr>");
				}
			%>
		</table>
	</div>
</body>
</html>