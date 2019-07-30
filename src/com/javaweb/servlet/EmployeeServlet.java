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
import javaweb.bean.Employee;

/**
 * Servlet implementation class EmployeeServlet
 * 
 * DETAILS: PLEASE consult JavaWeb_Integrate chapter 25 (Page 622)
 */
public class EmployeeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EmployeeServlet() {
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
			addEmployee(request,response);
			return;
		}
		listEmployee(request, response);
	}

	private void listEmployee(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String sort=request.getParameter("sort");
		String order=request.getParameter("order");
		
		if (StringUtil.isNull(sort)) {
			sort="id";
		}
		if (StringUtil.isNull(order)) {
			sort="desc";
		}
		
		String name = request.getParameter("name");
		String age = request.getParameter("age");
		String ageOperate = request.getParameter("ageOperate");
		String sex = request.getParameter("sex");
		String birthday = request.getParameter("birthday");
		String time = request.getParameter("time");
		String salary = request.getParameter("salary");
		String salaryOperate = request.getParameter("salaryOperate");
		String description = request.getParameter("description");
		String disabled = request.getParameter("disabled");
		
		String where="";
		
		if (!StringUtil.isNull(name)) {
			if (!StringUtil.isNull(where)) 
				where += " and ";
//			where += " e.name like '%"+name+"%' ";
			where += " e.name like :name ";
		}
		if (!StringUtil.isNull(sex)) {
			if (!StringUtil.isNull(where)) 
				where += " and ";
//			where += " e.sex = '"+sex+"' ";
			where += " e.sex = :sex ";
		}
		
		if (!StringUtil.isNull(age)) {
			if (!StringUtil.isNull(where)) 
				where += " and ";
//			where += " e.age "+ageOperate+" "+age;
			where += " e.age "+ageOperate+" :age ";
		}
		if (!StringUtil.isNull(birthday)) {
			if (!StringUtil.isNull(where)) 
				where += " and ";
//			where += " e.birthday = '"+birthday+"' ";
			where += " e.birthday = :birthday ";
		}
		if (!StringUtil.isNull(time)) {
			if (!StringUtil.isNull(where)) 
				where += " and ";
			where += " (e.startTime <= :time and e.endTime >= :time)";
		}
		if (!StringUtil.isNull(salary)) {
			if (!StringUtil.isNull(where)) 
				where += " and ";
//			where += " e.salary "+salaryOperate+" "+salary;
			where += " e.salary "+salaryOperate+" :salary ";
		}
		if (!StringUtil.isNull(description)) {
			if (!StringUtil.isNull(where)) 
				where += " and ";
//			where += " e.name like '%"+description+"%' ";
			where += " e.name like :description ";
		}
		if (!StringUtil.isNull(disabled)) {
			if (!StringUtil.isNull(where)) 
				where += " and ";
			where += " e.disabled = "+("true".equals(disabled));
		}
		
		String hql = " from Employee e ";
		if (!StringUtil.isNull(where)) {
			hql+=" where "+where;
		}
		
		hql += " order by e."+sort+" "+order;
		
		// some error 
		// Query query = ... ?
		TypedQuery query = HibernateUtil.getSessionFactory().openSession().createQuery(" select count(e) "+hql);
		
		if(hql.contains("name"))
			query.setParameter("name", "%"+name+"%");
		if(hql.contains("sex"))
			query.setParameter("sex", sex);
		if(hql.contains("age"))
			query.setParameter("age", new Integer(age));
		if(hql.contains("birthday"))
			query.setParameter("birthday", java.sql.Date.valueOf(birthday));
		if(hql.contains("time"))
			query.setParameter("time", Time.valueOf(time));
		if(hql.contains("salary"))
			query.setParameter("salary", new Double(salary));
		if(hql.contains("description"))
			query.setParameter("description", "%"+description+"%");
		if(hql.contains("disabled"))
			query.setParameter("disabled", "true".equals(disabled));

		
		Number result = (Number) query.getSingleResult();
		int count = result.intValue();
		
		query = HibernateUtil.getSessionFactory().openSession()
				.createQuery(hql).setFirstResult(0)
				.setMaxResults(10);
		
		List<Employee> employeeList = query.getResultList();
		request.setAttribute("url", StringUtil.getURL(request));
		request.setAttribute("sort", sort);
		request.setAttribute("order", order);
		request.setAttribute("employeeList", employeeList);
		
		if (request.getAttribute("message")== null) {
			request.setAttribute("message", "HQL: "+hql);
		}
		
		request.getRequestDispatcher("/listEmployee.jsp").forward(request, response);
		
		
		
		
	}

	private void addEmployee(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Employee employee = StringUtil.getRandomEmployee();
		Session session = HibernateUtil.getSessionFactory().openSession();

		Transaction tran = session.beginTransaction();
		session.persist(employee);
		tran.commit();
		session.close();
		
		request.setAttribute("message", "Random Employee added: "+employee.getName());
		listEmployee(request, response);
	}

}
