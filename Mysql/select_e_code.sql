# 根据学生用户id获取所在班级id与名称
select user.id, user.name, class.id, class.name from class
    join user where user.role = 'student' and user.id = 24;

# 根据标签id与班级id查找班级内包含此标签的题目
select class.id, class.name, tag.id, tag.name, problem.id, problem.title from problem
    join class_problem
    join problem_tag
    join tag
    join class where class_problem.id = problem.id and problem_tag.id = tag.id and tag.id = 51
        and class_problem.class_id = class.id and class.id = 34;


# 根据学生用户id与班级id获取题目在班级内的题目id，题目标题，以及当前学生题目得分，以及题目标签
select user.id, user.name, class.id, class.name, problem.id, problem.title, class_score.score, tag.name from class_score
    join class_problem
    join class
    join problem
    join problem_tag
    join tag
    join student_class
    join user where class_problem.id = class_score.class_problem_id and class.id = 34
                and class_problem.id = problem.id and problem_tag.id = problem.id and tag.id = problem_tag.tag_id
                and student_class.id = class_score.sc_id and user.id = 69;