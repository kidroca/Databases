using System;
using System.Linq;

namespace StudentSystem.DataLink.Migrations
{
    using System.IO;
    using System.Threading.Tasks;
    using Newtonsoft.Json;
    using StudentSystem.Models;

    /// <summary>
    /// A class parsing data for random seeds.
    /// Maybe pass the working dir path in the constructor => trim the constants a bit
    /// </summary>
    public class SeedingValues
    {
        private const string studentsJsonPath =
            "../../../StudentSystemDataLink/Migrations/randomStudents.json";

        private const string coursesJsonPath =
            "../../../StudentSystemDataLink/Migrations/randomCourses.json";

        private const string homeworksJsonPath =
            "../../../StudentSystemDataLink/Migrations/randomHomework.json";

        public SeedingValues()
        {
            // Since the property Rnd is public the dependency is not so hidden...
            this.Rnd = new Random();
        }

        public Random Rnd { get; set; }

        public Task<Student[]> GetStudents()
        {
            return this.ReadDataAsync(new Student[0], studentsJsonPath);
        }

        public Task<Course[]> GetCourses()
        {
            return this.ReadDataAsync(new Course[0], coursesJsonPath);
        }

        public Task<Homework[]> GetHomeworks()
        {
            return this.ReadDataAsync(new Homework[0], homeworksJsonPath);
        }

        public void MakeDataAssociations(
            Student[] students, Course[] courses, Homework[] homeworks)
        {
            this.SetupCourses(courses, homeworks);

            this.SetupStudents(students, courses);
        }

        private void SetupStudents(Student[] students, Course[] courses)
        {
            foreach (Student student in students)
            {
                int coursesCount = this.Rnd.Next(2, 6);
                this.AddRandomCourses(student, coursesCount, courses);

                foreach (Course course in student.Courses)
                {
                    int homeworksCount = this.Rnd.Next(0, course.Homeworks.Count);
                    var homeworks = course.Homeworks.Take(homeworksCount);

                    foreach (Homework homework in homeworks)
                    {
                        student.Homeworks.Add(homework);
                    }
                }
            }
        }

        private void AddRandomCourses(Student student, int coursesCount, Course[] courses)
        {
            bool[] mask = new bool[courses.Length];

            int counter = 0;
            while (counter < coursesCount)
            {
                int courseIndex = this.Rnd.Next(0, mask.Length);
                if (mask[courseIndex])
                {
                    continue;
                }
                else
                {
                    mask[courseIndex] = true;
                    counter++;

                    student.Courses.Add(courses[courseIndex]);
                }
            }
        }

        private void SetupCourses(Course[] courses, Homework[] homeworks)
        {
            int nextHomeWork = 0;

            foreach (Course course in courses)
            {
                int homeworksCount = this.Rnd.Next(2, 6) + nextHomeWork;
                for (int i = nextHomeWork; i < homeworksCount && i < homeworks.Length; i++)
                {
                    course.Homeworks.Add(homeworks[i]);
                }

                nextHomeWork = homeworksCount;
            }
        }

        private async Task<TModel[]> ReadDataAsync<TModel>(TModel[] type, string path)
        {
            using (var inputStream = new StreamReader(path))
            {
                string json = await inputStream.ReadToEndAsync();

                return JsonConvert.DeserializeObject<TModel[]>(json);
            }
        }


    }
}
