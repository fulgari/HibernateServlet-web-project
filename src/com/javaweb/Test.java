package javaweb;

import java.util.List;

import org.hibernate.Session;

import javaweb.bean.Employee;

public class Test {

	public static void main(String[] args) {
		Employee employee = StringUtil.getRandomEmployee();
		Session session = HibernateUtil.getSessionFactory().openSession();
		session.beginTransaction();
		session.persist(employee);
		session.getTransaction().commit();
		
		List<Employee> employees = session.createQuery(" from Employee ").getResultList();
		
		for (Employee e : employees) {
			System.out.println(e.getName()+"\t"+e.getSex()+"\t"+e.getAge()+"\t"+e.getBirthday()+"\t"+e.getDescription()+"\t"+e.getDateCreated()+"\t"+e.isDisabled());
		}

		session.close();
	}

}
