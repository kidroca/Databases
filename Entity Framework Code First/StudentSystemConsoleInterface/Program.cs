using System.Data.Entity;

namespace StudentSystem.ConsoleInterface
{
    using System;
    using StudentSystem.DataLink;
    using StudentSystem.DataLink.Migrations;
    using StudentSystem.Models;

    /// <summary>
    /// Sorry I didn't make much use of the data but it was exausting to make the random generation methods
    /// </summary>
    public class Program
    {
        private static int affectedRows = 0;

        static void Main()
        {
            Database.SetInitializer(
                new MigrateDatabaseToLatestVersion<StudentsDbContext, Configuration>());

            using (var context = new StudentsDbContext())
            {
                var peshoStudent = new Student
                {
                    FirstName = "Pesho",
                    LastName = "Telerikov",
                    Email = "pesho@telerikacademy.com"
                };

                context.Students.Add(peshoStudent);

                affectedRows = context.SaveChanges();

                var someGuyOrGal = context.Students.Find(200);
                if (someGuyOrGal != null)
                {
                    Console.WriteLine(someGuyOrGal.ToString());
                }
            }

            Console.WriteLine("Completed! Affected Rows: {0}", affectedRows);
        }
    }
}
