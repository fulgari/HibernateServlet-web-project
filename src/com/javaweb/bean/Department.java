package javaweb.bean;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.*;

@Entity
@Table(name = "tb_department")
public class Department {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;
	
	private String name;
	private String description;
	
	@OneToOne
	@JoinColumn(name = "line_manager_id")
	private Employee linEmployee;
	
	@OneToMany(mappedBy = "department")
	private Set<Employee> employees = new HashSet<Employee>();

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Employee getLinEmployee() {
		return linEmployee;
	}

	public void setLinEmployee(Employee linEmployee) {
		this.linEmployee = linEmployee;
	}

	public Set<Employee> getEmployees() {
		return employees;
	}

	public void setEmployees(Set<Employee> employees) {
		this.employees = employees;
	}

}
