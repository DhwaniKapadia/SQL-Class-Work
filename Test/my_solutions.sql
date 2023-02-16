
-- Question 1.

SELECT concat(s.stffirstname,' ',s.stflastname) as name, title, datehired
FROM faculty f
JOIN staff s
ON s.staffid = f.staffid
WHERE date_part('year',s.datehired) = '1992' AND
		f.title IN ('Professor', 'Associate Professor');
		
-- Question 2.

SELECT concat(s.studfirstname,' ',s.studlastname) as student_name, avg(ss.grade) as student_average_grade
FROM students s
JOIN student_schedules ss
ON s.studentid = ss.studentid
WHERE ss.classstatus = 2
GROUP BY concat(s.studfirstname,' ',s.studlastname)
ORDER BY student_average_grade desc;

-- Question 3.

SELECT s.subjectcode, s.subjectname
FROM subjects s
LEFT JOIN faculty_subjects as fs
ON s.subjectid = fs.subjectid
WHERE fs.staffid IS NULL;

-- Question 4.

SELECT concat(s.stflastname,' ',s.stffirstname), count(*)
FROM staff s
JOIN faculty f
ON s.staffid = f.staffid
JOIN faculty_classes fc
ON fc.staffid = f.staffid
GROUP BY concat(s.stflastname,' ',s.stffirstname)
HAVING count(*) > 7;

-- Question 5.

SELECT s.staffid, s.stffirstname, s.stflastname, f.title, f.status, s.salary,
	CASE WHEN f.title = 'Instructor' THEN CAST(s.salary*1.05 AS INTEGER)
		WHEN f.title = 'Associate Professor' THEN CAST(s.salary*1.04 AS INTEGER)
		ELSE CAST(s.salary*1.035 AS INTEGER)
	END AS newsalary
FROM staff s
JOIN faculty f
ON s.staffid = f.staffid;

-- Question 6.

SELECT s.categoryid, s.subjectcode, s.subjectname, 
		max(ss.grade) over(partition by s.subjectcode) as subjectmax,
		max(ss.grade) over(partition by s.categoryid ORDER BY categoryid) as categorymax
FROM subjects s
JOIN classes c
ON c.subjectid = s.subjectid
JOIN student_schedules as ss
ON ss.classid = c.classid
WHERE ss.classstatus = 2;

-- Question 7.

WITH t1 as (
	SELECT fs.staffid, avg(fs.proficiencyrating) as score, d.deptname
	FROM departments d
	JOIN categories c
	ON d.departmentid= c.departmentid
	JOIN faculty_categories fc
	ON c.categoryid = fc.categoryid
	JOIN faculty f
	ON fc.staffid = f.staffid
	JOIN faculty_subjects fs
	ON fs.staffid = f.staffid
	GROUP BY fs.staffid, d.deptname
	ORDER BY 3
)

SELECT t1.deptname, max(t1.score) as max_score
FROM t1
GROUP BY t1.deptname;

