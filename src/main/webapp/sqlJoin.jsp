<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="javaweb.StringUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
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
<%
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	
	String sql=request.getParameter("sql");
	String message="";
	String table="";
	
	if(!StringUtil.isNull(sql)){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/zijun?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Europe/Athens","root","stagiaire");
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			
			table="<table class='table'>";
			table+="<tr>";
			ResultSetMetaData metadata = rs.getMetaData();
			
			for(int i=0; i<metadata.getColumnCount(); i++){
				String name = metadata.getColumnName(i+1);
				table+="\t\t<th class=\"sortable\">"+name+"</th>";
			}
			table+="</tr>";
			int ii=0;
			while(rs.next()){
				ii++;
				table+="<tr class="+(ii%2==0?"even":"odd")+">";
				for(int i=0; i<metadata.getColumnCount(); i++){
					String value=rs.getString(i+1);
					table+="\t\t<td"+(value==null?"style='background:#FFCCCC;'":"")+">"+value+"</td>";
				}
				table+="</tr>";
			}
			table+="</table>";
		} catch (Exception e){
			message = "Error occurred:"+e.getMessage();
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
			if(conn!=null) conn.close();
		}
	}
%>
<meta charset="ISO-8859-1">
<title>SQL JOIN</title>
</head>
<body>
<div class=" container list">
	<div align="float-right">
		<input type="button" class="btn btn-primary button" value=" inner join " onclick="location='${ pageContext.request.requestURI }?sql=select tb_department.name as DepartmentName, tb_employee.name as EmployeeName from tb_department inner join tb_employee on tb_department.id=tb_employee.department_id'">
		<input type="button" class="btn btn-primary button" value=" left join " onclick="location='${ pageContext.request.requestURI }?sql=select tb_department.name as DepartmentName, tb_employee.name as EmployeeName from tb_department left join tb_employee on tb_department.id=tb_employee.department_id'">
		<input type="button" class="btn btn-primary button" value=" right join " onclick="location='${ pageContext.request.requestURI }?sql=select tb_department.name as DepartmentName, tb_employee.name as EmployeeName from tb_department right join tb_employee on tb_department.id=tb_employee.department_id'">
	</div>
	<%
	if(!StringUtil.isNull(message)){
		out.println("<div class='alert message'>"+message+"</div>");
	}
	%>
	<form class="p-2" action="${ pageContext.request.requestURI }" method="get">
		<div class="p-2">
			<h2>Please input SQL</h2>
		</div>
		<textarea class="p-2 form-control" name="sql">${ param.sql }</textarea>
		<div class="" align="center">
			<input type="submit" class="button btn btn-success" value="Query">
		</div>
	</form>
	<%= table %>
</div>

</body>
</html>