package javaweb.servlet;

import java.io.IOException;
import java.sql.Time;
import java.util.Date;
import java.util.List;

import javax.persistence.TypedQuery;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.sql.Template.NoOpColumnMapper;

import antlr.StringUtils;
import javassist.expr.NewArray;
import javaweb.HibernateUtil;
import javaweb.StringUtil;
import javaweb.bean.Department;
import javaweb.bean.Employee;

/**
 * Servlet implementation class EmployeeServlet
 */
public class DepartmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DepartmentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		if ("add".equals(action)) {
			add(request,response);
		} else if ("query".equals(action)) {
			query(request, response);
		} else {
			list(request, response);
		}
		
	}

	private void add(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}

	private void query(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}

	private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String sort=request.getParameter("sort");
		String order=request.getParameter("order");
		
		if (StringUtil.isNull(sort)) {
			sort="id";
		}
		if (StringUtil.isNull(order)) {
			sort="desc";
		}
		
		String departmentName = request.getParameter("departmentName");
		String managerName = request.getParameter("managerName");
		String employeeSize = request.getParameter("employeeSize");
		String employeeOperator = request.getParameter("employeeOperator");

		String where="";
		
		if (!StringUtil.isNull(departmentName)) {
			if (!StringUtil.isNull(where)) 
				where += " and ";
			where += " e.name like '%"+departmentName+"%' ";
		}
	
		if (!StringUtil.isNull(managerName)) {
			if (!StringUtil.isNull(where)) 
				where += " and ";
			where += " e.name like '%"+managerName+"%' ";
		}

		if (!StringUtil.isNull(employeeSize)) {
			if (!StringUtil.isNull(where)) 
				where += " and ";
			where += " e.age "+employeeOperator+" "+employeeSize+" ";
		}
	
		String hql = " from Department d ";
		if (!StringUtil.isNull(where)) {
			hql+=" where "+where;
		}
		
		hql += " order by d."+sort+" "+order;
			
		Session session = HibernateUtil.getSessionFactory().openSession();
		List<Department> departmentList = session.createQuery(hql).list();
		
		for (Department d : departmentList) {
			d.getEmployees().size();
		}
		session.close();
		
		request.setAttribute("departmentList", departmentList);
		request.setAttribute("order", order);
		request.setAttribute("url", StringUtil.getURL(request));
		
		if (request.getAttribute("message")== null) {
			request.setAttribute("message", "HQL: "+hql);
		}
		
		request.getRequestDispatcher("/listDepartment.jsp").forward(request, response);
	}


}
